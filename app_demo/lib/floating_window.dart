import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:window_manager/window_manager.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'globals.dart';
import 'i18n/strings.g.dart';
import 'audio_visualizer.dart';
import 'package:flutter/cupertino.dart';

/// 子窗口入口（由 desktop_multi_window 在 arguments == 'floating_bar' 时调用）
Future<void> floatingWindowMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  // 配置子窗口：透明、无边框、置顶
  const WindowOptions windowOptions = WindowOptions(
    size: Size(280, 90),
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.setHasShadow(false);
    await windowManager.setBackgroundColor(Colors.transparent);
    await windowManager.setAlwaysOnTop(true);
    // 窗口初始不可见，由 _showCapsule/_hideCapsule 控制 OS 级 opacity
    await windowManager.setOpacity(0.0);
    await windowManager.setIgnoreMouseEvents(true);
    await windowManager.show();
    // 定位到屏幕底部居中，再上移一点留出 Dock 空间
    await windowManager.setAlignment(Alignment.bottomCenter);
    final pos = await windowManager.getPosition();
    await windowManager.setPosition(Offset(pos.dx, pos.dy - 100));
  });

  // 子窗口不需要 Supabase，所有业务逻辑由主窗口处理
  // 仅恢复字体和语言用于 UI 显示
  final prefs = await SharedPreferences.getInstance();

  final savedFont = prefs.getString('app_font') ?? 'System';
  globalFontNotifier.value = savedFont;

  final savedLocale = prefs.getString('app_locale');
  if (savedLocale != null) {
    for (final locale in AppLocale.values) {
      if (locale.name == savedLocale) {
        LocaleSettings.setLocale(locale);
        break;
      }
    }
  }
  if (LocaleSettings.currentLocale == AppLocale.en && savedLocale != 'en') {
    await LocaleSettings.useDeviceLocale();
  }

  runApp(TranslationProvider(child: const FloatingBarApp()));
}

class FloatingBarApp extends StatelessWidget {
  const FloatingBarApp({Key? key}) : super(key: key);

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
          home: const FloatingBar(),
        );
      },
    );
  }
}

class FloatingBar extends StatefulWidget {
  const FloatingBar({Key? key}) : super(key: key);

  @override
  State<FloatingBar> createState() => _FloatingBarState();
}

class _FloatingBarState extends State<FloatingBar>
    with TickerProviderStateMixin {
  BubbleState _currentState = BubbleIdle();
  final _audioRecorder = AudioRecorder();
  String? _recordFilePath;
  int? _recordingStartTime;
  int _vadActiveFrames = 0;
  int _vadTotalFrames = 0;

  bool _isNetworkConnected = true;
  StreamSubscription? _connectivitySubscription;

  late AnimationController _pulseController;

  // 出入场动画控制器
  late AnimationController _capsuleController;
  late Animation<double> _opacityAnim;
  late Animation<double> _scaleAnim;
  bool _capsuleVisible = false;
  int _capsuleVersion = 0;  // 防止 show/hide 竞态的版本计数器

  StreamSubscription<Amplitude>? _amplitudeSubscription;
  double _currentAmplitude = 0.0;
  bool _isStoppingUpload = false; // 防止 stop 和 start 竞态
  bool _isRecorderStarted = false; // audioRecorder.start() 已完成

  HotKey _recordKey = HotKey(key: LogicalKeyboardKey.f5, modifiers: []);
  HotKey _translateKey = HotKey(key: LogicalKeyboardKey.f6, modifiers: []);

  // 与主窗口通信的 IPC channel
  final _ipcChannel =
      const WindowMethodChannel(kIpcChannelName, mode: ChannelMode.bidirectional);

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _capsuleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 0.0,
    );
    _opacityAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _capsuleController, curve: Curves.easeOut),
    );
    _scaleAnim = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _capsuleController, curve: Curves.easeOutBack),
    );

    _initIpc();
    _initFallbackHotkeys();
    globalSettingsNotifier.addListener(_onSettingsChanged);
    _checkAndRequestAccessibility();
    _initConnectivityMonitor();

    // 通知主窗口子窗口已就绪
    Future.microtask(() async {
      try {
        await _ipcChannel.invokeMethod('ready');
      } catch (e) {
        print('⚠️ [IPC] Failed to send ready signal: $e');
      }
    });
  }

  // ── 出入场动画 ──────────────────────────────────────────

  Future<void> _showCapsule() async {
    if (_capsuleVisible) return;
    _capsuleVisible = true;
    _capsuleVersion++;
    await windowManager.setOpacity(1.0).catchError((_) => null);
    await windowManager.setIgnoreMouseEvents(false).catchError((_) => null);
    _capsuleController.animateTo(1.0, duration: const Duration(milliseconds: 300));
  }

  Future<void> _hideCapsule() async {
    if (!_capsuleVisible) return;
    _capsuleVisible = false;
    // 记录此次隐藏的版本号，动画完成后检查是否被新的 _showCapsule 覆盖
    final hideVersion = ++_capsuleVersion;
    await _capsuleController.animateTo(0.0, duration: const Duration(milliseconds: 250));
    // 动画结束后检查：如果期间 _showCapsule 被调用（版本号变了），不应覆盖
    if (_capsuleVersion == hideVersion && !_capsuleVisible) {
      await windowManager.setIgnoreMouseEvents(true).catchError((_) => null);
      await windowManager.setOpacity(0.0).catchError((_) => null);
    }
  }

  /// 统一状态转移入口，替代所有直接 setState(() => _currentState = ...)
  void _transitionTo(BubbleState newState) {
    if (!mounted) return;
    setState(() => _currentState = newState);
    final shouldBeVisible = newState is! BubbleIdle;
    if (shouldBeVisible && !_capsuleVisible) {
      _showCapsule();
    } else if (!shouldBeVisible && _capsuleVisible) {
      _hideCapsule();
    }
  }

  // ── IPC ─────────────────────────────────────────────────

  void _initIpc() {
    _ipcChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'fn_event':
          final args = call.arguments as Map?;
          final method = args?['method'] as String?;
          final isTranslate = args?['isTranslate'] as bool? ?? false;
          if (method == 'fn_down') {
            print('🎯 [FloatingBar] 接收到 fn_down, isTranslate: $isTranslate');
            final targetMode = isTranslate ? PlayMode.translate : PlayMode.refine;
            if (_currentState is BubbleIdle || _currentState is BubblePasting) {
              _startRecording(mode: targetMode);
            } else if (_currentState is BubbleRecording) {
              if (isTranslate && (_currentState as BubbleRecording).mode == PlayMode.refine) {
                print('🎯 [FloatingBar] 录音中收到 Shift，立刻热切换为 translate 模式');
                if (mounted) {
                  setState(() => _currentState = BubbleRecording(PlayMode.translate));
                }
              }
            }
          } else if (method == 'fn_up') {
            print('🎯 [FloatingBar] 接收到 fn_up 信号');
            if (_currentState is BubbleRecording) {
              _stopAndUpload();
            }
          }
          break;
        case 'settings_changed':
          if (mounted) _initFallbackHotkeys();
          break;
        case 'status_update':
          // 主窗口发来的上传进度/结果回调
          _handleStatusUpdate(call.arguments as Map);
          break;
        case 'update_locale':
          // 主窗口触发的系统语言热更
          final newLocaleName = call.arguments as String;
          try {
            final newLocale = AppLocale.values.byName(newLocaleName);
            LocaleSettings.setLocale(newLocale);
            if (mounted) setState(() {});
          } catch (_) {}
          break;
      }
    });
  }

  /// 处理主窗口发来的上传状态更新
  void _handleStatusUpdate(Map args) {
    if (!mounted) return;
    final state = args['state'] as String? ?? '';

    // 提取当前 mode，贯穿整个生命周期的色彩隔离
    PlayMode currentMode = PlayMode.refine;
    if (_currentState is BubbleRecording) currentMode = (_currentState as BubbleRecording).mode;
    else if (_currentState is BubbleProcessing) currentMode = (_currentState as BubbleProcessing).mode;
    else if (_currentState is BubblePasting) currentMode = (_currentState as BubblePasting).mode;

    switch (state) {
      case 'uploading':
      case 'processing':
        _transitionTo(BubbleProcessing(currentMode));
        break;
      case 'pasting':
      case 'done':
      case 'idle':
        _transitionTo(BubbleIdle());
        break;
      case 'error':
        final message = args['message'] as String? ?? 'Unknown error';
        _transitionTo(BubbleError(message));
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted && _currentState is BubbleError) _transitionTo(BubbleIdle());
        });
        break;
    }
  }

  void _onSettingsChanged() {
    if (mounted) _initFallbackHotkeys();
  }

  void _initConnectivityMonitor() {
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((results) {
      final wasConnected = _isNetworkConnected;
      final isNowConnected = !results.contains(ConnectivityResult.none);
      if (mounted) {
        _isNetworkConnected = isNowConnected;
        if (!isNowConnected) {
          if (_currentState is BubbleRecording) {
            _audioRecorder.stop().catchError((_) => null);
            _pulseController.stop();
            _pulseController.reset();
            _stopAmplitudeMonitor();
          }
          _transitionTo(BubbleError('${t.status.network_disconnected_title}: ${t.status.network_disconnected_short}'));
        } else if (!wasConnected && isNowConnected) {
          _transitionTo(BubbleIdle());
        }
      }
    });
    Connectivity().checkConnectivity().then((results) {
      if (mounted) {
        setState(() {
          _isNetworkConnected = !results.contains(ConnectivityResult.none);
        });
      }
    });
  }

  void _checkAndRequestAccessibility() async {
    try {
      final bool isTrusted =
          await _ipcChannel.invokeMethod<bool>('check_accessibility') ?? false;
      if (!isTrusted) {
        print('⚠️ [Accessibility] Permission not granted.');
        if (mounted) {
          _transitionTo(BubbleError(t.status.accessibility_permission));
          await Future.delayed(const Duration(seconds: 5));
          if (mounted && _currentState is BubbleError) _transitionTo(BubbleIdle());
        }
      } else {
        print('✅ [Accessibility] Permission already granted.');
      }
    } catch (e) {
      print('❌ [Accessibility] Check failed: $e');
    }
  }

  @override
  void dispose() {
    _ipcChannel.setMethodCallHandler(null);
    _amplitudeSubscription?.cancel();
    _connectivitySubscription?.cancel();
    globalSettingsNotifier.removeListener(_onSettingsChanged);
    _pulseController.dispose();
    _capsuleController.dispose();
    super.dispose();
  }

  void _startAmplitudeMonitor() {
    _amplitudeSubscription?.cancel();
    _amplitudeSubscription = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 80))
        .listen((amp) {
      if (!mounted) return;
      // UI 展示用的平滑拉伸：把 -50 ~ 0 映射到 0 ~ 1 （稍微压制一点底噪在波形上的体现）
      final normalized = ((amp.current + 50.0) / 50.0).clamp(0.0, 1.0);
      _vadTotalFrames++;

      // VAD 严格判定：绝对音量大于 -38 dB 才会算作"有效人声帧"
      if (amp.current > -38.0) _vadActiveFrames++;

      setState(() {
        _currentAmplitude = normalized;
      });
    });
  }

  void _stopAmplitudeMonitor() {
    _amplitudeSubscription?.cancel();
    _amplitudeSubscription = null;
    if (mounted) setState(() => _currentAmplitude = 0.0);
  }

  void _initFallbackHotkeys() async {
    // 只注销我们自己的热键，不要调用 unregisterAll() 以避免影响主窗口的热键
    try {
      await hotKeyManager.unregister(_recordKey);
    } catch (_) {}
    try {
      await hotKeyManager.unregister(_translateKey);
    } catch (_) {}

    final prefs = await SharedPreferences.getInstance();

    final refineJson = prefs.getString('hotkey_refine');
    if (refineJson != null && refineJson.isNotEmpty) {
      try {
        _recordKey =
            HotKey.fromJson(jsonDecode(refineJson) as Map<String, dynamic>);
      } catch (e) {
        debugPrint('⚠️ [FloatingBar] Failed to parse hotkey_refine, using default: $e');
        _recordKey = HotKey(key: LogicalKeyboardKey.f5, modifiers: []);
      }
    } else {
      _recordKey = HotKey(key: LogicalKeyboardKey.f5, modifiers: []);
    }

    final translateJson = prefs.getString('hotkey_translate');
    if (translateJson != null && translateJson.isNotEmpty) {
      try {
        _translateKey =
            HotKey.fromJson(jsonDecode(translateJson) as Map<String, dynamic>);
      } catch (e) {
        debugPrint('⚠️ [FloatingBar] Failed to parse hotkey_translate, using default: $e');
        _translateKey = HotKey(key: LogicalKeyboardKey.f6, modifiers: []);
      }
    } else {
      _translateKey = HotKey(key: LogicalKeyboardKey.f6, modifiers: []);
    }

    await hotKeyManager.register(
      _recordKey,
      keyDownHandler: (hotKey) {
        if (_currentState is BubbleRecording) {
          _stopAndUpload();
        } else if (_currentState is BubbleIdle ||
            _currentState is BubblePasting) {
          _startRecording(mode: PlayMode.refine);
        }
      },
    );
    await hotKeyManager.register(
      _translateKey,
      keyDownHandler: (hotKey) {
        if (_currentState is BubbleRecording) {
          _stopAndUpload();
        } else if (_currentState is BubbleIdle ||
            _currentState is BubblePasting) {
          _startRecording(mode: PlayMode.translate);
        }
      },
    );
  }

  void _startRecording({required PlayMode mode}) async {
    print('🎙️ [FloatingBar] _startRecording 触发, Mode: $mode');
    if (_currentState is BubbleProcessing ||
        _currentState is BubbleRecording ||
        _isStoppingUpload) {
      print('⚠️ [FloatingBar] 当前被占用，忽略录音请求 ($_currentState, stopping=$_isStoppingUpload)');
      return;
    }

    try {
      print('🔄 [FloatingBar] 尝试保存前台应用...');
      _ipcChannel.invokeMethod('save_frontmost');
    } catch (_) {}

    if (!_isNetworkConnected) {
      if (mounted) {
        _transitionTo(BubbleError('${t.status.network_disconnected_title}: ${t.status.network_disconnected_desc}'));
      }
      await Future.delayed(const Duration(seconds: 2));
      if (mounted && _currentState is BubbleError) _transitionTo(BubbleIdle());
      return;
    }

    // 立即进入录音状态，让胶囊马上显示，不等异步操作
    _isRecorderStarted = false;
    _transitionTo(BubbleRecording(mode));
    _pulseController.repeat(reverse: true);

    try {
      if (!await _audioRecorder.hasPermission()) {
        if (!mounted) return;
        _pulseController.stop();
        _pulseController.reset();
        _transitionTo(BubbleError(t.status.mic_permission));
        await Future.delayed(const Duration(seconds: 3));
        if (mounted && _currentState is BubbleError) _transitionTo(BubbleIdle());
        return;
      }

      final dir = await getApplicationSupportDirectory();
      if (!await dir.exists()) await dir.create(recursive: true);
      // 用时间戳生成唯一文件名，避免并发录音覆盖
      final ts = DateTime.now().millisecondsSinceEpoch;
      _recordFilePath = '${dir.path}/record_$ts.m4a';

      await _audioRecorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 32000),
        path: _recordFilePath!,
      );
      _isRecorderStarted = true;
      _recordingStartTime = DateTime.now().millisecondsSinceEpoch;
      _vadActiveFrames = 0;
      _vadTotalFrames = 0;

      if (!mounted) return;
      _startAmplitudeMonitor();
    } catch (e) {
      _pulseController.stop();
      _pulseController.reset();
      if (mounted) {
        _transitionTo(BubbleError(e.toString().length > 50 ? e.toString().substring(0, 50) : e.toString()));
        await Future.delayed(const Duration(seconds: 3));
        if (mounted && _currentState is BubbleError) _transitionTo(BubbleIdle());
      }
    }
  }

  /// 停止录音 → VAD 检测 → 通过 IPC 将音频路径发送给主窗口处理
  void _stopAndUpload() async {
    if (_currentState is! BubbleRecording) return;
    if (_isStoppingUpload) return; // 防止并发：fn_up 重复触发时直接丢弃
    final currentMode = (_currentState as BubbleRecording).mode;
    _isStoppingUpload = true;

    // audioRecorder.start() 尚未完成时提前松开按键 → 丢弃，回到 Idle
    if (!_isRecorderStarted) {
      print('⚠️ [FloatingBar] Fn 松开时 recorder 尚未启动，丢弃本次录音');
      _isRecorderStarted = false;
      _isStoppingUpload = false;
      _pulseController.stop();
      _pulseController.reset();
      if (mounted) _transitionTo(BubbleIdle());
      return;
    }

    try {
      String? path;
      try {
        path = await _audioRecorder.stop().timeout(
          const Duration(seconds: 5),
          onTimeout: () => _recordFilePath,
        );
      } catch (stopError) {
        path = _recordFilePath;
      }
      _isRecorderStarted = false;
      _pulseController.stop();
      _pulseController.reset();
      _stopAmplitudeMonitor();

      if (mounted) {
        _transitionTo(BubbleProcessing(currentMode));
      }

      if (path == null) throw Exception(t.status.recording_failed);
      print('✅ [FloatingBar] 录音结束，路径: $path');

      // VAD 静音检测
      final audioFile = File(path);
      if (!await audioFile.exists()) {
        print('❌ [FloatingBar] 音频文件不存在，丢弃此任务。');
        if (mounted) _transitionTo(BubbleIdle());
        return;
      }
      final fileSize = await audioFile.length();
      final recordingDurationMs = DateTime.now().millisecondsSinceEpoch -
          (_recordingStartTime ?? DateTime.now().millisecondsSinceEpoch);
      final activeRatio =
          _vadTotalFrames > 0 ? (_vadActiveFrames / _vadTotalFrames) : 0.0;

      print('📊 [VAD 拦截分析] Size: $fileSize bytes, Time: ${recordingDurationMs}ms, 活跃占比: ${activeRatio.toStringAsFixed(2)} ($_vadActiveFrames/$_vadTotalFrames)');

      // 如果有效声音极其稀少（低于 15%）、录音时间小于 0.8s，或者没有产生有效文件大小，静默删去
      if (activeRatio < 0.15 || fileSize < 3000 || recordingDurationMs < 800) {
        print('🗑️ [VAD] 内容被判定为无效录音(时长太短或完全没声音) -> 静默废弃!');
        try { await audioFile.delete(); } catch (_) {}
        if (mounted) _transitionTo(BubbleIdle());
        return;
      }

      print('🚀 [FloatingBar] 有效录音，准备发送给主窗口上传');
      // 将音频路径发送给主窗口，由主窗口负责上传、解析、粘贴、保存历史
      _ipcChannel.invokeMethod('upload_audio', {
        'audioPath': path,
        'mode': currentMode == PlayMode.translate ? 'translate' : 'refine',
        'recordingDurationMs': recordingDurationMs,
      }).catchError((_) {});

    } catch (e) {
      debugPrint('❌ [FloatingBar] _stopAndUpload error: $e');
      _pulseController.stop();
      _pulseController.reset();
      _stopAmplitudeMonitor();
      try { await _audioRecorder.stop(); } catch (_) {}
      if (mounted) {
        _transitionTo(BubbleError(e.toString().length > 50 ? e.toString().substring(0, 50) : e.toString()));
        await Future.delayed(const Duration(seconds: 3));
        if (mounted && _currentState is BubbleError) _transitionTo(BubbleIdle());
      }
    } finally {
      _isRecorderStarted = false;
      _isStoppingUpload = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 解析当前模式和文字（覆盖所有 5 种状态）
    final PlayMode currentMode;
    final String labelText;

    if (_currentState is BubbleRecording) {
      currentMode = (_currentState as BubbleRecording).mode;
      labelText = currentMode == PlayMode.translate
          ? context.t.status.mode_translating
          : '';
    } else if (_currentState is BubbleProcessing) {
      currentMode = (_currentState as BubbleProcessing).mode;
      labelText = context.t.status.processing_short;
    } else if (_currentState is BubblePasting) {
      currentMode = (_currentState as BubblePasting).mode;
      final desc = (_currentState as BubblePasting).successDesc;
      labelText = desc.isNotEmpty ? desc : context.t.status.paste_success;
    } else if (_currentState is BubbleError) {
      currentMode = PlayMode.refine;
      labelText = (_currentState as BubbleError).msg;
    } else {
      currentMode = PlayMode.refine;
      labelText = '';
    }

    final highlightColor = currentMode == PlayMode.translate
        ? const Color(0xFF0A84FF) // Apple System Blue (Dark)
        : const Color(0xFFFF453A); // Apple System Red (Dark)

    // 纯黑灵动岛样式
    final borderColor = Colors.white.withOpacity(0.15);
    final shadows = [
      BoxShadow(color: highlightColor.withOpacity(0.15), blurRadius: 15, spreadRadius: 2),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: AnimatedBuilder(
          animation: _capsuleController,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnim.value,
              child: Transform.scale(
                scale: _scaleAnim.value,
                child: child,
              ),
            );
          },
          child: AnimatedSize(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutBack,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: borderColor, width: 0.5),
                boxShadow: shadows,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 左侧状态图标
                  if (_currentState is BubbleProcessing)
                    const CupertinoActivityIndicator(radius: 8)
                  else if (_currentState is BubbleError)
                    const Icon(Icons.error_outline_rounded, color: Color(0xFFFF453A), size: 16)
                  else if (_currentState is BubblePasting)
                    Icon(Icons.check_circle_rounded, color: highlightColor, size: 16)
                  else
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        final scale = _currentState is BubbleRecording
                            ? 0.8 + _pulseController.value * 0.4
                            : 1.0;
                        return Transform.scale(
                          scale: scale,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: highlightColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: highlightColor.withOpacity(0.4), blurRadius: 4),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                  // 中间文字
                  if (labelText.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Text(
                      labelText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],

                  // 右侧波形 (仅录音时显示)
                  if (_currentState is BubbleRecording) ...[
                    const SizedBox(width: 14),
                    AudioVisualizer(amplitude: _currentAmplitude, color: highlightColor),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
