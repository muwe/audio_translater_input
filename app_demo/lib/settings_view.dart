import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'i18n/strings.g.dart';
import 'globals.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _launchAtStartup = false;
  String _targetLanguage = '英语';
  String _serverRegion = 'us';
  String _appFont = 'System';
  AppLocale _appLocale = LocaleSettings.currentLocale;
  
  final List<String> _languages = ['英语', '简体中文', '繁体中文', '日语', '韩语', '法语', '德语', '俄语', '西班牙语', '意大利语', '葡萄牙语', '荷兰语', '阿拉伯语', '土耳其语', '瑞典语', '印地语', '泰语', '越南语', '印尼语'];
  final List<String> _fonts = ['System', 'Inter', 'Roboto', 'Noto Sans SC'];

  HotKey? _refineHotKey;
  HotKey? _translateHotKey;

  final _groqKeyCtrl = TextEditingController();
  final _openRouterKeyCtrl = TextEditingController();
  final _siliconFlowKeyCtrl = TextEditingController();
  final _openAiKeyCtrl = TextEditingController();
  bool _showGroqKey = false;
  bool _showOpenRouterKey = false;
  bool _showSiliconFlowKey = false;
  bool _showOpenAiKey = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load Startup setting
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    LaunchAtStartup.instance.setup(
      appName: packageInfo.appName,
      appPath: Platform.resolvedExecutable,
    );
    try {
      _launchAtStartup = await LaunchAtStartup.instance.isEnabled();
    } catch (e) {
      debugPrint('⚠️ [Settings] launch_at_startup plugin unavailable: $e');
      _launchAtStartup = false;
    }

    // Load language and region
    final savedTargetLang = prefs.getString('target_language');
    if (savedTargetLang != null && _languages.contains(savedTargetLang)) {
      _targetLanguage = savedTargetLang;
    } else {
      _targetLanguage = '英语';
    }
    _serverRegion = prefs.getString('server_region') ?? 'us';
    
    // Load font
    _appFont = prefs.getString('app_font') ?? 'System';

    // Load App Language
    final savedLocale = prefs.getString('app_locale');
    if (savedLocale != null) {
      try {
        _appLocale = AppLocale.values.byName(savedLocale);
      } catch (_) {
        _appLocale = LocaleSettings.currentLocale;
      }
    } else {
      _appLocale = LocaleSettings.currentLocale;
    }

    // Load hotkeys (with fallback on malformed JSON)
    final refineJson = prefs.getString('hotkey_refine');
    if (refineJson != null && refineJson.isNotEmpty) {
      try {
        _refineHotKey = HotKey.fromJson(jsonDecode(refineJson) as Map<String, dynamic>);
      } catch (e) {
        debugPrint('⚠️ [Settings] Failed to parse hotkey_refine: $e');
        await prefs.remove('hotkey_refine');
      }
    }

    final translateJson = prefs.getString('hotkey_translate');
    if (translateJson != null && translateJson.isNotEmpty) {
      try {
        _translateHotKey = HotKey.fromJson(jsonDecode(translateJson) as Map<String, dynamic>);
      } catch (e) {
        debugPrint('⚠️ [Settings] Failed to parse hotkey_translate: $e');
        await prefs.remove('hotkey_translate');
      }
    }

    _groqKeyCtrl.text = prefs.getString('groq_api_key') ?? '';
    _openRouterKeyCtrl.text = prefs.getString('openrouter_api_key') ?? '';
    _siliconFlowKeyCtrl.text = prefs.getString('siliconflow_api_key') ?? '';
    _openAiKeyCtrl.text = prefs.getString('openai_api_key') ?? '';

    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _groqKeyCtrl.dispose();
    _openRouterKeyCtrl.dispose();
    _siliconFlowKeyCtrl.dispose();
    _openAiKeyCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveApiKey(String prefKey, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefKey, value);
  }

  Widget _buildApiKeyField({
    required String title,
    required String subtitle,
    required String prefKey,
    required TextEditingController controller,
    required bool showKey,
    required VoidCallback onToggleVisibility,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black45)),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            obscureText: !showKey,
            style: const TextStyle(fontSize: 13, fontFamily: 'monospace'),
            decoration: InputDecoration(
              hintText: 'Enter API key...',
              hintStyle: const TextStyle(color: Colors.black26),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
              ),
              suffixIcon: IconButton(
                icon: Icon(showKey ? Icons.visibility_off : Icons.visibility, size: 18, color: Colors.black45),
                onPressed: onToggleVisibility,
              ),
            ),
            onChanged: (value) => _saveApiKey(prefKey, value),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleStartup(bool value) async {
    setState(() => _launchAtStartup = value);
    if (value) {
      await LaunchAtStartup.instance.enable();
    } else {
      await LaunchAtStartup.instance.disable();
    }
  }

  Future<void> _changeLanguage(String? newValue) async {
    if (newValue == null) return;
    setState(() => _targetLanguage = newValue);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('target_language', newValue);
  }

  Future<void> _changeRegion(String? newValue) async {
    if (newValue == null) return;
    setState(() => _serverRegion = newValue);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('server_region', newValue);
    globalSettingsNotifier.value++;
  }

  Future<void> _changeFont(String? newValue) async {
    if (newValue == null) return;
    setState(() => _appFont = newValue);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_font', newValue);
    globalFontNotifier.value = newValue;
  }

  Future<void> _changeLocale(AppLocale? newLocale) async {
    if (newLocale == null) return;
    setState(() => _appLocale = newLocale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_locale', newLocale.name);
    LocaleSettings.setLocale(newLocale);
    globalSettingsNotifier.value++;
  }

  String _getNativeLocaleName(AppLocale locale) {
    switch (locale) {
      case AppLocale.en: return 'English';
      case AppLocale.zhHans: return '简体中文';
      case AppLocale.zhHant: return '繁體中文';
      case AppLocale.ja: return '日本語';
      case AppLocale.de: return 'Deutsch';
      case AppLocale.es: return 'Español';
    }
  }

  String _getLocalizedLocaleName(AppLocale locale, Translations t) {
    switch (locale) {
      case AppLocale.en: return t.locales.en;
      case AppLocale.zhHans: return t.locales.zhHans;
      case AppLocale.zhHant: return t.locales.zhHant;
      case AppLocale.ja: return t.locales.ja;
      case AppLocale.de: return t.locales.de;
      case AppLocale.es: return t.locales.es;
    }
  }

  String _translateTargetLanguage(String langValue, Translations t) {
    switch (langValue) {
      case '英语': return t.settings.target_languages.en;
      case '简体中文': return t.settings.target_languages.zh_Hans;
      case '繁体中文': return t.settings.target_languages.zh_Hant;
      case '日语': return t.settings.target_languages.ja;
      case '韩语': return t.settings.target_languages.ko;
      case '法语': return t.settings.target_languages.fr;
      case '德语': return t.settings.target_languages.de;
      case '俄语': return t.settings.target_languages.ru;
      case '西班牙语': return t.settings.target_languages.es;
      case '意大利语': return t.settings.target_languages.it;
      case '葡萄牙语': return t.settings.target_languages.pt;
      case '荷兰语': return t.settings.target_languages.nl;
      case '阿拉伯语': return t.settings.target_languages.ar;
      case '土耳其语': return t.settings.target_languages.tr;
      case '瑞典语': return t.settings.target_languages.sv;
      case '印地语': return t.settings.target_languages.hi;
      case '泰语': return t.settings.target_languages.th;
      case '越南语': return t.settings.target_languages.vi;
      case '印尼语': return t.settings.target_languages.id;
      default: return langValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(context.t.settings.title, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87, letterSpacing: -0.8)),
        const SizedBox(height: 8),
        Text(context.t.settings.subtitle, style: const TextStyle(fontSize: 14, color: Colors.black54)),
        const SizedBox(height: 40),

        _buildSectionHeader(Icons.format_paint_rounded, context.t.settings.ui_settings.title),
        const SizedBox(height: 16),
        _buildSettingCard(
          title: context.t.settings.ui_settings.app_language.title,
          subtitle: context.t.settings.ui_settings.app_language.subtitle,
          trailing: DropdownButton<AppLocale>(
            value: _appLocale,
            underline: const SizedBox(),
            itemHeight: 64,
            items: AppLocale.values.map((locale) {
              final nativeName = _getNativeLocaleName(locale);
              final localizedName = _getLocalizedLocaleName(locale, context.t);
              
              return DropdownMenuItem(
                value: locale, 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(nativeName, style: const TextStyle(fontSize: 15, color: Colors.black87)),
                    const SizedBox(height: 2),
                    Text(localizedName, style: const TextStyle(fontSize: 12, color: Colors.black45)),
                  ],
                ),
              );
            }).toList(),
            onChanged: _changeLocale,
          ),
        ),
        const SizedBox(height: 16),
        _buildSettingCard(
          title: context.t.settings.ui_settings.font.title,
          subtitle: context.t.settings.ui_settings.font.subtitle,
          trailing: DropdownButton<String>(
            value: _appFont,
            underline: const SizedBox(),
            itemHeight: 64, // 增加高度以容纳两行文字
            items: _fonts.map((e) {
              TextStyle? style;
              if (e == 'Inter') style = GoogleFonts.inter();
              if (e == 'Roboto') style = GoogleFonts.roboto();
              if (e == 'Noto Sans SC') style = GoogleFonts.notoSansSc();
              return DropdownMenuItem(
                value: e, 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(e, style: const TextStyle(fontSize: 12, color: Colors.black45)),
                    const SizedBox(height: 2),
                    Text(e, style: style?.copyWith(fontSize: 15, color: Colors.black87) ?? const TextStyle(fontSize: 15, color: Colors.black87)),
                  ],
                ),
              );
            }).toList(),
            onChanged: _changeFont,
          ),
        ),

        const SizedBox(height: 32),
        _buildSectionHeader(Icons.rocket_launch_rounded, context.t.settings.system_settings.title),
        const SizedBox(height: 16),
        _buildSettingCard(
          title: context.t.settings.system_settings.startup.title,
          subtitle: context.t.settings.system_settings.startup.subtitle,
          trailing: Switch.adaptive(
            value: _launchAtStartup,
            onChanged: _toggleStartup,
            activeColor: const Color(0xFF007AFF),
          ),
        ),
        const SizedBox(height: 12),
        _buildSettingCard(
          title: context.t.settings.system_settings.backend.title,
          subtitle: context.t.settings.system_settings.backend.subtitle,
          trailing: DropdownButton<String>(
            value: _serverRegion,
            underline: const SizedBox(),
            items: [
              DropdownMenuItem(value: 'us', child: Text(context.t.settings.system_settings.backend.us)),
              DropdownMenuItem(value: 'cn', child: Text(context.t.settings.system_settings.backend.cn)),
            ],
            onChanged: _changeRegion,
          ),
        ),

        const SizedBox(height: 32),
        _buildSectionHeader(Icons.keyboard_command_key_rounded, context.t.settings.hotkeys.title),
        const SizedBox(height: 16),
        _buildSettingCard(
          title: context.t.settings.hotkeys.refine.title,
          subtitle: context.t.settings.hotkeys.refine.subtitle,
          trailing: _buildHotKeyButton(
            hotKey: _refineHotKey,
            onPressed: () => _showRecordDialog(context.t.settings.hotkeys.refine.title, isRefine: true),
          ),
        ),
        const SizedBox(height: 12),
        _buildSettingCard(
          title: context.t.settings.hotkeys.translate.title,
          subtitle: context.t.settings.hotkeys.translate.subtitle,
          trailing: _buildHotKeyButton(
            hotKey: _translateHotKey,
            onPressed: () => _showRecordDialog(context.t.settings.hotkeys.translate.title, isRefine: false),
          ),
        ),

        const SizedBox(height: 32),
        _buildSectionHeader(Icons.translate_rounded, context.t.settings.translation.title),
        const SizedBox(height: 16),
        _buildSettingCard(
          title: context.t.settings.translation.target_lang.title,
          subtitle: context.t.settings.translation.target_lang.subtitle,
          trailing: DropdownButton<String>(
            value: _targetLanguage,
            underline: const SizedBox(),
            items: _languages.map((e) => DropdownMenuItem(value: e, child: Text(_translateTargetLanguage(e, context.t)))).toList(),
            onChanged: _changeLanguage,
          ),
        ),

        const SizedBox(height: 32),
        _buildSectionHeader(Icons.key_rounded, 'API Keys'),
        const SizedBox(height: 16),
        _buildApiKeyField(
          title: 'Groq API Key',
          subtitle: 'US region ASR (whisper-large-v3)',
          prefKey: 'groq_api_key',
          controller: _groqKeyCtrl,
          showKey: _showGroqKey,
          onToggleVisibility: () => setState(() => _showGroqKey = !_showGroqKey),
        ),
        const SizedBox(height: 12),
        _buildApiKeyField(
          title: 'OpenRouter API Key',
          subtitle: 'US region LLM (gpt-4o-mini)',
          prefKey: 'openrouter_api_key',
          controller: _openRouterKeyCtrl,
          showKey: _showOpenRouterKey,
          onToggleVisibility: () => setState(() => _showOpenRouterKey = !_showOpenRouterKey),
        ),
        const SizedBox(height: 12),
        _buildApiKeyField(
          title: 'SiliconFlow API Key',
          subtitle: 'CN region ASR + LLM (SenseVoice / Qwen2.5)',
          prefKey: 'siliconflow_api_key',
          controller: _siliconFlowKeyCtrl,
          showKey: _showSiliconFlowKey,
          onToggleVisibility: () => setState(() => _showSiliconFlowKey = !_showSiliconFlowKey),
        ),
        const SizedBox(height: 12),
        _buildApiKeyField(
          title: 'OpenAI API Key',
          subtitle: 'Fallback ASR + LLM (optional)',
          prefKey: 'openai_api_key',
          controller: _openAiKeyCtrl,
          showKey: _showOpenAiKey,
          onToggleVisibility: () => setState(() => _showOpenAiKey = !_showOpenAiKey),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF007AFF)),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }

  Widget _buildSettingCard({required String title, required String subtitle, required Widget trailing}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.03)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black45)),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildHotKeyButton({required HotKey? hotKey, required VoidCallback onPressed}) {
    String label = context.t.settings.hotkeys.click_to_set;
    if (hotKey != null) {
      final keys = [
        if (hotKey.modifiers != null && hotKey.modifiers!.isNotEmpty)
          ...hotKey.modifiers!.map((m) => m.name.toUpperCase()),
        hotKey.key.keyLabel.toUpperCase(),
      ];
      label = keys.join(' + ');
    }
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(color: Colors.black.withValues(alpha: 0.1)),
      ),
      child: Text(label, style: const TextStyle(color: Colors.black87)),
    );
  }

  void _showRecordDialog(String title, {required bool isRefine}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: Text(context.t.settings.hotkeys.record_title(title: title)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(context.t.settings.hotkeys.record_desc),
              const SizedBox(height: 20),
              HotKeyRecorder(
                initalHotKey: isRefine ? _refineHotKey : _translateHotKey,
                onHotKeyRecorded: (hotKey) async {
                  final prefs = await SharedPreferences.getInstance();
                  final keyName = isRefine ? 'hotkey_refine' : 'hotkey_translate';
                  
                  await prefs.setString(keyName, jsonEncode(hotKey.toJson()));
                  
                  if (isRefine) {
                    setState(() => _refineHotKey = hotKey);
                  } else {
                    setState(() => _translateHotKey = hotKey);
                  }
                  globalSettingsNotifier.value++;
                  
                  if (mounted) Navigator.pop(ctx);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(context.t.settings.hotkeys.cancel),
            ),
          ],
        );
      },
    );
  }
}
