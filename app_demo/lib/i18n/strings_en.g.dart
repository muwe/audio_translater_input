///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsStatusEn status = TranslationsStatusEn._(_root);
	late final TranslationsCommonEn common = TranslationsCommonEn._(_root);
	late final TranslationsLocalesEn locales = TranslationsLocalesEn._(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn._(_root);
	late final TranslationsDashboardEn dashboard = TranslationsDashboardEn._(_root);
	late final TranslationsHistoryEn history = TranslationsHistoryEn._(_root);
	late final TranslationsOnboardingEn onboarding = TranslationsOnboardingEn._(_root);
	late final TranslationsVocabEn vocab = TranslationsVocabEn._(_root);
}

// Path: status
class TranslationsStatusEn {
	TranslationsStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Press Fn to Record'
	String get idle => 'Press Fn to Record';

	/// en: '🌐 Translating... (Release Fn to stop)'
	String get translating => '🌐 Translating... (Release Fn to stop)';

	/// en: '🎤 Listening... (Release Fn to stop)'
	String get listening => '🎤 Listening... (Release Fn to stop)';

	/// en: '🔴 No Network Connection'
	String get network_disconnected_title => '🔴 No Network Connection';

	/// en: 'Please check your network connection'
	String get network_disconnected_desc => 'Please check your network connection';

	/// en: 'No Network'
	String get network_disconnected_short => 'No Network';

	/// en: 'Accessibility permission required for auto-paste, please grant it in system settings'
	String get accessibility_permission => 'Accessibility permission required for auto-paste, please grant it in system settings';

	/// en: 'Microphone unauthorized'
	String get mic_permission => 'Microphone unauthorized';

	/// en: '✨ Processing...'
	String get processing => '✨ Processing...';

	/// en: '✅ Pasting successful'
	String get paste_success => '✅ Pasting successful';

	/// en: '✅ [ASR: ${asrSec}s | LLM: ${llmSec}s]'
	String paste_success_times({required Object asrSec, required Object llmSec}) => '✅ [ASR: ${asrSec}s | LLM: ${llmSec}s]';

	/// en: 'Recording'
	String get mode_recording => 'Recording';

	/// en: 'Translating'
	String get mode_translating => 'Translating';

	/// en: 'Recording failed to start'
	String get recording_failed => 'Recording failed to start';

	/// en: 'No voice detected'
	String get no_voice_detected => 'No voice detected';

	/// en: 'Processing'
	String get processing_short => 'Processing';
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${min}m ${sec}s'
	String min_sec({required Object min, required Object sec}) => '${min}m ${sec}s';

	/// en: '${hour}h ${min}m'
	String hour_min({required Object hour, required Object min}) => '${hour}h ${min}m';

	/// en: '${n} min'
	String n_minutes({required Object n}) => '${n} min';

	/// en: '${n} hr ${min} min'
	String n_hours({required Object n, required Object min}) => '${n} hr ${min} min';
}

// Path: locales
class TranslationsLocalesEn {
	TranslationsLocalesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'English'
	String get en => 'English';

	/// en: 'Simplified Chinese'
	String get zhHans => 'Simplified Chinese';

	/// en: 'Traditional Chinese'
	String get zhHant => 'Traditional Chinese';

	/// en: 'Japanese'
	String get ja => 'Japanese';

	/// en: 'German'
	String get de => 'German';

	/// en: 'Spanish'
	String get es => 'Spanish';
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'App Settings'
	String get title => 'App Settings';

	/// en: 'Customize your typing experience.'
	String get subtitle => 'Customize your typing experience.';

	late final TranslationsSettingsUiSettingsEn ui_settings = TranslationsSettingsUiSettingsEn._(_root);
	late final TranslationsSettingsSystemSettingsEn system_settings = TranslationsSettingsSystemSettingsEn._(_root);
	late final TranslationsSettingsHotkeysEn hotkeys = TranslationsSettingsHotkeysEn._(_root);
	late final TranslationsSettingsTranslationEn translation = TranslationsSettingsTranslationEn._(_root);
	late final TranslationsSettingsTargetLanguagesEn target_languages = TranslationsSettingsTargetLanguagesEn._(_root);
}

// Path: dashboard
class TranslationsDashboardEn {
	TranslationsDashboardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'chars'
	String get chars_unit => 'chars';

	/// en: 'Unlimited'
	String get unlimited => 'Unlimited';

	late final TranslationsDashboardSidebarEn sidebar = TranslationsDashboardSidebarEn._(_root);
	late final TranslationsDashboardHomeEn home = TranslationsDashboardHomeEn._(_root);
}

// Path: history
class TranslationsHistoryEn {
	TranslationsHistoryEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Creation History'
	String get title => 'Creation History';

	/// en: 'Accumulated ${time} of typing time saved for you.'
	String time_saved({required Object time}) => 'Accumulated ${time} of typing time saved for you.';

	/// en: 'No records yet Press Fn to start your first voice transcription'
	String get empty => 'No records yet\nPress Fn to start your first voice transcription';

	/// en: 'Foreign Translation'
	String get mode_translate => 'Foreign Translation';

	/// en: 'Native Refinement'
	String get mode_refine => 'Native Refinement';

	/// en: '🎙️ Voice Recognition: '
	String get asr_label => '🎙️ Voice Recognition: ';

	/// en: '✨ Smart Refinement: '
	String get llm_label => '✨ Smart Refinement: ';

	/// en: '${seconds} seconds'
	String seconds({required Object seconds}) => '${seconds} seconds';

	/// en: '${minutes} minutes'
	String minutes({required Object minutes}) => '${minutes} minutes';

	late final TranslationsHistoryPeriodEn period = TranslationsHistoryPeriodEn._(_root);
	late final TranslationsHistoryKpiEn kpi = TranslationsHistoryKpiEn._(_root);
}

// Path: onboarding
class TranslationsOnboardingEn {
	TranslationsOnboardingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Speak Naturally, Write Perfectly'
	String get step1_title => 'Speak Naturally, Write Perfectly';

	/// en: 'Hold Fn to record Release to auto-refine and paste to active window'
	String get step1_subtitle => 'Hold Fn to record\nRelease to auto-refine and paste to active window';

	/// en: 'Next'
	String get step1_action => 'Next';

	/// en: 'Authorize Microphone'
	String get step2_title => 'Authorize Microphone';

	/// en: 'Grant System Permission'
	String get step2_action => 'Grant System Permission';

	/// en: 'Enable Accessibility'
	String get step3_title => 'Enable Accessibility';

	/// en: 'For seamless input Please enable accessibility for Audio Translate Input in System Preferences > Security & Privacy'
	String get step3_subtitle => 'For seamless input\nPlease enable accessibility for Audio Translate Input in System Preferences > Security & Privacy';

	/// en: 'Verify System Permission'
	String get step3_action => 'Verify System Permission';

	/// en: 'Try It Out'
	String get step4_title => 'Try It Out';

	/// en: 'All set! Hold Fn and say something Prepare for a whole new efficiency revolution'
	String get step4_subtitle => 'All set! Hold Fn and say something\nPrepare for a whole new efficiency revolution';

	/// en: 'Start Journey'
	String get step4_action => 'Start Journey';

	/// en: 'Skip Guide'
	String get skip => 'Skip Guide';

	/// en: 'Audio Translate Input needs microphone permission to convert your voice into precise text'
	String get mic_permission_subtitle => 'Audio Translate Input needs microphone permission\nto convert your voice into precise text';

	/// en: 'Complete Trial'
	String get complete_trial => 'Complete Trial';

	/// en: 'Hold Fn key and say something...'
	String get hold_fn_hint => 'Hold Fn key and say something...';

	/// en: 'Listening... (Please speak freely)'
	String get listening => 'Listening... (Please speak freely)';

	/// en: 'Refining...'
	String get refining => 'Refining...';

	/// en: 'Trial successful! This is the magic of Audio Translate Input.'
	String get trial_success => 'Trial successful! This is the magic of Audio Translate Input.';

	/// en: '(You can click this box to simulate a key press)'
	String get click_to_simulate => '(You can click this box to simulate a key press)';

	/// en: 'Accessibility permission not granted. Please enable Audio Translate Input in the system settings dialog that appears.'
	String get accessibility_warning => 'Accessibility permission not granted. Please enable Audio Translate Input in the system settings dialog that appears.';
}

// Path: vocab
class TranslationsVocabEn {
	TranslationsVocabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Personal Dictionary'
	String get title => 'Personal Dictionary';

	/// en: 'Teach AI your preferred expressions'
	String get subtitle => 'Teach AI your preferred expressions';

	/// en: 'Add Custom Expression'
	String get add_title => 'Add Custom Expression';

	/// en: 'What you say (spoken form)'
	String get spoken_hint => 'What you say (spoken form)';

	/// en: 'What you want written (written form)'
	String get written_hint => 'What you want written (written form)';

	/// en: 'Add'
	String get add_btn => 'Add';

	/// en: 'No custom expressions yet'
	String get empty => 'No custom expressions yet';
}

// Path: settings.ui_settings
class TranslationsSettingsUiSettingsEn {
	TranslationsSettingsUiSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'UI Settings'
	String get title => 'UI Settings';

	late final TranslationsSettingsUiSettingsAppLanguageEn app_language = TranslationsSettingsUiSettingsAppLanguageEn._(_root);
	late final TranslationsSettingsUiSettingsFontEn font = TranslationsSettingsUiSettingsFontEn._(_root);
}

// Path: settings.system_settings
class TranslationsSettingsSystemSettingsEn {
	TranslationsSettingsSystemSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'System Settings'
	String get title => 'System Settings';

	late final TranslationsSettingsSystemSettingsStartupEn startup = TranslationsSettingsSystemSettingsStartupEn._(_root);
	late final TranslationsSettingsSystemSettingsBackendEn backend = TranslationsSettingsSystemSettingsBackendEn._(_root);
}

// Path: settings.hotkeys
class TranslationsSettingsHotkeysEn {
	TranslationsSettingsHotkeysEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hotkeys & Triggers'
	String get title => 'Hotkeys & Triggers';

	late final TranslationsSettingsHotkeysRefineEn refine = TranslationsSettingsHotkeysRefineEn._(_root);
	late final TranslationsSettingsHotkeysTranslateEn translate = TranslationsSettingsHotkeysTranslateEn._(_root);

	/// en: 'Click to set hotkey'
	String get click_to_set => 'Click to set hotkey';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Record ${title} Hotkey'
	String record_title({required Object title}) => 'Record ${title} Hotkey';

	/// en: 'Press your desired key combination directly on the keyboard...'
	String get record_desc => 'Press your desired key combination directly on the keyboard...';
}

// Path: settings.translation
class TranslationsSettingsTranslationEn {
	TranslationsSettingsTranslationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Translation Strategy'
	String get title => 'Translation Strategy';

	late final TranslationsSettingsTranslationTargetLangEn target_lang = TranslationsSettingsTranslationTargetLangEn._(_root);
}

// Path: settings.target_languages
class TranslationsSettingsTargetLanguagesEn {
	TranslationsSettingsTargetLanguagesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'English'
	String get en => 'English';

	/// en: 'Japanese'
	String get ja => 'Japanese';

	/// en: 'Korean'
	String get ko => 'Korean';

	/// en: 'French'
	String get fr => 'French';

	/// en: 'German'
	String get de => 'German';

	/// en: 'Russian'
	String get ru => 'Russian';

	/// en: 'Spanish'
	String get es => 'Spanish';

	/// en: 'Italian'
	String get it => 'Italian';

	/// en: 'Portuguese'
	String get pt => 'Portuguese';

	/// en: 'Dutch'
	String get nl => 'Dutch';

	/// en: 'Arabic'
	String get ar => 'Arabic';

	/// en: 'Turkish'
	String get tr => 'Turkish';

	/// en: 'Swedish'
	String get sv => 'Swedish';

	/// en: 'Hindi'
	String get hi => 'Hindi';

	/// en: 'Thai'
	String get th => 'Thai';

	/// en: 'Vietnamese'
	String get vi => 'Vietnamese';

	/// en: 'Indonesian'
	String get id => 'Indonesian';

	/// en: 'Simplified Chinese'
	String get zh_Hans => 'Simplified Chinese';

	/// en: 'Traditional Chinese'
	String get zh_Hant => 'Traditional Chinese';
}

// Path: dashboard.sidebar
class TranslationsDashboardSidebarEn {
	TranslationsDashboardSidebarEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'History'
	String get history => 'History';

	/// en: 'Settings'
	String get settings => 'Settings';
}

// Path: dashboard.home
class TranslationsDashboardHomeEn {
	TranslationsDashboardHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hello, Creator'
	String get greeting => 'Hello, Creator';

	/// en: 'Today's focus, flow is ready'
	String get subtitle => 'Today\'s focus, flow is ready';

	late final TranslationsDashboardHomeGuideEn guide = TranslationsDashboardHomeGuideEn._(_root);
	late final TranslationsDashboardHomeStatsEn stats = TranslationsDashboardHomeStatsEn._(_root);
}

// Path: history.period
class TranslationsHistoryPeriodEn {
	TranslationsHistoryPeriodEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'This Week'
	String get week => 'This Week';

	/// en: 'This Month'
	String get month => 'This Month';

	/// en: 'All Time'
	String get all => 'All Time';
}

// Path: history.kpi
class TranslationsHistoryKpiEn {
	TranslationsHistoryKpiEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Usage Time'
	String get usage_time => 'Usage Time';

	/// en: 'Characters'
	String get chars => 'Characters';

	/// en: 'Time Saved'
	String get time_saved => 'Time Saved';

	/// en: 'Total Requests'
	String get requests => 'Total Requests';

	/// en: 'Refinements'
	String get refine => 'Refinements';

	/// en: 'Translations'
	String get translate => 'Translations';
}

// Path: settings.ui_settings.app_language
class TranslationsSettingsUiSettingsAppLanguageEn {
	TranslationsSettingsUiSettingsAppLanguageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'App Language'
	String get title => 'App Language';

	/// en: 'Change the overall application language'
	String get subtitle => 'Change the overall application language';
}

// Path: settings.ui_settings.font
class TranslationsSettingsUiSettingsFontEn {
	TranslationsSettingsUiSettingsFontEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Display Font'
	String get title => 'Display Font';

	/// en: 'Globally change the text display font'
	String get subtitle => 'Globally change the text display font';
}

// Path: settings.system_settings.startup
class TranslationsSettingsSystemSettingsStartupEn {
	TranslationsSettingsSystemSettingsStartupEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Launch at Startup'
	String get title => 'Launch at Startup';

	/// en: 'Automatically run in background after login, always ready'
	String get subtitle => 'Automatically run in background after login, always ready';
}

// Path: settings.system_settings.backend
class TranslationsSettingsSystemSettingsBackendEn {
	TranslationsSettingsSystemSettingsBackendEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Backend Node'
	String get title => 'Backend Node';

	/// en: 'US Ultra-fast Node (Groq) or CN Compliant Node (SiliconFlow)'
	String get subtitle => 'US Ultra-fast Node (Groq) or CN Compliant Node (SiliconFlow)';

	/// en: 'US/Europe'
	String get us => 'US/Europe';

	/// en: 'China'
	String get cn => 'China';
}

// Path: settings.hotkeys.refine
class TranslationsSettingsHotkeysRefineEn {
	TranslationsSettingsHotkeysRefineEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Refine Mode (Toggle)'
	String get title => 'Refine Mode (Toggle)';

	/// en: 'Bind a global toggle key if you don't want to hold native Fn'
	String get subtitle => 'Bind a global toggle key if you don\'t want to hold native Fn';
}

// Path: settings.hotkeys.translate
class TranslationsSettingsHotkeysTranslateEn {
	TranslationsSettingsHotkeysTranslateEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Translate Mode (Toggle)'
	String get title => 'Translate Mode (Toggle)';

	/// en: 'Speak and immediately translate to target language'
	String get subtitle => 'Speak and immediately translate to target language';
}

// Path: settings.translation.target_lang
class TranslationsSettingsTranslationTargetLangEn {
	TranslationsSettingsTranslationTargetLangEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Target Language'
	String get title => 'Target Language';

	/// en: 'Default language to translate into when trigger translate mode'
	String get subtitle => 'Default language to translate into when trigger translate mode';
}

// Path: dashboard.home.guide
class TranslationsDashboardHomeGuideEn {
	TranslationsDashboardHomeGuideEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Quick Start Guide'
	String get title => 'Quick Start Guide';

	late final TranslationsDashboardHomeGuideVoiceInputEn voice_input = TranslationsDashboardHomeGuideVoiceInputEn._(_root);
	late final TranslationsDashboardHomeGuideRealtimeTranslateEn realtime_translate = TranslationsDashboardHomeGuideRealtimeTranslateEn._(_root);
	late final TranslationsDashboardHomeGuideSmartFormatEn smart_format = TranslationsDashboardHomeGuideSmartFormatEn._(_root);
}

// Path: dashboard.home.stats
class TranslationsDashboardHomeStatsEn {
	TranslationsDashboardHomeStatsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Focus Performance'
	String get focus_performance => 'Focus Performance';

	/// en: '${hours} Hours'
	String hours({required Object hours}) => '${hours} Hours';

	List<String> get days => [
		'Mon',
		'Tue',
		'Wed',
		'Thu',
		'Fri',
		'Sat',
		'Sun',
	];

	/// en: 'Today's Inspiration'
	String get goal_reached => 'Today\'s Inspiration';

	/// en: 'Processed Words ${words}'
	String processed_words({required Object words}) => 'Processed Words ${words}';
}

// Path: dashboard.home.guide.voice_input
class TranslationsDashboardHomeGuideVoiceInputEn {
	TranslationsDashboardHomeGuideVoiceInputEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Click Fn for Voice Input'
	String get title => 'Click Fn for Voice Input';

	/// en: 'Hold Fn in any text box to speak, release to automatically refine and paste.'
	String get desc => 'Hold Fn in any text box to speak, release to automatically refine and paste.';
}

// Path: dashboard.home.guide.realtime_translate
class TranslationsDashboardHomeGuideRealtimeTranslateEn {
	TranslationsDashboardHomeGuideRealtimeTranslateEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Shift + Fn for Real-time Translation'
	String get title => 'Shift + Fn for Real-time Translation';

	/// en: 'Hold Shift and Fn for translation.'
	String get desc => 'Hold Shift and Fn for translation.';
}

// Path: dashboard.home.guide.smart_format
class TranslationsDashboardHomeGuideSmartFormatEn {
	TranslationsDashboardHomeGuideSmartFormatEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Smart Formatting Assistant'
	String get title => 'Smart Formatting Assistant';

	/// en: 'The system will automatically record your frequent phrases and writing style.'
	String get desc => 'The system will automatically record your frequent phrases and writing style.';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'status.idle' => 'Press Fn to Record',
			'status.translating' => '🌐 Translating... (Release Fn to stop)',
			'status.listening' => '🎤 Listening... (Release Fn to stop)',
			'status.network_disconnected_title' => '🔴 No Network Connection',
			'status.network_disconnected_desc' => 'Please check your network connection',
			'status.network_disconnected_short' => 'No Network',
			'status.accessibility_permission' => 'Accessibility permission required for auto-paste, please grant it in system settings',
			'status.mic_permission' => 'Microphone unauthorized',
			'status.processing' => '✨ Processing...',
			'status.paste_success' => '✅ Pasting successful',
			'status.paste_success_times' => ({required Object asrSec, required Object llmSec}) => '✅ [ASR: ${asrSec}s | LLM: ${llmSec}s]',
			'status.mode_recording' => 'Recording',
			'status.mode_translating' => 'Translating',
			'status.recording_failed' => 'Recording failed to start',
			'status.no_voice_detected' => 'No voice detected',
			'status.processing_short' => 'Processing',
			'common.min_sec' => ({required Object min, required Object sec}) => '${min}m ${sec}s',
			'common.hour_min' => ({required Object hour, required Object min}) => '${hour}h ${min}m',
			'common.n_minutes' => ({required Object n}) => '${n} min',
			'common.n_hours' => ({required Object n, required Object min}) => '${n} hr ${min} min',
			'locales.en' => 'English',
			'locales.zhHans' => 'Simplified Chinese',
			'locales.zhHant' => 'Traditional Chinese',
			'locales.ja' => 'Japanese',
			'locales.de' => 'German',
			'locales.es' => 'Spanish',
			'settings.title' => 'App Settings',
			'settings.subtitle' => 'Customize your typing experience.',
			'settings.ui_settings.title' => 'UI Settings',
			'settings.ui_settings.app_language.title' => 'App Language',
			'settings.ui_settings.app_language.subtitle' => 'Change the overall application language',
			'settings.ui_settings.font.title' => 'Display Font',
			'settings.ui_settings.font.subtitle' => 'Globally change the text display font',
			'settings.system_settings.title' => 'System Settings',
			'settings.system_settings.startup.title' => 'Launch at Startup',
			'settings.system_settings.startup.subtitle' => 'Automatically run in background after login, always ready',
			'settings.system_settings.backend.title' => 'Backend Node',
			'settings.system_settings.backend.subtitle' => 'US Ultra-fast Node (Groq) or CN Compliant Node (SiliconFlow)',
			'settings.system_settings.backend.us' => 'US/Europe',
			'settings.system_settings.backend.cn' => 'China',
			'settings.hotkeys.title' => 'Hotkeys & Triggers',
			'settings.hotkeys.refine.title' => 'Refine Mode (Toggle)',
			'settings.hotkeys.refine.subtitle' => 'Bind a global toggle key if you don\'t want to hold native Fn',
			'settings.hotkeys.translate.title' => 'Translate Mode (Toggle)',
			'settings.hotkeys.translate.subtitle' => 'Speak and immediately translate to target language',
			'settings.hotkeys.click_to_set' => 'Click to set hotkey',
			'settings.hotkeys.cancel' => 'Cancel',
			'settings.hotkeys.record_title' => ({required Object title}) => 'Record ${title} Hotkey',
			'settings.hotkeys.record_desc' => 'Press your desired key combination directly on the keyboard...',
			'settings.translation.title' => 'Translation Strategy',
			'settings.translation.target_lang.title' => 'Target Language',
			'settings.translation.target_lang.subtitle' => 'Default language to translate into when trigger translate mode',
			'settings.target_languages.en' => 'English',
			'settings.target_languages.ja' => 'Japanese',
			'settings.target_languages.ko' => 'Korean',
			'settings.target_languages.fr' => 'French',
			'settings.target_languages.de' => 'German',
			'settings.target_languages.ru' => 'Russian',
			'settings.target_languages.es' => 'Spanish',
			'settings.target_languages.it' => 'Italian',
			'settings.target_languages.pt' => 'Portuguese',
			'settings.target_languages.nl' => 'Dutch',
			'settings.target_languages.ar' => 'Arabic',
			'settings.target_languages.tr' => 'Turkish',
			'settings.target_languages.sv' => 'Swedish',
			'settings.target_languages.hi' => 'Hindi',
			'settings.target_languages.th' => 'Thai',
			'settings.target_languages.vi' => 'Vietnamese',
			'settings.target_languages.id' => 'Indonesian',
			'settings.target_languages.zh_Hans' => 'Simplified Chinese',
			'settings.target_languages.zh_Hant' => 'Traditional Chinese',
			'dashboard.chars_unit' => 'chars',
			'dashboard.unlimited' => 'Unlimited',
			'dashboard.sidebar.home' => 'Home',
			'dashboard.sidebar.history' => 'History',
			'dashboard.sidebar.settings' => 'Settings',
			'dashboard.home.greeting' => 'Hello, Creator',
			'dashboard.home.subtitle' => 'Today\'s focus, flow is ready',
			'dashboard.home.guide.title' => 'Quick Start Guide',
			'dashboard.home.guide.voice_input.title' => 'Click Fn for Voice Input',
			'dashboard.home.guide.voice_input.desc' => 'Hold Fn in any text box to speak, release to automatically refine and paste.',
			'dashboard.home.guide.realtime_translate.title' => 'Shift + Fn for Real-time Translation',
			'dashboard.home.guide.realtime_translate.desc' => 'Hold Shift and Fn for translation.',
			'dashboard.home.guide.smart_format.title' => 'Smart Formatting Assistant',
			'dashboard.home.guide.smart_format.desc' => 'The system will automatically record your frequent phrases and writing style.',
			'dashboard.home.stats.focus_performance' => 'Focus Performance',
			'dashboard.home.stats.hours' => ({required Object hours}) => '${hours} Hours',
			'dashboard.home.stats.days.0' => 'Mon',
			'dashboard.home.stats.days.1' => 'Tue',
			'dashboard.home.stats.days.2' => 'Wed',
			'dashboard.home.stats.days.3' => 'Thu',
			'dashboard.home.stats.days.4' => 'Fri',
			'dashboard.home.stats.days.5' => 'Sat',
			'dashboard.home.stats.days.6' => 'Sun',
			'dashboard.home.stats.goal_reached' => 'Today\'s Inspiration',
			'dashboard.home.stats.processed_words' => ({required Object words}) => 'Processed Words ${words}',
			'history.title' => 'Creation History',
			'history.time_saved' => ({required Object time}) => 'Accumulated ${time} of typing time saved for you.',
			'history.empty' => 'No records yet\nPress Fn to start your first voice transcription',
			'history.mode_translate' => 'Foreign Translation',
			'history.mode_refine' => 'Native Refinement',
			'history.asr_label' => '🎙️ Voice Recognition: ',
			'history.llm_label' => '✨ Smart Refinement: ',
			'history.seconds' => ({required Object seconds}) => '${seconds} seconds',
			'history.minutes' => ({required Object minutes}) => '${minutes} minutes',
			'history.period.today' => 'Today',
			'history.period.week' => 'This Week',
			'history.period.month' => 'This Month',
			'history.period.all' => 'All Time',
			'history.kpi.usage_time' => 'Usage Time',
			'history.kpi.chars' => 'Characters',
			'history.kpi.time_saved' => 'Time Saved',
			'history.kpi.requests' => 'Total Requests',
			'history.kpi.refine' => 'Refinements',
			'history.kpi.translate' => 'Translations',
			'onboarding.step1_title' => 'Speak Naturally, Write Perfectly',
			'onboarding.step1_subtitle' => 'Hold Fn to record\nRelease to auto-refine and paste to active window',
			'onboarding.step1_action' => 'Next',
			'onboarding.step2_title' => 'Authorize Microphone',
			'onboarding.step2_action' => 'Grant System Permission',
			'onboarding.step3_title' => 'Enable Accessibility',
			'onboarding.step3_subtitle' => 'For seamless input\nPlease enable accessibility for Audio Translate Input in System Preferences > Security & Privacy',
			'onboarding.step3_action' => 'Verify System Permission',
			'onboarding.step4_title' => 'Try It Out',
			'onboarding.step4_subtitle' => 'All set! Hold Fn and say something\nPrepare for a whole new efficiency revolution',
			'onboarding.step4_action' => 'Start Journey',
			'onboarding.skip' => 'Skip Guide',
			'onboarding.mic_permission_subtitle' => 'Audio Translate Input needs microphone permission\nto convert your voice into precise text',
			'onboarding.complete_trial' => 'Complete Trial',
			'onboarding.hold_fn_hint' => 'Hold Fn key and say something...',
			'onboarding.listening' => 'Listening... (Please speak freely)',
			'onboarding.refining' => 'Refining...',
			'onboarding.trial_success' => 'Trial successful! This is the magic of Audio Translate Input.',
			'onboarding.click_to_simulate' => '(You can click this box to simulate a key press)',
			'onboarding.accessibility_warning' => 'Accessibility permission not granted. Please enable Audio Translate Input in the system settings dialog that appears.',
			'vocab.title' => 'Personal Dictionary',
			'vocab.subtitle' => 'Teach AI your preferred expressions',
			'vocab.add_title' => 'Add Custom Expression',
			'vocab.spoken_hint' => 'What you say (spoken form)',
			'vocab.written_hint' => 'What you want written (written form)',
			'vocab.add_btn' => 'Add',
			'vocab.empty' => 'No custom expressions yet',
			_ => null,
		};
	}
}
