import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:window_manager/window_manager.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'globals.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'usage_stats_service.dart';
import 'i18n/strings.g.dart';

import 'onboarding.dart';
import 'main_dashboard.dart';
import 'floating_window.dart';
import 'audio_upload_service.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  // desktop_multi_window：通过 arguments 区分主窗口还是子窗口
  final windowController = await WindowController.fromCurrentEngine();
  if (windowController.arguments == 'floating_bar') {
    await floatingWindowMain();
    return;
  }

  // ── 主窗口初始化 ──────────────────────────────────────────────────

  // 主窗口固定为 Dashboard 尺寸（登录前会被覆盖为 1000x700）
  const WindowOptions windowOptions = WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.white,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAlwaysOnTop(false);
    await windowManager.show();
    await windowManager.focus();
  });

  // 初始化全局快捷键（主窗口负责 Dashboard 热键，子窗口负责 F5/F6）
  await hotKeyManager.unregisterAll();

  // 加载 .env 配置
  await dotenv.load(fileName: '.env');

  final prefs = await SharedPreferences.getInstance();

  // 恢复字体
  final savedFont = prefs.getString('app_font') ?? 'System';
  globalFontNotifier.value = savedFont;

  // 恢复界面语言
  final savedLocale = prefs.getString('app_locale');
  bool localeRestored = false;
  if (savedLocale != null && savedLocale.isNotEmpty) {
    // 尝试精确匹配枚举名（如 "zhHans"）
    for (final locale in AppLocale.values) {
      if (locale.name == savedLocale) {
        LocaleSettings.setLocale(locale);
        localeRestored = true;
        break;
      }
    }
  }
  if (!localeRestored) {
    // 没有已保存的 locale 或匹配失败，使用设备语言
    await LocaleSettings.useDeviceLocale();
    // 仅在首次（prefs 无值）时写入，避免覆盖用户选择
    if (savedLocale == null) {
      await prefs.setString('app_locale', LocaleSettings.currentLocale.name);
    }
  }

  if (kDebugMode) {
    print('═══════════════════════════════════════════');
    print('🚀 [Main] 启动时 locale 信息:');
    print('   prefs 原始值: "$savedLocale"');
    print('   localeRestored: $localeRestored');
    print('   LocaleSettings.currentLocale: ${LocaleSettings.currentLocale.name}');
    print('═══════════════════════════════════════════');
  }

  runApp(TranslationProvider(child: const AudioTranslatorApp()));
}

class AudioTranslatorApp extends StatelessWidget {
  const AudioTranslatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: globalFontNotifier,
      builder: (context, currentFont, child) {
        TextTheme? fontTheme;
        if (currentFont == 'Inter') fontTheme = GoogleFonts.interTextTheme();
        else if (currentFont == 'Roboto') fontTheme = GoogleFonts.robotoTextTheme();
        else if (currentFont == 'Noto Sans SC') fontTheme = GoogleFonts.notoSansScTextTheme();

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF007AFF)),
            textTheme: fontTheme,
          ),
          home: const _AppRoot(),
        );
      },
    );
  }
}

class _AppRoot extends StatefulWidget {
  const _AppRoot();
  @override
  State<_AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<_AppRoot> with WindowListener, TrayListener {
  bool? _onboardingDone;
  DateTime _lastDashboardToggleTime = DateTime.fromMillisecondsSinceEpoch(0);

  // 子窗口管理
  WindowController? _subWindowController;
  bool _subWindowReady = false;

  // IPC channel（与子窗口双向通信）
  final _ipcChannel =
      const WindowMethodChannel(kIpcChannelName, mode: ChannelMode.bidirectional);

  // 与 AppDelegate 通信的 native channel（主窗口专用）
  static const _fnKeyChannel = MethodChannel('com.audiotyper.fn_key');

  // 音频上传服务（主窗口处理所有业务逻辑）
  late final AudioUploadService _uploadService;

  // Fn 键防抖时间戳（用于拦截 show_dashboard 的误触发）
  DateTime _lastFnActivityTime = DateTime.fromMillisecondsSinceEpoch(0);

  @override
  void initState() {
    super.initState();
    _uploadService = AudioUploadService(
      ipcChannel: _ipcChannel,
      fnKeyChannel: _fnKeyChannel,
      onStatsUpdated: () => usageUpdateNotifier.notifyUpdate(),
    );
    windowManager.addListener(this);
    trayManager.addListener(this);
    _initTray();
    _checkOnboarding();
    _registerDashboardHotkey();
    _initIpc();         // 先设置 IPC handler
    _initFnKeyChannel(); // 再设置 Fn key channel
    _initSubWindow();   // 最后创建子窗口
    
    // 监听设置变更，当用户在设置页切换语言时转发给子窗口
    globalSettingsNotifier.addListener(_onGlobalSettingsChanged);
  }

  // ── IPC 设置 ──────────────────────────────────────────────────────

  void _initIpc() {
    try {
    _ipcChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'ready':
          _subWindowReady = true;
          print('✅ [IPC] Sub-window is ready');
          break;
        case 'upload_audio':
          // 子窗口录音完成，主窗口处理上传+粘贴+历史
          final args = call.arguments as Map;
          await _uploadService.handleUpload(args);
          break;
        case 'save_frontmost':
          try {
            await _fnKeyChannel.invokeMethod('save_frontmost');
          } catch (e) {
            debugPrint('⚠️ [IPC] save_frontmost failed: $e');
          }
          break;
        case 'check_accessibility':
          try {
            return await _fnKeyChannel.invokeMethod('check_accessibility');
          } catch (e) {
            debugPrint('⚠️ [IPC] check_accessibility failed: $e');
            return false;
          }
      }
    });
    } catch (e) {
      debugPrint('⚠️ [IPC] Channel registration failed (reuse): $e');
    }
  }

  void _initFnKeyChannel() {
    _fnKeyChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'fn_down':
          _lastFnActivityTime = DateTime.now();
          if (!_subWindowReady) return;
          final args = call.arguments;
          final isTranslate =
              (args is Map) ? (args['isTranslate'] as bool? ?? false) : false;
          try {
            await _ipcChannel.invokeMethod(
                'fn_event', {'method': 'fn_down', 'isTranslate': isTranslate});
          } catch (e) {
            print('⚠️ [IPC] fn_event relay failed: $e');
          }
          break;
        case 'fn_up':
          _lastFnActivityTime = DateTime.now();
          if (!_subWindowReady) return;
          try {
            await _ipcChannel
                .invokeMethod('fn_event', {'method': 'fn_up'});
          } catch (e) {
            print('⚠️ [IPC] fn_up relay failed: $e');
          }
          break;
        case 'show_dashboard':
          // 拦截：Fn 键最近 2 秒内有活动，防止误触发
          final timeSinceFn =
              DateTime.now().difference(_lastFnActivityTime).inMilliseconds;
          if (timeSinceFn < 2000) {
            print('⚠️ [Dashboard] 拦截: Fn 键最近活动于 ${timeSinceFn}ms 前');
            return;
          }
          _showDashboardWindow();
          break;
      }
    });
  }

  Future<void> _initSubWindow() async {
    try {
      // 检查是否已有子窗口（重新登录时复用，避免 CHANNEL_LIMIT_REACHED）
      final existingWindows = await WindowController.getAll();
      if (existingWindows.length > 1) {
        // 已有子窗口，复用它
        _subWindowController = existingWindows.last;
        await _subWindowController!.show();
        print('♻️ [SubWindow] Reused existing, id: ${_subWindowController!.windowId}');
        return;
      }
      _subWindowController = await WindowController.create(
        const WindowConfiguration(
            arguments: 'floating_bar', hiddenAtLaunch: true),
      );
      print('✅ [SubWindow] Created, id: ${_subWindowController!.windowId}');
    } catch (e) {
      print('❌ [SubWindow] Failed to create: $e');
    }
  }

  /// 设置变更时，通过已验证可靠的 _ipcChannel 转发语言/设置变更给子窗口
  void _onGlobalSettingsChanged() {
    if (!_subWindowReady) return;
    // 转发当前语言
    final currentLocale = LocaleSettings.currentLocale.name;
    _ipcChannel.invokeMethod('update_locale', currentLocale).catchError((_) {});
    // 转发其它设置变更（如热键等）
    _ipcChannel.invokeMethod('settings_changed').catchError((_) {});
  }

  // ── Tray ─────────────────────────────────────────────────────────

  void _initTray() async {
    await trayManager.setIcon('assets/app_icon.png');
    final menu = Menu(
      items: [
        MenuItem(key: 'show_dashboard', label: '显示主工作台 (Alt+Cmd+S)'),
        MenuItem.separator(),
        MenuItem(key: 'exit_app', label: '退出'),
      ],
    );
    await trayManager.setContextMenu(menu);
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    if (menuItem.key == 'show_dashboard') {
      _showDashboardWindow();
    } else if (menuItem.key == 'exit_app') {
      exit(0);
    }
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  // ── Window ───────────────────────────────────────────────────────

  void _registerDashboardHotkey() async {
    final hotKey = HotKey(
        key: LogicalKeyboardKey.keyS,
        modifiers: [HotKeyModifier.alt, HotKeyModifier.meta]);
    await hotKeyManager.register(
      hotKey,
      keyDownHandler: (_) => _showDashboardWindow(),
    );
  }

  void _showDashboardWindow() async {
    // 防重入 500ms
    final now = DateTime.now();
    if (now.difference(_lastDashboardToggleTime).inMilliseconds < 500) return;
    _lastDashboardToggleTime = now;

    await windowManager.setAlwaysOnTop(false);
    await windowManager.setOpacity(1.0);
    await windowManager.setIgnoreMouseEvents(false);
    await windowManager.setSize(const Size(800, 600));
    await windowManager.center();
    await windowManager.show();
    await windowManager.focus();
  }

  @override
  void onWindowFocus() {}

  Future<void> _checkOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final done = prefs.getBool('onboarding_done') ?? false;
    if (!done) {
      await windowManager.setAlwaysOnTop(true);
      await windowManager.setSize(const Size(360, 540));
      await windowManager.center();
    }
    if (mounted) setState(() => _onboardingDone = done);
  }

  Future<void> _completeOnboarding() async {
    await windowManager.setAlwaysOnTop(false);
    await windowManager.setSize(const Size(800, 600));
    await windowManager.center();
    if (mounted) setState(() => _onboardingDone = true);
  }

  @override
  void dispose() {
    globalSettingsNotifier.removeListener(_onGlobalSettingsChanged);
    _fnKeyChannel.setMethodCallHandler(null);
    _ipcChannel.setMethodCallHandler(null);
    trayManager.removeListener(this);
    windowManager.removeListener(this);
    // 隐藏子窗口（不销毁，因为引擎无法销毁）
    _subWindowController?.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_onboardingDone == null) return const SizedBox.shrink();
    if (!_onboardingDone!) {
      return OnboardingScreen(onComplete: _completeOnboarding);
    }
    return MainDashboard(onClose: () async {
      await windowManager.hide();
    });
  }
}
