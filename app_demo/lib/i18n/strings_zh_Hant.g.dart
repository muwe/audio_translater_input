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
class TranslationsZhHant with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZhHant({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zhHant,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-Hant>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZhHant _root = this; // ignore: unused_field

	@override 
	TranslationsZhHant $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZhHant(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsStatusZhHant status = _TranslationsStatusZhHant._(_root);
	@override late final _TranslationsCommonZhHant common = _TranslationsCommonZhHant._(_root);
	@override late final _TranslationsLocalesZhHant locales = _TranslationsLocalesZhHant._(_root);
	@override late final _TranslationsSettingsZhHant settings = _TranslationsSettingsZhHant._(_root);
	@override late final _TranslationsDashboardZhHant dashboard = _TranslationsDashboardZhHant._(_root);
	@override late final _TranslationsHistoryZhHant history = _TranslationsHistoryZhHant._(_root);
	@override late final _TranslationsOnboardingZhHant onboarding = _TranslationsOnboardingZhHant._(_root);
	@override late final _TranslationsVocabZhHant vocab = _TranslationsVocabZhHant._(_root);
}

// Path: status
class _TranslationsStatusZhHant implements TranslationsStatusEn {
	_TranslationsStatusZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get idle => '按 Fn 錄音';
	@override String get translating => '🌐 翻譯中... (鬆開 Fn 停止)';
	@override String get listening => '🎤 聆聽中... (鬆開 Fn 停止)';
	@override String get network_disconnected_title => '🔴 網路未連接';
	@override String get network_disconnected_desc => '請檢查網路連接';
	@override String get network_disconnected_short => '網路未連接';
	@override String get accessibility_permission => '自動貼上需輔助功能權限，請在系統設定中授予';
	@override String get mic_permission => '麥克風未授權';
	@override String get processing => '✨ 處理中...';
	@override String get paste_success => '✅ 貼上成功';
	@override String paste_success_times({required Object asrSec, required Object llmSec}) => '✅ [ASR: ${asrSec}s | LLM: ${llmSec}s]';
	@override String get mode_recording => '錄音';
	@override String get mode_translating => '翻譯';
	@override String get recording_failed => '錄音啟動失敗';
	@override String get no_voice_detected => '未檢測到人聲';
	@override String get processing_short => '處理中';
}

// Path: common
class _TranslationsCommonZhHant implements TranslationsCommonEn {
	_TranslationsCommonZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String min_sec({required Object min, required Object sec}) => '${min}分 ${sec}秒';
	@override String hour_min({required Object hour, required Object min}) => '${hour}時 ${min}分';
	@override String n_minutes({required Object n}) => '${n} 分鐘';
	@override String n_hours({required Object n, required Object min}) => '${n} 小時 ${min} 分';
}

// Path: locales
class _TranslationsLocalesZhHant implements TranslationsLocalesEn {
	_TranslationsLocalesZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get en => '英語';
	@override String get zhHans => '簡體中文';
	@override String get zhHant => '繁體中文';
	@override String get ja => '日語';
	@override String get de => '德語';
	@override String get es => '西班牙語';
}

// Path: settings
class _TranslationsSettingsZhHant implements TranslationsSettingsEn {
	_TranslationsSettingsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '應用程式設定';
	@override String get subtitle => '自訂屬於您的輸入體驗。';
	@override late final _TranslationsSettingsUiSettingsZhHant ui_settings = _TranslationsSettingsUiSettingsZhHant._(_root);
	@override late final _TranslationsSettingsSystemSettingsZhHant system_settings = _TranslationsSettingsSystemSettingsZhHant._(_root);
	@override late final _TranslationsSettingsHotkeysZhHant hotkeys = _TranslationsSettingsHotkeysZhHant._(_root);
	@override late final _TranslationsSettingsTranslationZhHant translation = _TranslationsSettingsTranslationZhHant._(_root);
	@override late final _TranslationsSettingsTargetLanguagesZhHant target_languages = _TranslationsSettingsTargetLanguagesZhHant._(_root);
}

// Path: dashboard
class _TranslationsDashboardZhHant implements TranslationsDashboardEn {
	_TranslationsDashboardZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDashboardSidebarZhHant sidebar = _TranslationsDashboardSidebarZhHant._(_root);
	@override late final _TranslationsDashboardHomeZhHant home = _TranslationsDashboardHomeZhHant._(_root);
	@override String get chars_unit => '字';
	@override String get unlimited => '無限';
}

// Path: history
class _TranslationsHistoryZhHant implements TranslationsHistoryEn {
	_TranslationsHistoryZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '歷史創作記錄';
	@override String time_saved({required Object time}) => '累計為您挽回了 ${time} 的打字時間。';
	@override String get empty => '暫無記錄\n按 Fn 鍵開始您的第一次語音轉寫';
	@override String get mode_translate => '外語翻譯';
	@override String get mode_refine => '母語潤飾';
	@override String get asr_label => '🎙️ 錄音辨識: ';
	@override String get llm_label => '✨ 智慧潤飾: ';
	@override String seconds({required Object seconds}) => '${seconds} 秒';
	@override String minutes({required Object minutes}) => '${minutes} 分鐘';
	@override late final _TranslationsHistoryPeriodZhHant period = _TranslationsHistoryPeriodZhHant._(_root);
	@override late final _TranslationsHistoryKpiZhHant kpi = _TranslationsHistoryKpiZhHant._(_root);
}

// Path: onboarding
class _TranslationsOnboardingZhHant implements TranslationsOnboardingEn {
	_TranslationsOnboardingZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get step1_title => '自然說話，完美書寫';
	@override String get step1_subtitle => '只需長按 Fn 開始錄音\n鬆開後自動潤色並貼上至活動視窗';
	@override String get step1_action => '下一步';
	@override String get step2_title => '授權麥克風';
	@override String get step2_action => '授權系統權限';
	@override String get step3_title => '開啟輔助功能';
	@override String get step3_subtitle => '為了體驗「無感輸入」\n請在系統安全與隱私中為 Audio Translate Input 開啟輔助功能';
	@override String get step3_action => '驗證系統權限';
	@override String get step4_title => '實戰演練';
	@override String get step4_subtitle => '一切就緒！現在請長按 Fn 隨便說一句話\n準備迎接全新的效率革命';
	@override String get step4_action => '開始旅程';
	@override String get skip => '跳過導覽';
	@override String get mic_permission_subtitle => 'Audio Translate Input 需要麥克風權限\n才能將您的語音轉換為精準文字';
	@override String get complete_trial => '完成試用';
	@override String get hold_fn_hint => '按住 Fn 鍵說點什麼...';
	@override String get listening => '聆聽中...（請自由說話）';
	@override String get refining => '潤飾中...';
	@override String get trial_success => '試用成功！這就是 Audio Translate Input 的魔力。';
	@override String get click_to_simulate => '（您可以點擊此區域模擬按鍵）';
	@override String get accessibility_warning => '輔助功能權限未授予。請在彈出的系統設定對話框中啟用 Audio Translate Input。';
}

// Path: vocab
class _TranslationsVocabZhHant implements TranslationsVocabEn {
	_TranslationsVocabZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '個人詞典';
	@override String get subtitle => '教 AI 學會你的慣用語';
	@override String get add_title => '新增自訂表達';
	@override String get spoken_hint => '你說的話（口語形式）';
	@override String get written_hint => '你想寫的（書面形式）';
	@override String get add_btn => '新增';
	@override String get empty => '還沒有自訂表達';
}

// Path: settings.ui_settings
class _TranslationsSettingsUiSettingsZhHant implements TranslationsSettingsUiSettingsEn {
	_TranslationsSettingsUiSettingsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '介面設定';
	@override late final _TranslationsSettingsUiSettingsAppLanguageZhHant app_language = _TranslationsSettingsUiSettingsAppLanguageZhHant._(_root);
	@override late final _TranslationsSettingsUiSettingsFontZhHant font = _TranslationsSettingsUiSettingsFontZhHant._(_root);
}

// Path: settings.system_settings
class _TranslationsSettingsSystemSettingsZhHant implements TranslationsSettingsSystemSettingsEn {
	_TranslationsSettingsSystemSettingsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '系統設定';
	@override late final _TranslationsSettingsSystemSettingsStartupZhHant startup = _TranslationsSettingsSystemSettingsStartupZhHant._(_root);
	@override late final _TranslationsSettingsSystemSettingsBackendZhHant backend = _TranslationsSettingsSystemSettingsBackendZhHant._(_root);
}

// Path: settings.hotkeys
class _TranslationsSettingsHotkeysZhHant implements TranslationsSettingsHotkeysEn {
	_TranslationsSettingsHotkeysZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '快速鍵與觸發';
	@override late final _TranslationsSettingsHotkeysRefineZhHant refine = _TranslationsSettingsHotkeysRefineZhHant._(_root);
	@override late final _TranslationsSettingsHotkeysTranslateZhHant translate = _TranslationsSettingsHotkeysTranslateZhHant._(_root);
	@override String get click_to_set => '點擊設定快速鍵';
	@override String get cancel => '取消';
	@override String record_title({required Object title}) => '錄製 ${title} 快速鍵';
	@override String get record_desc => '請直接在鍵盤上按下您想要的組合鍵...';
}

// Path: settings.translation
class _TranslationsSettingsTranslationZhHant implements TranslationsSettingsTranslationEn {
	_TranslationsSettingsTranslationZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '翻譯引擎策略';
	@override late final _TranslationsSettingsTranslationTargetLangZhHant target_lang = _TranslationsSettingsTranslationTargetLangZhHant._(_root);
}

// Path: settings.target_languages
class _TranslationsSettingsTargetLanguagesZhHant implements TranslationsSettingsTargetLanguagesEn {
	_TranslationsSettingsTargetLanguagesZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get en => '英語';
	@override String get ja => '日語';
	@override String get ko => '韓語';
	@override String get fr => '法語';
	@override String get de => '德語';
	@override String get ru => '俄語';
	@override String get es => '西班牙語';
	@override String get it => '義大利語';
	@override String get pt => '葡萄牙語';
	@override String get nl => '荷蘭語';
	@override String get ar => '阿拉伯語';
	@override String get tr => '土耳其語';
	@override String get sv => '瑞典語';
	@override String get hi => '印地語';
	@override String get th => '泰語';
	@override String get vi => '越南語';
	@override String get id => '印尼語';
	@override String get zh_Hans => '簡體中文';
	@override String get zh_Hant => '繁體中文';
}

// Path: dashboard.sidebar
class _TranslationsDashboardSidebarZhHant implements TranslationsDashboardSidebarEn {
	_TranslationsDashboardSidebarZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get home => '首頁';
	@override String get history => '歷史';
	@override String get settings => '設定';
}

// Path: dashboard.home
class _TranslationsDashboardHomeZhHant implements TranslationsDashboardHomeEn {
	_TranslationsDashboardHomeZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get greeting => '你好，創作者';
	@override String get subtitle => '今日聚焦，心流已就緒';
	@override late final _TranslationsDashboardHomeGuideZhHant guide = _TranslationsDashboardHomeGuideZhHant._(_root);
	@override late final _TranslationsDashboardHomeStatsZhHant stats = _TranslationsDashboardHomeStatsZhHant._(_root);
}

// Path: history.period
class _TranslationsHistoryPeriodZhHant implements TranslationsHistoryPeriodEn {
	_TranslationsHistoryPeriodZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get today => '今日';
	@override String get week => '本週';
	@override String get month => '本月';
	@override String get all => '累計';
}

// Path: history.kpi
class _TranslationsHistoryKpiZhHant implements TranslationsHistoryKpiEn {
	_TranslationsHistoryKpiZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get usage_time => '使用時長';
	@override String get chars => '生成字數';
	@override String get time_saved => '節省時間';
	@override String get requests => '總請求數';
	@override String get refine => '潤飾次數';
	@override String get translate => '翻譯次數';
}

// Path: settings.ui_settings.app_language
class _TranslationsSettingsUiSettingsAppLanguageZhHant implements TranslationsSettingsUiSettingsAppLanguageEn {
	_TranslationsSettingsUiSettingsAppLanguageZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '應用程式介面語言';
	@override String get subtitle => '切換應用程式的整體語言';
}

// Path: settings.ui_settings.font
class _TranslationsSettingsUiSettingsFontZhHant implements TranslationsSettingsUiSettingsFontEn {
	_TranslationsSettingsUiSettingsFontZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '顯示字型';
	@override String get subtitle => '全域變更所有的文字顯示字型';
}

// Path: settings.system_settings.startup
class _TranslationsSettingsSystemSettingsStartupZhHant implements TranslationsSettingsSystemSettingsStartupEn {
	_TranslationsSettingsSystemSettingsStartupZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '開機自動啟動';
	@override String get subtitle => '在登入系統後自動在背景執行，隨時待命';
}

// Path: settings.system_settings.backend
class _TranslationsSettingsSystemSettingsBackendZhHant implements TranslationsSettingsSystemSettingsBackendEn {
	_TranslationsSettingsSystemSettingsBackendZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '後端處理節點';
	@override String get subtitle => '歐美極速節點 (Groq) 或 國內合規節點 (矽基流動)';
	@override String get us => '歐美地區 (US/Europe)';
	@override String get cn => '中國國內 (China)';
}

// Path: settings.hotkeys.refine
class _TranslationsSettingsHotkeysRefineZhHant implements TranslationsSettingsHotkeysRefineEn {
	_TranslationsSettingsHotkeysRefineZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '基礎最佳化模式 (Toggle)';
	@override String get subtitle => '如果不想長按原生 Fn 鍵，可以在此綁定一個全域切換按鍵';
}

// Path: settings.hotkeys.translate
class _TranslationsSettingsHotkeysTranslateZhHant implements TranslationsSettingsHotkeysTranslateEn {
	_TranslationsSettingsHotkeysTranslateZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '全域翻譯模式 (Toggle)';
	@override String get subtitle => '說話即刻翻譯為目標外語輸出';
}

// Path: settings.translation.target_lang
class _TranslationsSettingsTranslationTargetLangZhHant implements TranslationsSettingsTranslationTargetLangEn {
	_TranslationsSettingsTranslationTargetLangZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '目標外語選擇';
	@override String get subtitle => '當觸發翻譯模式時，預設被翻譯成的語種';
}

// Path: dashboard.home.guide
class _TranslationsDashboardHomeGuideZhHant implements TranslationsDashboardHomeGuideEn {
	_TranslationsDashboardHomeGuideZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '快速上手指南';
	@override late final _TranslationsDashboardHomeGuideVoiceInputZhHant voice_input = _TranslationsDashboardHomeGuideVoiceInputZhHant._(_root);
	@override late final _TranslationsDashboardHomeGuideRealtimeTranslateZhHant realtime_translate = _TranslationsDashboardHomeGuideRealtimeTranslateZhHant._(_root);
	@override late final _TranslationsDashboardHomeGuideSmartFormatZhHant smart_format = _TranslationsDashboardHomeGuideSmartFormatZhHant._(_root);
}

// Path: dashboard.home.stats
class _TranslationsDashboardHomeStatsZhHant implements TranslationsDashboardHomeStatsEn {
	_TranslationsDashboardHomeStatsZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get focus_performance => '專注表現';
	@override String hours({required Object hours}) => '${hours} 小時';
	@override List<String> get days => [
		'週一',
		'週二',
		'週三',
		'週四',
		'週五',
		'週六',
		'週日',
	];
	@override String get goal_reached => '今日靈感達成';
	@override String processed_words({required Object words}) => '處理字數 ${words}';
}

// Path: dashboard.home.guide.voice_input
class _TranslationsDashboardHomeGuideVoiceInputZhHant implements TranslationsDashboardHomeGuideVoiceInputEn {
	_TranslationsDashboardHomeGuideVoiceInputZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '點擊 Fn 語音輸入';
	@override String get desc => '在任何文字方塊中按住 Fn 說話，鬆開後自動潤飾並貼上。';
}

// Path: dashboard.home.guide.realtime_translate
class _TranslationsDashboardHomeGuideRealtimeTranslateZhHant implements TranslationsDashboardHomeGuideRealtimeTranslateEn {
	_TranslationsDashboardHomeGuideRealtimeTranslateZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => 'Shift + Fn 即時翻譯';
	@override String get desc => '按住 Shift 再按住 Fn 進行中英互譯。';
}

// Path: dashboard.home.guide.smart_format
class _TranslationsDashboardHomeGuideSmartFormatZhHant implements TranslationsDashboardHomeGuideSmartFormatEn {
	_TranslationsDashboardHomeGuideSmartFormatZhHant._(this._root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '智慧排版助手';
	@override String get desc => '系統會自動記錄你的高頻短語和寫作風格。';
}

/// The flat map containing all translations for locale <zh-Hant>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZhHant {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'status.idle' => '按 Fn 錄音',
			'status.translating' => '🌐 翻譯中... (鬆開 Fn 停止)',
			'status.listening' => '🎤 聆聽中... (鬆開 Fn 停止)',
			'status.network_disconnected_title' => '🔴 網路未連接',
			'status.network_disconnected_desc' => '請檢查網路連接',
			'status.network_disconnected_short' => '網路未連接',
			'status.accessibility_permission' => '自動貼上需輔助功能權限，請在系統設定中授予',
			'status.mic_permission' => '麥克風未授權',
			'status.processing' => '✨ 處理中...',
			'status.paste_success' => '✅ 貼上成功',
			'status.paste_success_times' => ({required Object asrSec, required Object llmSec}) => '✅ [ASR: ${asrSec}s | LLM: ${llmSec}s]',
			'status.mode_recording' => '錄音',
			'status.mode_translating' => '翻譯',
			'status.recording_failed' => '錄音啟動失敗',
			'status.no_voice_detected' => '未檢測到人聲',
			'status.processing_short' => '處理中',
			'common.min_sec' => ({required Object min, required Object sec}) => '${min}分 ${sec}秒',
			'common.hour_min' => ({required Object hour, required Object min}) => '${hour}時 ${min}分',
			'common.n_minutes' => ({required Object n}) => '${n} 分鐘',
			'common.n_hours' => ({required Object n, required Object min}) => '${n} 小時 ${min} 分',
			'locales.en' => '英語',
			'locales.zhHans' => '簡體中文',
			'locales.zhHant' => '繁體中文',
			'locales.ja' => '日語',
			'locales.de' => '德語',
			'locales.es' => '西班牙語',
			'settings.title' => '應用程式設定',
			'settings.subtitle' => '自訂屬於您的輸入體驗。',
			'settings.ui_settings.title' => '介面設定',
			'settings.ui_settings.app_language.title' => '應用程式介面語言',
			'settings.ui_settings.app_language.subtitle' => '切換應用程式的整體語言',
			'settings.ui_settings.font.title' => '顯示字型',
			'settings.ui_settings.font.subtitle' => '全域變更所有的文字顯示字型',
			'settings.system_settings.title' => '系統設定',
			'settings.system_settings.startup.title' => '開機自動啟動',
			'settings.system_settings.startup.subtitle' => '在登入系統後自動在背景執行，隨時待命',
			'settings.system_settings.backend.title' => '後端處理節點',
			'settings.system_settings.backend.subtitle' => '歐美極速節點 (Groq) 或 國內合規節點 (矽基流動)',
			'settings.system_settings.backend.us' => '歐美地區 (US/Europe)',
			'settings.system_settings.backend.cn' => '中國國內 (China)',
			'settings.hotkeys.title' => '快速鍵與觸發',
			'settings.hotkeys.refine.title' => '基礎最佳化模式 (Toggle)',
			'settings.hotkeys.refine.subtitle' => '如果不想長按原生 Fn 鍵，可以在此綁定一個全域切換按鍵',
			'settings.hotkeys.translate.title' => '全域翻譯模式 (Toggle)',
			'settings.hotkeys.translate.subtitle' => '說話即刻翻譯為目標外語輸出',
			'settings.hotkeys.click_to_set' => '點擊設定快速鍵',
			'settings.hotkeys.cancel' => '取消',
			'settings.hotkeys.record_title' => ({required Object title}) => '錄製 ${title} 快速鍵',
			'settings.hotkeys.record_desc' => '請直接在鍵盤上按下您想要的組合鍵...',
			'settings.translation.title' => '翻譯引擎策略',
			'settings.translation.target_lang.title' => '目標外語選擇',
			'settings.translation.target_lang.subtitle' => '當觸發翻譯模式時，預設被翻譯成的語種',
			'settings.target_languages.en' => '英語',
			'settings.target_languages.ja' => '日語',
			'settings.target_languages.ko' => '韓語',
			'settings.target_languages.fr' => '法語',
			'settings.target_languages.de' => '德語',
			'settings.target_languages.ru' => '俄語',
			'settings.target_languages.es' => '西班牙語',
			'settings.target_languages.it' => '義大利語',
			'settings.target_languages.pt' => '葡萄牙語',
			'settings.target_languages.nl' => '荷蘭語',
			'settings.target_languages.ar' => '阿拉伯語',
			'settings.target_languages.tr' => '土耳其語',
			'settings.target_languages.sv' => '瑞典語',
			'settings.target_languages.hi' => '印地語',
			'settings.target_languages.th' => '泰語',
			'settings.target_languages.vi' => '越南語',
			'settings.target_languages.id' => '印尼語',
			'settings.target_languages.zh_Hans' => '簡體中文',
			'settings.target_languages.zh_Hant' => '繁體中文',
			'dashboard.sidebar.home' => '首頁',
			'dashboard.sidebar.history' => '歷史',
			'dashboard.sidebar.settings' => '設定',
			'dashboard.home.greeting' => '你好，創作者',
			'dashboard.home.subtitle' => '今日聚焦，心流已就緒',
			'dashboard.home.guide.title' => '快速上手指南',
			'dashboard.home.guide.voice_input.title' => '點擊 Fn 語音輸入',
			'dashboard.home.guide.voice_input.desc' => '在任何文字方塊中按住 Fn 說話，鬆開後自動潤飾並貼上。',
			'dashboard.home.guide.realtime_translate.title' => 'Shift + Fn 即時翻譯',
			'dashboard.home.guide.realtime_translate.desc' => '按住 Shift 再按住 Fn 進行中英互譯。',
			'dashboard.home.guide.smart_format.title' => '智慧排版助手',
			'dashboard.home.guide.smart_format.desc' => '系統會自動記錄你的高頻短語和寫作風格。',
			'dashboard.home.stats.focus_performance' => '專注表現',
			'dashboard.home.stats.hours' => ({required Object hours}) => '${hours} 小時',
			'dashboard.home.stats.days.0' => '週一',
			'dashboard.home.stats.days.1' => '週二',
			'dashboard.home.stats.days.2' => '週三',
			'dashboard.home.stats.days.3' => '週四',
			'dashboard.home.stats.days.4' => '週五',
			'dashboard.home.stats.days.5' => '週六',
			'dashboard.home.stats.days.6' => '週日',
			'dashboard.home.stats.goal_reached' => '今日靈感達成',
			'dashboard.home.stats.processed_words' => ({required Object words}) => '處理字數 ${words}',
			'dashboard.chars_unit' => '字',
			'dashboard.unlimited' => '無限',
			'history.title' => '歷史創作記錄',
			'history.time_saved' => ({required Object time}) => '累計為您挽回了 ${time} 的打字時間。',
			'history.empty' => '暫無記錄\n按 Fn 鍵開始您的第一次語音轉寫',
			'history.mode_translate' => '外語翻譯',
			'history.mode_refine' => '母語潤飾',
			'history.asr_label' => '🎙️ 錄音辨識: ',
			'history.llm_label' => '✨ 智慧潤飾: ',
			'history.seconds' => ({required Object seconds}) => '${seconds} 秒',
			'history.minutes' => ({required Object minutes}) => '${minutes} 分鐘',
			'history.period.today' => '今日',
			'history.period.week' => '本週',
			'history.period.month' => '本月',
			'history.period.all' => '累計',
			'history.kpi.usage_time' => '使用時長',
			'history.kpi.chars' => '生成字數',
			'history.kpi.time_saved' => '節省時間',
			'history.kpi.requests' => '總請求數',
			'history.kpi.refine' => '潤飾次數',
			'history.kpi.translate' => '翻譯次數',
			'onboarding.step1_title' => '自然說話，完美書寫',
			'onboarding.step1_subtitle' => '只需長按 Fn 開始錄音\n鬆開後自動潤色並貼上至活動視窗',
			'onboarding.step1_action' => '下一步',
			'onboarding.step2_title' => '授權麥克風',
			'onboarding.step2_action' => '授權系統權限',
			'onboarding.step3_title' => '開啟輔助功能',
			'onboarding.step3_subtitle' => '為了體驗「無感輸入」\n請在系統安全與隱私中為 Audio Translate Input 開啟輔助功能',
			'onboarding.step3_action' => '驗證系統權限',
			'onboarding.step4_title' => '實戰演練',
			'onboarding.step4_subtitle' => '一切就緒！現在請長按 Fn 隨便說一句話\n準備迎接全新的效率革命',
			'onboarding.step4_action' => '開始旅程',
			'onboarding.skip' => '跳過導覽',
			'onboarding.mic_permission_subtitle' => 'Audio Translate Input 需要麥克風權限\n才能將您的語音轉換為精準文字',
			'onboarding.complete_trial' => '完成試用',
			'onboarding.hold_fn_hint' => '按住 Fn 鍵說點什麼...',
			'onboarding.listening' => '聆聽中...（請自由說話）',
			'onboarding.refining' => '潤飾中...',
			'onboarding.trial_success' => '試用成功！這就是 Audio Translate Input 的魔力。',
			'onboarding.click_to_simulate' => '（您可以點擊此區域模擬按鍵）',
			'onboarding.accessibility_warning' => '輔助功能權限未授予。請在彈出的系統設定對話框中啟用 Audio Translate Input。',
			'vocab.title' => '個人詞典',
			'vocab.subtitle' => '教 AI 學會你的慣用語',
			'vocab.add_title' => '新增自訂表達',
			'vocab.spoken_hint' => '你說的話（口語形式）',
			'vocab.written_hint' => '你想寫的（書面形式）',
			'vocab.add_btn' => '新增',
			'vocab.empty' => '還沒有自訂表達',
			_ => null,
		};
	}
}
