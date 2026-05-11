///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsZhHans with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZhHans({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zhHans,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-Hans>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZhHans _root = this; // ignore: unused_field

	@override 
	TranslationsZhHans $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZhHans(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsStatusZhHans status = _TranslationsStatusZhHans._(_root);
	@override late final _TranslationsCommonZhHans common = _TranslationsCommonZhHans._(_root);
	@override late final _TranslationsLocalesZhHans locales = _TranslationsLocalesZhHans._(_root);
	@override late final _TranslationsSettingsZhHans settings = _TranslationsSettingsZhHans._(_root);
	@override late final _TranslationsDashboardZhHans dashboard = _TranslationsDashboardZhHans._(_root);
	@override late final _TranslationsHistoryZhHans history = _TranslationsHistoryZhHans._(_root);
	@override late final _TranslationsOnboardingZhHans onboarding = _TranslationsOnboardingZhHans._(_root);
	@override late final _TranslationsVocabZhHans vocab = _TranslationsVocabZhHans._(_root);
}

// Path: status
class _TranslationsStatusZhHans implements TranslationsStatusEn {
	_TranslationsStatusZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get idle => '按 Fn 录音';
	@override String get translating => '🌐 翻译中... (松开 Fn 停止)';
	@override String get listening => '🎤 聆听中... (松开 Fn 停止)';
	@override String get network_disconnected_title => '🔴 网络未连接';
	@override String get network_disconnected_desc => '请检查网络连接';
	@override String get network_disconnected_short => '网络未连接';
	@override String get accessibility_permission => '自动粘贴需辅助功能权限，请在系统设置中授予';
	@override String get mic_permission => '麦克风未授权';
	@override String get processing => '✨ 处理中...';
	@override String get paste_success => '✅ 粘贴成功';
	@override String paste_success_times({required Object asrSec, required Object llmSec}) => '✅ [ASR: ${asrSec}s | LLM: ${llmSec}s]';
	@override String get mode_recording => '录音';
	@override String get mode_translating => '翻译';
	@override String get recording_failed => '录音启动失败';
	@override String get no_voice_detected => '未检测到人声';
	@override String get processing_short => '处理中';
}

// Path: common
class _TranslationsCommonZhHans implements TranslationsCommonEn {
	_TranslationsCommonZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String min_sec({required Object min, required Object sec}) => '${min}分 ${sec}秒';
	@override String hour_min({required Object hour, required Object min}) => '${hour}时 ${min}分';
	@override String n_minutes({required Object n}) => '${n} 分钟';
	@override String n_hours({required Object n, required Object min}) => '${n} 小时 ${min} 分';
}

// Path: locales
class _TranslationsLocalesZhHans implements TranslationsLocalesEn {
	_TranslationsLocalesZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get en => '英语';
	@override String get zhHans => '简体中文';
	@override String get zhHant => '繁体中文';
	@override String get ja => '日语';
	@override String get de => '德语';
	@override String get es => '西班牙语';
}

// Path: settings
class _TranslationsSettingsZhHans implements TranslationsSettingsEn {
	_TranslationsSettingsZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '应用设置';
	@override String get subtitle => '定制属于你自己的输入体验。';
	@override late final _TranslationsSettingsUiSettingsZhHans ui_settings = _TranslationsSettingsUiSettingsZhHans._(_root);
	@override late final _TranslationsSettingsSystemSettingsZhHans system_settings = _TranslationsSettingsSystemSettingsZhHans._(_root);
	@override late final _TranslationsSettingsHotkeysZhHans hotkeys = _TranslationsSettingsHotkeysZhHans._(_root);
	@override late final _TranslationsSettingsTranslationZhHans translation = _TranslationsSettingsTranslationZhHans._(_root);
	@override late final _TranslationsSettingsTargetLanguagesZhHans target_languages = _TranslationsSettingsTargetLanguagesZhHans._(_root);
}

// Path: dashboard
class _TranslationsDashboardZhHans implements TranslationsDashboardEn {
	_TranslationsDashboardZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDashboardSidebarZhHans sidebar = _TranslationsDashboardSidebarZhHans._(_root);
	@override late final _TranslationsDashboardHomeZhHans home = _TranslationsDashboardHomeZhHans._(_root);
	@override String get chars_unit => '字';
	@override String get unlimited => '无限';
}

// Path: history
class _TranslationsHistoryZhHans implements TranslationsHistoryEn {
	_TranslationsHistoryZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '历史创作记录';
	@override String time_saved({required Object time}) => '累计为您挽回了 ${time} 的打字时间。';
	@override String get empty => '暂无记录\n按 Fn 键开始你的第一次语音转写';
	@override String get mode_translate => '外语翻译';
	@override String get mode_refine => '母语润色';
	@override String get asr_label => '🎙️ 录音识别: ';
	@override String get llm_label => '✨ 智能润色: ';
	@override String seconds({required Object seconds}) => '${seconds} 秒';
	@override String minutes({required Object minutes}) => '${minutes} 分钟';
	@override late final _TranslationsHistoryPeriodZhHans period = _TranslationsHistoryPeriodZhHans._(_root);
	@override late final _TranslationsHistoryKpiZhHans kpi = _TranslationsHistoryKpiZhHans._(_root);
}

// Path: onboarding
class _TranslationsOnboardingZhHans implements TranslationsOnboardingEn {
	_TranslationsOnboardingZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get step1_title => '自然说话，完美书写';
	@override String get step1_subtitle => '只需长按 Fn 开始录音\n松开后自动润色并粘贴至活动窗口';
	@override String get step1_action => '下一步';
	@override String get step2_title => '授权麦克风';
	@override String get step2_action => '授权系统权限';
	@override String get step3_title => '开启辅助功能';
	@override String get step3_subtitle => '为了体验「无感输入」\n请在系统安全与隐私中为 Audio Translate Input 开启辅助功能';
	@override String get step3_action => '验证系统权限';
	@override String get step4_title => '实战演练';
	@override String get step4_subtitle => '一切就绪！现在请长按 Fn 随便说一句话\n准备迎接全新的效率革命';
	@override String get step4_action => '开始旅程';
	@override String get skip => '跳过向导';
	@override String get mic_permission_subtitle => 'Audio Translate Input 需要麦克风权限\n才能将您的语音转换为精准文字';
	@override String get complete_trial => '完成试用';
	@override String get hold_fn_hint => '按住 Fn 键说点什么...';
	@override String get listening => '聆听中...（请自由说话）';
	@override String get refining => '润色中...';
	@override String get trial_success => '试用成功！这就是 Audio Translate Input 的魔力。';
	@override String get click_to_simulate => '（您可以点击此区域模拟按键）';
	@override String get accessibility_warning => '辅助功能权限未授予。请在弹出的系统设置对话框中启用 Audio Translate Input。';
}

// Path: vocab
class _TranslationsVocabZhHans implements TranslationsVocabEn {
	_TranslationsVocabZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '个人词典';
	@override String get subtitle => '教 AI 学会你的习惯用语';
	@override String get add_title => '添加自定义表达';
	@override String get spoken_hint => '你说的话（口语形式）';
	@override String get written_hint => '你想写的（书面形式）';
	@override String get add_btn => '添加';
	@override String get empty => '还没有自定义表达';
}

// Path: settings.ui_settings
class _TranslationsSettingsUiSettingsZhHans implements TranslationsSettingsUiSettingsEn {
	_TranslationsSettingsUiSettingsZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '界面设置';
	@override late final _TranslationsSettingsUiSettingsAppLanguageZhHans app_language = _TranslationsSettingsUiSettingsAppLanguageZhHans._(_root);
	@override late final _TranslationsSettingsUiSettingsFontZhHans font = _TranslationsSettingsUiSettingsFontZhHans._(_root);
}

// Path: settings.system_settings
class _TranslationsSettingsSystemSettingsZhHans implements TranslationsSettingsSystemSettingsEn {
	_TranslationsSettingsSystemSettingsZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '系统设置';
	@override late final _TranslationsSettingsSystemSettingsStartupZhHans startup = _TranslationsSettingsSystemSettingsStartupZhHans._(_root);
	@override late final _TranslationsSettingsSystemSettingsBackendZhHans backend = _TranslationsSettingsSystemSettingsBackendZhHans._(_root);
}

// Path: settings.hotkeys
class _TranslationsSettingsHotkeysZhHans implements TranslationsSettingsHotkeysEn {
	_TranslationsSettingsHotkeysZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '快捷键与触发';
	@override late final _TranslationsSettingsHotkeysRefineZhHans refine = _TranslationsSettingsHotkeysRefineZhHans._(_root);
	@override late final _TranslationsSettingsHotkeysTranslateZhHans translate = _TranslationsSettingsHotkeysTranslateZhHans._(_root);
	@override String get click_to_set => '点击设置快捷键';
	@override String get cancel => '取消';
	@override String record_title({required Object title}) => '录制 ${title} 快捷键';
	@override String get record_desc => '请直接在键盘上按下您想要的组合键...';
}

// Path: settings.translation
class _TranslationsSettingsTranslationZhHans implements TranslationsSettingsTranslationEn {
	_TranslationsSettingsTranslationZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '翻译引擎策略';
	@override late final _TranslationsSettingsTranslationTargetLangZhHans target_lang = _TranslationsSettingsTranslationTargetLangZhHans._(_root);
}

// Path: settings.target_languages
class _TranslationsSettingsTargetLanguagesZhHans implements TranslationsSettingsTargetLanguagesEn {
	_TranslationsSettingsTargetLanguagesZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get en => '英语';
	@override String get ja => '日语';
	@override String get ko => '韩语';
	@override String get fr => '法语';
	@override String get de => '德语';
	@override String get ru => '俄语';
	@override String get es => '西班牙语';
	@override String get it => '意大利语';
	@override String get pt => '葡萄牙语';
	@override String get nl => '荷兰语';
	@override String get ar => '阿拉伯语';
	@override String get tr => '土耳其语';
	@override String get sv => '瑞典语';
	@override String get hi => '印地语';
	@override String get th => '泰语';
	@override String get vi => '越南语';
	@override String get id => '印尼语';
	@override String get zh_Hans => '简体中文';
	@override String get zh_Hant => '繁体中文';
}

// Path: dashboard.sidebar
class _TranslationsDashboardSidebarZhHans implements TranslationsDashboardSidebarEn {
	_TranslationsDashboardSidebarZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get home => '首页';
	@override String get history => '历史';
	@override String get settings => '设置';
}

// Path: dashboard.home
class _TranslationsDashboardHomeZhHans implements TranslationsDashboardHomeEn {
	_TranslationsDashboardHomeZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get greeting => '你好，创作者';
	@override String get subtitle => '今日聚焦，心流已就绪';
	@override late final _TranslationsDashboardHomeGuideZhHans guide = _TranslationsDashboardHomeGuideZhHans._(_root);
	@override late final _TranslationsDashboardHomeStatsZhHans stats = _TranslationsDashboardHomeStatsZhHans._(_root);
}

// Path: history.period
class _TranslationsHistoryPeriodZhHans implements TranslationsHistoryPeriodEn {
	_TranslationsHistoryPeriodZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get today => '今日';
	@override String get week => '本周';
	@override String get month => '本月';
	@override String get all => '累计';
}

// Path: history.kpi
class _TranslationsHistoryKpiZhHans implements TranslationsHistoryKpiEn {
	_TranslationsHistoryKpiZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get usage_time => '使用时长';
	@override String get chars => '生成字数';
	@override String get time_saved => '节省时间';
	@override String get requests => '总请求数';
	@override String get refine => '润色次数';
	@override String get translate => '翻译次数';
}

// Path: settings.ui_settings.app_language
class _TranslationsSettingsUiSettingsAppLanguageZhHans implements TranslationsSettingsUiSettingsAppLanguageEn {
	_TranslationsSettingsUiSettingsAppLanguageZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '应用界面语言';
	@override String get subtitle => '切换应用程序的整体语言';
}

// Path: settings.ui_settings.font
class _TranslationsSettingsUiSettingsFontZhHans implements TranslationsSettingsUiSettingsFontEn {
	_TranslationsSettingsUiSettingsFontZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '显示字体';
	@override String get subtitle => '全局更改所有的文本显示字体';
}

// Path: settings.system_settings.startup
class _TranslationsSettingsSystemSettingsStartupZhHans implements TranslationsSettingsSystemSettingsStartupEn {
	_TranslationsSettingsSystemSettingsStartupZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '开机自动启动';
	@override String get subtitle => '在登录系统后自动在后台运行，随时待命';
}

// Path: settings.system_settings.backend
class _TranslationsSettingsSystemSettingsBackendZhHans implements TranslationsSettingsSystemSettingsBackendEn {
	_TranslationsSettingsSystemSettingsBackendZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '后端处理节点';
	@override String get subtitle => '欧美极速节点 (Groq) 或 国内合规节点 (硅基流动)';
	@override String get us => '欧美地区 (US/Europe)';
	@override String get cn => '中国国内 (China)';
}

// Path: settings.hotkeys.refine
class _TranslationsSettingsHotkeysRefineZhHans implements TranslationsSettingsHotkeysRefineEn {
	_TranslationsSettingsHotkeysRefineZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '基础优化模式 (Toggle)';
	@override String get subtitle => '如果不想长按原生 Fn 键，可以在此绑定一个全局切换按键';
}

// Path: settings.hotkeys.translate
class _TranslationsSettingsHotkeysTranslateZhHans implements TranslationsSettingsHotkeysTranslateEn {
	_TranslationsSettingsHotkeysTranslateZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '全局翻译模式 (Toggle)';
	@override String get subtitle => '说话即刻翻译为目标外语输出';
}

// Path: settings.translation.target_lang
class _TranslationsSettingsTranslationTargetLangZhHans implements TranslationsSettingsTranslationTargetLangEn {
	_TranslationsSettingsTranslationTargetLangZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '目标外语选择';
	@override String get subtitle => '当触发翻译模式时，默认被翻译成的语种';
}

// Path: dashboard.home.guide
class _TranslationsDashboardHomeGuideZhHans implements TranslationsDashboardHomeGuideEn {
	_TranslationsDashboardHomeGuideZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '快速上手指南';
	@override late final _TranslationsDashboardHomeGuideVoiceInputZhHans voice_input = _TranslationsDashboardHomeGuideVoiceInputZhHans._(_root);
	@override late final _TranslationsDashboardHomeGuideRealtimeTranslateZhHans realtime_translate = _TranslationsDashboardHomeGuideRealtimeTranslateZhHans._(_root);
	@override late final _TranslationsDashboardHomeGuideSmartFormatZhHans smart_format = _TranslationsDashboardHomeGuideSmartFormatZhHans._(_root);
}

// Path: dashboard.home.stats
class _TranslationsDashboardHomeStatsZhHans implements TranslationsDashboardHomeStatsEn {
	_TranslationsDashboardHomeStatsZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get focus_performance => '专注表现';
	@override String hours({required Object hours}) => '${hours} 小时';
	@override List<String> get days => [
		'周一',
		'周二',
		'周三',
		'周四',
		'周五',
		'周六',
		'周日',
	];
	@override String get goal_reached => '今日灵感达成';
	@override String processed_words({required Object words}) => '处理字数 ${words}';
}

// Path: dashboard.home.guide.voice_input
class _TranslationsDashboardHomeGuideVoiceInputZhHans implements TranslationsDashboardHomeGuideVoiceInputEn {
	_TranslationsDashboardHomeGuideVoiceInputZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '单击 Fn 语音输入';
	@override String get desc => '在任何文本框中按住 Fn 说话，松开后自动润色并粘贴。';
}

// Path: dashboard.home.guide.realtime_translate
class _TranslationsDashboardHomeGuideRealtimeTranslateZhHans implements TranslationsDashboardHomeGuideRealtimeTranslateEn {
	_TranslationsDashboardHomeGuideRealtimeTranslateZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => 'Shift + Fn 实时翻译';
	@override String get desc => '按住 Shift 再按住 Fn 进行中英互译。';
}

// Path: dashboard.home.guide.smart_format
class _TranslationsDashboardHomeGuideSmartFormatZhHans implements TranslationsDashboardHomeGuideSmartFormatEn {
	_TranslationsDashboardHomeGuideSmartFormatZhHans._(this._root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '智能排版助手';
	@override String get desc => '系统会自动记录你的高频短语和写作风格。';
}

/// The flat map containing all translations for locale <zh-Hans>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZhHans {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'status.idle' => '按 Fn 录音',
			'status.translating' => '🌐 翻译中... (松开 Fn 停止)',
			'status.listening' => '🎤 聆听中... (松开 Fn 停止)',
			'status.network_disconnected_title' => '🔴 网络未连接',
			'status.network_disconnected_desc' => '请检查网络连接',
			'status.network_disconnected_short' => '网络未连接',
			'status.accessibility_permission' => '自动粘贴需辅助功能权限，请在系统设置中授予',
			'status.mic_permission' => '麦克风未授权',
			'status.processing' => '✨ 处理中...',
			'status.paste_success' => '✅ 粘贴成功',
			'status.paste_success_times' => ({required Object asrSec, required Object llmSec}) => '✅ [ASR: ${asrSec}s | LLM: ${llmSec}s]',
			'status.mode_recording' => '录音',
			'status.mode_translating' => '翻译',
			'status.recording_failed' => '录音启动失败',
			'status.no_voice_detected' => '未检测到人声',
			'status.processing_short' => '处理中',
			'common.min_sec' => ({required Object min, required Object sec}) => '${min}分 ${sec}秒',
			'common.hour_min' => ({required Object hour, required Object min}) => '${hour}时 ${min}分',
			'common.n_minutes' => ({required Object n}) => '${n} 分钟',
			'common.n_hours' => ({required Object n, required Object min}) => '${n} 小时 ${min} 分',
			'locales.en' => '英语',
			'locales.zhHans' => '简体中文',
			'locales.zhHant' => '繁体中文',
			'locales.ja' => '日语',
			'locales.de' => '德语',
			'locales.es' => '西班牙语',
			'settings.title' => '应用设置',
			'settings.subtitle' => '定制属于你自己的输入体验。',
			'settings.ui_settings.title' => '界面设置',
			'settings.ui_settings.app_language.title' => '应用界面语言',
			'settings.ui_settings.app_language.subtitle' => '切换应用程序的整体语言',
			'settings.ui_settings.font.title' => '显示字体',
			'settings.ui_settings.font.subtitle' => '全局更改所有的文本显示字体',
			'settings.system_settings.title' => '系统设置',
			'settings.system_settings.startup.title' => '开机自动启动',
			'settings.system_settings.startup.subtitle' => '在登录系统后自动在后台运行，随时待命',
			'settings.system_settings.backend.title' => '后端处理节点',
			'settings.system_settings.backend.subtitle' => '欧美极速节点 (Groq) 或 国内合规节点 (硅基流动)',
			'settings.system_settings.backend.us' => '欧美地区 (US/Europe)',
			'settings.system_settings.backend.cn' => '中国国内 (China)',
			'settings.hotkeys.title' => '快捷键与触发',
			'settings.hotkeys.refine.title' => '基础优化模式 (Toggle)',
			'settings.hotkeys.refine.subtitle' => '如果不想长按原生 Fn 键，可以在此绑定一个全局切换按键',
			'settings.hotkeys.translate.title' => '全局翻译模式 (Toggle)',
			'settings.hotkeys.translate.subtitle' => '说话即刻翻译为目标外语输出',
			'settings.hotkeys.click_to_set' => '点击设置快捷键',
			'settings.hotkeys.cancel' => '取消',
			'settings.hotkeys.record_title' => ({required Object title}) => '录制 ${title} 快捷键',
			'settings.hotkeys.record_desc' => '请直接在键盘上按下您想要的组合键...',
			'settings.translation.title' => '翻译引擎策略',
			'settings.translation.target_lang.title' => '目标外语选择',
			'settings.translation.target_lang.subtitle' => '当触发翻译模式时，默认被翻译成的语种',
			'settings.target_languages.en' => '英语',
			'settings.target_languages.ja' => '日语',
			'settings.target_languages.ko' => '韩语',
			'settings.target_languages.fr' => '法语',
			'settings.target_languages.de' => '德语',
			'settings.target_languages.ru' => '俄语',
			'settings.target_languages.es' => '西班牙语',
			'settings.target_languages.it' => '意大利语',
			'settings.target_languages.pt' => '葡萄牙语',
			'settings.target_languages.nl' => '荷兰语',
			'settings.target_languages.ar' => '阿拉伯语',
			'settings.target_languages.tr' => '土耳其语',
			'settings.target_languages.sv' => '瑞典语',
			'settings.target_languages.hi' => '印地语',
			'settings.target_languages.th' => '泰语',
			'settings.target_languages.vi' => '越南语',
			'settings.target_languages.id' => '印尼语',
			'settings.target_languages.zh_Hans' => '简体中文',
			'settings.target_languages.zh_Hant' => '繁体中文',
			'dashboard.sidebar.home' => '首页',
			'dashboard.sidebar.history' => '历史',
			'dashboard.sidebar.settings' => '设置',
			'dashboard.home.greeting' => '你好，创作者',
			'dashboard.home.subtitle' => '今日聚焦，心流已就绪',
			'dashboard.home.guide.title' => '快速上手指南',
			'dashboard.home.guide.voice_input.title' => '单击 Fn 语音输入',
			'dashboard.home.guide.voice_input.desc' => '在任何文本框中按住 Fn 说话，松开后自动润色并粘贴。',
			'dashboard.home.guide.realtime_translate.title' => 'Shift + Fn 实时翻译',
			'dashboard.home.guide.realtime_translate.desc' => '按住 Shift 再按住 Fn 进行中英互译。',
			'dashboard.home.guide.smart_format.title' => '智能排版助手',
			'dashboard.home.guide.smart_format.desc' => '系统会自动记录你的高频短语和写作风格。',
			'dashboard.home.stats.focus_performance' => '专注表现',
			'dashboard.home.stats.hours' => ({required Object hours}) => '${hours} 小时',
			'dashboard.home.stats.days.0' => '周一',
			'dashboard.home.stats.days.1' => '周二',
			'dashboard.home.stats.days.2' => '周三',
			'dashboard.home.stats.days.3' => '周四',
			'dashboard.home.stats.days.4' => '周五',
			'dashboard.home.stats.days.5' => '周六',
			'dashboard.home.stats.days.6' => '周日',
			'dashboard.home.stats.goal_reached' => '今日灵感达成',
			'dashboard.home.stats.processed_words' => ({required Object words}) => '处理字数 ${words}',
			'dashboard.chars_unit' => '字',
			'dashboard.unlimited' => '无限',
			'history.title' => '历史创作记录',
			'history.time_saved' => ({required Object time}) => '累计为您挽回了 ${time} 的打字时间。',
			'history.empty' => '暂无记录\n按 Fn 键开始你的第一次语音转写',
			'history.mode_translate' => '外语翻译',
			'history.mode_refine' => '母语润色',
			'history.asr_label' => '🎙️ 录音识别: ',
			'history.llm_label' => '✨ 智能润色: ',
			'history.seconds' => ({required Object seconds}) => '${seconds} 秒',
			'history.minutes' => ({required Object minutes}) => '${minutes} 分钟',
			'history.period.today' => '今日',
			'history.period.week' => '本周',
			'history.period.month' => '本月',
			'history.period.all' => '累计',
			'history.kpi.usage_time' => '使用时长',
			'history.kpi.chars' => '生成字数',
			'history.kpi.time_saved' => '节省时间',
			'history.kpi.requests' => '总请求数',
			'history.kpi.refine' => '润色次数',
			'history.kpi.translate' => '翻译次数',
			'onboarding.step1_title' => '自然说话，完美书写',
			'onboarding.step1_subtitle' => '只需长按 Fn 开始录音\n松开后自动润色并粘贴至活动窗口',
			'onboarding.step1_action' => '下一步',
			'onboarding.step2_title' => '授权麦克风',
			'onboarding.step2_action' => '授权系统权限',
			'onboarding.step3_title' => '开启辅助功能',
			'onboarding.step3_subtitle' => '为了体验「无感输入」\n请在系统安全与隐私中为 Audio Translate Input 开启辅助功能',
			'onboarding.step3_action' => '验证系统权限',
			'onboarding.step4_title' => '实战演练',
			'onboarding.step4_subtitle' => '一切就绪！现在请长按 Fn 随便说一句话\n准备迎接全新的效率革命',
			'onboarding.step4_action' => '开始旅程',
			'onboarding.skip' => '跳过向导',
			'onboarding.mic_permission_subtitle' => 'Audio Translate Input 需要麦克风权限\n才能将您的语音转换为精准文字',
			'onboarding.complete_trial' => '完成试用',
			'onboarding.hold_fn_hint' => '按住 Fn 键说点什么...',
			'onboarding.listening' => '聆听中...（请自由说话）',
			'onboarding.refining' => '润色中...',
			'onboarding.trial_success' => '试用成功！这就是 Audio Translate Input 的魔力。',
			'onboarding.click_to_simulate' => '（您可以点击此区域模拟按键）',
			'onboarding.accessibility_warning' => '辅助功能权限未授予。请在弹出的系统设置对话框中启用 Audio Translate Input。',
			'vocab.title' => '个人词典',
			'vocab.subtitle' => '教 AI 学会你的习惯用语',
			'vocab.add_title' => '添加自定义表达',
			'vocab.spoken_hint' => '你说的话（口语形式）',
			'vocab.written_hint' => '你想写的（书面形式）',
			'vocab.add_btn' => '添加',
			'vocab.empty' => '还没有自定义表达',
			_ => null,
		};
	}
}
