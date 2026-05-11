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
class TranslationsDe with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsDe _root = this; // ignore: unused_field

	@override 
	TranslationsDe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsDe(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsStatusDe status = _TranslationsStatusDe._(_root);
	@override late final _TranslationsCommonDe common = _TranslationsCommonDe._(_root);
	@override late final _TranslationsLocalesDe locales = _TranslationsLocalesDe._(_root);
	@override late final _TranslationsSettingsDe settings = _TranslationsSettingsDe._(_root);
	@override late final _TranslationsDashboardDe dashboard = _TranslationsDashboardDe._(_root);
	@override late final _TranslationsHistoryDe history = _TranslationsHistoryDe._(_root);
	@override late final _TranslationsOnboardingDe onboarding = _TranslationsOnboardingDe._(_root);
	@override late final _TranslationsVocabDe vocab = _TranslationsVocabDe._(_root);
}

// Path: status
class _TranslationsStatusDe implements TranslationsStatusEn {
	_TranslationsStatusDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get idle => 'Drücken Sie Fn zum Aufnehmen';
	@override String get translating => '🌐 Übersetzen... (Fn loslassen zum Stoppen)';
	@override String get listening => '🎤 Zuhören... (Fn loslassen zum Stoppen)';
	@override String get network_disconnected_title => '🔴 Keine Netzwerkverbindung';
	@override String get network_disconnected_desc => 'Bitte überprüfen Sie die Netzwerkverbindung';
	@override String get network_disconnected_short => 'Kein Netzwerk';
	@override String get accessibility_permission => 'Eingabehilfen-Berechtigung zum automatischen Einfügen erforderlich';
	@override String get mic_permission => 'Mikrofon nicht autorisiert';
	@override String get processing => '✨ Wird verarbeitet...';
	@override String get paste_success => '✅ Erfolgreich eingefügt';
	@override String paste_success_times({required Object asrSec, required Object llmSec}) => '✅ [ASR: ${asrSec}s | LLM: ${llmSec}s]';
	@override String get mode_recording => 'Aufnahme';
	@override String get mode_translating => 'Übersetzen';
	@override String get recording_failed => 'Aufnahme fehlgeschlagen';
	@override String get no_voice_detected => 'Keine Stimme erkannt';
	@override String get processing_short => 'Verarbeiten';
}

// Path: common
class _TranslationsCommonDe implements TranslationsCommonEn {
	_TranslationsCommonDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String min_sec({required Object min, required Object sec}) => '${min}m ${sec}s';
	@override String hour_min({required Object hour, required Object min}) => '${hour}h ${min}m';
	@override String n_minutes({required Object n}) => '${n} Min.';
	@override String n_hours({required Object n, required Object min}) => '${n} Std. ${min} Min.';
}

// Path: locales
class _TranslationsLocalesDe implements TranslationsLocalesEn {
	_TranslationsLocalesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get en => 'Englisch';
	@override String get zhHans => 'Vereinfachtes Chinesisch';
	@override String get zhHant => 'Traditionelles Chinesisch';
	@override String get ja => 'Japanisch';
	@override String get de => 'Deutsch';
	@override String get es => 'Spanisch';
}

// Path: settings
class _TranslationsSettingsDe implements TranslationsSettingsEn {
	_TranslationsSettingsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'App-Einstellungen';
	@override String get subtitle => 'Passen Sie Ihr Tipp-Erlebnis an.';
	@override late final _TranslationsSettingsUiSettingsDe ui_settings = _TranslationsSettingsUiSettingsDe._(_root);
	@override late final _TranslationsSettingsSystemSettingsDe system_settings = _TranslationsSettingsSystemSettingsDe._(_root);
	@override late final _TranslationsSettingsHotkeysDe hotkeys = _TranslationsSettingsHotkeysDe._(_root);
	@override late final _TranslationsSettingsTranslationDe translation = _TranslationsSettingsTranslationDe._(_root);
	@override late final _TranslationsSettingsTargetLanguagesDe target_languages = _TranslationsSettingsTargetLanguagesDe._(_root);
}

// Path: dashboard
class _TranslationsDashboardDe implements TranslationsDashboardEn {
	_TranslationsDashboardDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDashboardSidebarDe sidebar = _TranslationsDashboardSidebarDe._(_root);
	@override late final _TranslationsDashboardHomeDe home = _TranslationsDashboardHomeDe._(_root);
	@override String get chars_unit => 'Zeichen';
	@override String get unlimited => 'Unbegrenzt';
}

// Path: history
class _TranslationsHistoryDe implements TranslationsHistoryEn {
	_TranslationsHistoryDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Erstellungsverlauf';
	@override String time_saved({required Object time}) => 'Insgesamt ${time} Tippzeit gespart.';
	@override String get empty => 'Keine Aufzeichnungen vorhanden\nDrücken Sie Fn, um zu beginnen';
	@override String get mode_translate => 'Fremdsprachenübersetzung';
	@override String get mode_refine => 'Muttersprachliche Verfeinerung';
	@override String get asr_label => '🎙️ Spracherkennung: ';
	@override String get llm_label => '✨ Smarte Verfeinerung: ';
	@override String seconds({required Object seconds}) => '${seconds} Sekunden';
	@override String minutes({required Object minutes}) => '${minutes} Minuten';
	@override late final _TranslationsHistoryPeriodDe period = _TranslationsHistoryPeriodDe._(_root);
	@override late final _TranslationsHistoryKpiDe kpi = _TranslationsHistoryKpiDe._(_root);
}

// Path: onboarding
class _TranslationsOnboardingDe implements TranslationsOnboardingEn {
	_TranslationsOnboardingDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get step1_title => 'Natürlich sprechen, perfekt schreiben';
	@override String get step1_subtitle => 'Halten Sie Fn gedrückt zum Aufnehmen\nLoslassen für automatische Verfeinerung und Einfügen';
	@override String get step1_action => 'Weiter';
	@override String get step2_title => 'Mikrofon autorisieren';
	@override String get step2_action => 'Systemberechtigung erteilen';
	@override String get step3_title => 'Bedienungshilfen aktivieren';
	@override String get step3_subtitle => 'Für nahtlose Eingabe\nBitte aktivieren Sie Bedienungshilfen für Audio Translate Input in den Systemeinstellungen';
	@override String get step3_action => 'Systemberechtigung prüfen';
	@override String get step4_title => 'Praxisübung';
	@override String get step4_subtitle => 'Alles bereit! Halten Sie Fn gedrückt und sagen Sie etwas\nErleben Sie eine neue Effizienzrevolution';
	@override String get step4_action => 'Reise beginnen';
	@override String get skip => 'Guide überspringen';
	@override String get mic_permission_subtitle => 'Audio Translate Input benötigt Mikrofonzugriff\num Ihre Stimme in präzisen Text umzuwandeln';
	@override String get complete_trial => 'Test abschließen';
	@override String get hold_fn_hint => 'Halten Sie Fn gedrückt und sagen Sie etwas...';
	@override String get listening => 'Zuhören... (Sprechen Sie frei)';
	@override String get refining => 'Verfeinern...';
	@override String get trial_success => 'Test erfolgreich! Das ist die Magie von Audio Translate Input.';
	@override String get click_to_simulate => '(Sie können dieses Feld anklicken, um einen Tastendruck zu simulieren)';
	@override String get accessibility_warning => 'Bedienungshilfen-Berechtigung nicht erteilt. Bitte aktivieren Sie Audio Translate Input im angezeigten Systemeinstellungs-Dialog.';
}

// Path: vocab
class _TranslationsVocabDe implements TranslationsVocabEn {
	_TranslationsVocabDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Persönliches Wörterbuch';
	@override String get subtitle => 'Bringe der KI deine bevorzugten Ausdrücke bei';
	@override String get add_title => 'Eigenen Ausdruck hinzufügen';
	@override String get spoken_hint => 'Was du sagst (gesprochene Form)';
	@override String get written_hint => 'Was geschrieben werden soll (Schriftform)';
	@override String get add_btn => 'Hinzufügen';
	@override String get empty => 'Noch keine eigenen Ausdrücke';
}

// Path: settings.ui_settings
class _TranslationsSettingsUiSettingsDe implements TranslationsSettingsUiSettingsEn {
	_TranslationsSettingsUiSettingsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'UI-Einstellungen';
	@override late final _TranslationsSettingsUiSettingsAppLanguageDe app_language = _TranslationsSettingsUiSettingsAppLanguageDe._(_root);
	@override late final _TranslationsSettingsUiSettingsFontDe font = _TranslationsSettingsUiSettingsFontDe._(_root);
}

// Path: settings.system_settings
class _TranslationsSettingsSystemSettingsDe implements TranslationsSettingsSystemSettingsEn {
	_TranslationsSettingsSystemSettingsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Systemeinstellungen';
	@override late final _TranslationsSettingsSystemSettingsStartupDe startup = _TranslationsSettingsSystemSettingsStartupDe._(_root);
	@override late final _TranslationsSettingsSystemSettingsBackendDe backend = _TranslationsSettingsSystemSettingsBackendDe._(_root);
}

// Path: settings.hotkeys
class _TranslationsSettingsHotkeysDe implements TranslationsSettingsHotkeysEn {
	_TranslationsSettingsHotkeysDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hotkeys & Auslöser';
	@override late final _TranslationsSettingsHotkeysRefineDe refine = _TranslationsSettingsHotkeysRefineDe._(_root);
	@override late final _TranslationsSettingsHotkeysTranslateDe translate = _TranslationsSettingsHotkeysTranslateDe._(_root);
	@override String get click_to_set => 'Klicken zum Einstellen';
	@override String get cancel => 'Abbrechen';
	@override String record_title({required Object title}) => '${title} Hotkey aufzeichnen';
	@override String get record_desc => 'Drücken Sie die gewünschte Tastenkombination...';
}

// Path: settings.translation
class _TranslationsSettingsTranslationDe implements TranslationsSettingsTranslationEn {
	_TranslationsSettingsTranslationDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Übersetzungsstrategie';
	@override late final _TranslationsSettingsTranslationTargetLangDe target_lang = _TranslationsSettingsTranslationTargetLangDe._(_root);
}

// Path: settings.target_languages
class _TranslationsSettingsTargetLanguagesDe implements TranslationsSettingsTargetLanguagesEn {
	_TranslationsSettingsTargetLanguagesDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get en => 'Englisch';
	@override String get ja => 'Japanisch';
	@override String get ko => 'Koreanisch';
	@override String get fr => 'Französisch';
	@override String get de => 'Deutsch';
	@override String get ru => 'Russisch';
	@override String get es => 'Spanisch';
	@override String get it => 'Italienisch';
	@override String get pt => 'Portugiesisch';
	@override String get nl => 'Niederländisch';
	@override String get ar => 'Arabisch';
	@override String get tr => 'Türkisch';
	@override String get sv => 'Schwedisch';
	@override String get hi => 'Hindi';
	@override String get th => 'Thailändisch';
	@override String get vi => 'Vietnamesisch';
	@override String get id => 'Indonesisch';
	@override String get zh_Hans => 'Vereinfachtes Chinesisch';
	@override String get zh_Hant => 'Traditionelles Chinesisch';
}

// Path: dashboard.sidebar
class _TranslationsDashboardSidebarDe implements TranslationsDashboardSidebarEn {
	_TranslationsDashboardSidebarDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get home => 'Startseite';
	@override String get history => 'Verlauf';
	@override String get settings => 'Einstellungen';
}

// Path: dashboard.home
class _TranslationsDashboardHomeDe implements TranslationsDashboardHomeEn {
	_TranslationsDashboardHomeDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get greeting => 'Hallo Generator';
	@override String get subtitle => 'Heutiger Fokus bereit';
	@override late final _TranslationsDashboardHomeGuideDe guide = _TranslationsDashboardHomeGuideDe._(_root);
	@override late final _TranslationsDashboardHomeStatsDe stats = _TranslationsDashboardHomeStatsDe._(_root);
}

// Path: history.period
class _TranslationsHistoryPeriodDe implements TranslationsHistoryPeriodEn {
	_TranslationsHistoryPeriodDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get today => 'Heute';
	@override String get week => 'Diese Woche';
	@override String get month => 'Diesen Monat';
	@override String get all => 'Gesamt';
}

// Path: history.kpi
class _TranslationsHistoryKpiDe implements TranslationsHistoryKpiEn {
	_TranslationsHistoryKpiDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get usage_time => 'Nutzungszeit';
	@override String get chars => 'Zeichen';
	@override String get time_saved => 'Eingesparte Zeit';
	@override String get requests => 'Anfragen';
	@override String get refine => 'Verfeinerungen';
	@override String get translate => 'Übersetzungen';
}

// Path: settings.ui_settings.app_language
class _TranslationsSettingsUiSettingsAppLanguageDe implements TranslationsSettingsUiSettingsAppLanguageEn {
	_TranslationsSettingsUiSettingsAppLanguageDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'App-Sprache';
	@override String get subtitle => 'Ändern Sie die Sprache der gesamten Anwendung';
}

// Path: settings.ui_settings.font
class _TranslationsSettingsUiSettingsFontDe implements TranslationsSettingsUiSettingsFontEn {
	_TranslationsSettingsUiSettingsFontDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Anzeigeschriftart';
	@override String get subtitle => 'Globale Änderung der Textanzeigeschriftart';
}

// Path: settings.system_settings.startup
class _TranslationsSettingsSystemSettingsStartupDe implements TranslationsSettingsSystemSettingsStartupEn {
	_TranslationsSettingsSystemSettingsStartupDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Beim Start ausführen';
	@override String get subtitle => 'Nach der Anmeldung automatisch im Hintergrund ausführen';
}

// Path: settings.system_settings.backend
class _TranslationsSettingsSystemSettingsBackendDe implements TranslationsSettingsSystemSettingsBackendEn {
	_TranslationsSettingsSystemSettingsBackendDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Backend-Knoten';
	@override String get subtitle => 'US Ultra-schneller Knoten (Groq) oder CN-Knoten (SiliconFlow)';
	@override String get us => 'US/Europa';
	@override String get cn => 'China';
}

// Path: settings.hotkeys.refine
class _TranslationsSettingsHotkeysRefineDe implements TranslationsSettingsHotkeysRefineEn {
	_TranslationsSettingsHotkeysRefineDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Verfeinerungsmodus (Umschalten)';
	@override String get subtitle => 'Binden Sie eine globale Umschalttaste';
}

// Path: settings.hotkeys.translate
class _TranslationsSettingsHotkeysTranslateDe implements TranslationsSettingsHotkeysTranslateEn {
	_TranslationsSettingsHotkeysTranslateDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Übersetzungsmodus (Umschalten)';
	@override String get subtitle => 'Sprechen und sofort in die Zielsprache übersetzen';
}

// Path: settings.translation.target_lang
class _TranslationsSettingsTranslationTargetLangDe implements TranslationsSettingsTranslationTargetLangEn {
	_TranslationsSettingsTranslationTargetLangDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zielsprache';
	@override String get subtitle => 'Standardsprache für die Übersetzung';
}

// Path: dashboard.home.guide
class _TranslationsDashboardHomeGuideDe implements TranslationsDashboardHomeGuideEn {
	_TranslationsDashboardHomeGuideDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Schnellstartanleitung';
	@override late final _TranslationsDashboardHomeGuideVoiceInputDe voice_input = _TranslationsDashboardHomeGuideVoiceInputDe._(_root);
	@override late final _TranslationsDashboardHomeGuideRealtimeTranslateDe realtime_translate = _TranslationsDashboardHomeGuideRealtimeTranslateDe._(_root);
	@override late final _TranslationsDashboardHomeGuideSmartFormatDe smart_format = _TranslationsDashboardHomeGuideSmartFormatDe._(_root);
}

// Path: dashboard.home.stats
class _TranslationsDashboardHomeStatsDe implements TranslationsDashboardHomeStatsEn {
	_TranslationsDashboardHomeStatsDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get focus_performance => 'Fokus-Leistung';
	@override String hours({required Object hours}) => '${hours} Stunden';
	@override List<String> get days => [
		'Mo',
		'Di',
		'Mi',
		'Do',
		'Fr',
		'Sa',
		'So',
	];
	@override String get goal_reached => 'Heutiges Ziel erreicht';
	@override String processed_words({required Object words}) => 'Verarbeitete Wörter ${words}';
}

// Path: dashboard.home.guide.voice_input
class _TranslationsDashboardHomeGuideVoiceInputDe implements TranslationsDashboardHomeGuideVoiceInputEn {
	_TranslationsDashboardHomeGuideVoiceInputDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Fn für Spracheingabe';
	@override String get desc => 'Fn gedrückt halten, sprechen und loslassen.';
}

// Path: dashboard.home.guide.realtime_translate
class _TranslationsDashboardHomeGuideRealtimeTranslateDe implements TranslationsDashboardHomeGuideRealtimeTranslateEn {
	_TranslationsDashboardHomeGuideRealtimeTranslateDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Shift + Fn für Übersetzung';
	@override String get desc => 'Shift und Fn für Echtzeit-Übersetzung halten.';
}

// Path: dashboard.home.guide.smart_format
class _TranslationsDashboardHomeGuideSmartFormatDe implements TranslationsDashboardHomeGuideSmartFormatEn {
	_TranslationsDashboardHomeGuideSmartFormatDe._(this._root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Smarter Formatierungsassistent';
	@override String get desc => 'Das System merkt sich Ihren Schreibstil.';
}

/// The flat map containing all translations for locale <de>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'status.idle' => 'Drücken Sie Fn zum Aufnehmen',
			'status.translating' => '🌐 Übersetzen... (Fn loslassen zum Stoppen)',
			'status.listening' => '🎤 Zuhören... (Fn loslassen zum Stoppen)',
			'status.network_disconnected_title' => '🔴 Keine Netzwerkverbindung',
			'status.network_disconnected_desc' => 'Bitte überprüfen Sie die Netzwerkverbindung',
			'status.network_disconnected_short' => 'Kein Netzwerk',
			'status.accessibility_permission' => 'Eingabehilfen-Berechtigung zum automatischen Einfügen erforderlich',
			'status.mic_permission' => 'Mikrofon nicht autorisiert',
			'status.processing' => '✨ Wird verarbeitet...',
			'status.paste_success' => '✅ Erfolgreich eingefügt',
			'status.paste_success_times' => ({required Object asrSec, required Object llmSec}) => '✅ [ASR: ${asrSec}s | LLM: ${llmSec}s]',
			'status.mode_recording' => 'Aufnahme',
			'status.mode_translating' => 'Übersetzen',
			'status.recording_failed' => 'Aufnahme fehlgeschlagen',
			'status.no_voice_detected' => 'Keine Stimme erkannt',
			'status.processing_short' => 'Verarbeiten',
			'common.min_sec' => ({required Object min, required Object sec}) => '${min}m ${sec}s',
			'common.hour_min' => ({required Object hour, required Object min}) => '${hour}h ${min}m',
			'common.n_minutes' => ({required Object n}) => '${n} Min.',
			'common.n_hours' => ({required Object n, required Object min}) => '${n} Std. ${min} Min.',
			'locales.en' => 'Englisch',
			'locales.zhHans' => 'Vereinfachtes Chinesisch',
			'locales.zhHant' => 'Traditionelles Chinesisch',
			'locales.ja' => 'Japanisch',
			'locales.de' => 'Deutsch',
			'locales.es' => 'Spanisch',
			'settings.title' => 'App-Einstellungen',
			'settings.subtitle' => 'Passen Sie Ihr Tipp-Erlebnis an.',
			'settings.ui_settings.title' => 'UI-Einstellungen',
			'settings.ui_settings.app_language.title' => 'App-Sprache',
			'settings.ui_settings.app_language.subtitle' => 'Ändern Sie die Sprache der gesamten Anwendung',
			'settings.ui_settings.font.title' => 'Anzeigeschriftart',
			'settings.ui_settings.font.subtitle' => 'Globale Änderung der Textanzeigeschriftart',
			'settings.system_settings.title' => 'Systemeinstellungen',
			'settings.system_settings.startup.title' => 'Beim Start ausführen',
			'settings.system_settings.startup.subtitle' => 'Nach der Anmeldung automatisch im Hintergrund ausführen',
			'settings.system_settings.backend.title' => 'Backend-Knoten',
			'settings.system_settings.backend.subtitle' => 'US Ultra-schneller Knoten (Groq) oder CN-Knoten (SiliconFlow)',
			'settings.system_settings.backend.us' => 'US/Europa',
			'settings.system_settings.backend.cn' => 'China',
			'settings.hotkeys.title' => 'Hotkeys & Auslöser',
			'settings.hotkeys.refine.title' => 'Verfeinerungsmodus (Umschalten)',
			'settings.hotkeys.refine.subtitle' => 'Binden Sie eine globale Umschalttaste',
			'settings.hotkeys.translate.title' => 'Übersetzungsmodus (Umschalten)',
			'settings.hotkeys.translate.subtitle' => 'Sprechen und sofort in die Zielsprache übersetzen',
			'settings.hotkeys.click_to_set' => 'Klicken zum Einstellen',
			'settings.hotkeys.cancel' => 'Abbrechen',
			'settings.hotkeys.record_title' => ({required Object title}) => '${title} Hotkey aufzeichnen',
			'settings.hotkeys.record_desc' => 'Drücken Sie die gewünschte Tastenkombination...',
			'settings.translation.title' => 'Übersetzungsstrategie',
			'settings.translation.target_lang.title' => 'Zielsprache',
			'settings.translation.target_lang.subtitle' => 'Standardsprache für die Übersetzung',
			'settings.target_languages.en' => 'Englisch',
			'settings.target_languages.ja' => 'Japanisch',
			'settings.target_languages.ko' => 'Koreanisch',
			'settings.target_languages.fr' => 'Französisch',
			'settings.target_languages.de' => 'Deutsch',
			'settings.target_languages.ru' => 'Russisch',
			'settings.target_languages.es' => 'Spanisch',
			'settings.target_languages.it' => 'Italienisch',
			'settings.target_languages.pt' => 'Portugiesisch',
			'settings.target_languages.nl' => 'Niederländisch',
			'settings.target_languages.ar' => 'Arabisch',
			'settings.target_languages.tr' => 'Türkisch',
			'settings.target_languages.sv' => 'Schwedisch',
			'settings.target_languages.hi' => 'Hindi',
			'settings.target_languages.th' => 'Thailändisch',
			'settings.target_languages.vi' => 'Vietnamesisch',
			'settings.target_languages.id' => 'Indonesisch',
			'settings.target_languages.zh_Hans' => 'Vereinfachtes Chinesisch',
			'settings.target_languages.zh_Hant' => 'Traditionelles Chinesisch',
			'dashboard.sidebar.home' => 'Startseite',
			'dashboard.sidebar.history' => 'Verlauf',
			'dashboard.sidebar.settings' => 'Einstellungen',
			'dashboard.home.greeting' => 'Hallo Generator',
			'dashboard.home.subtitle' => 'Heutiger Fokus bereit',
			'dashboard.home.guide.title' => 'Schnellstartanleitung',
			'dashboard.home.guide.voice_input.title' => 'Fn für Spracheingabe',
			'dashboard.home.guide.voice_input.desc' => 'Fn gedrückt halten, sprechen und loslassen.',
			'dashboard.home.guide.realtime_translate.title' => 'Shift + Fn für Übersetzung',
			'dashboard.home.guide.realtime_translate.desc' => 'Shift und Fn für Echtzeit-Übersetzung halten.',
			'dashboard.home.guide.smart_format.title' => 'Smarter Formatierungsassistent',
			'dashboard.home.guide.smart_format.desc' => 'Das System merkt sich Ihren Schreibstil.',
			'dashboard.home.stats.focus_performance' => 'Fokus-Leistung',
			'dashboard.home.stats.hours' => ({required Object hours}) => '${hours} Stunden',
			'dashboard.home.stats.days.0' => 'Mo',
			'dashboard.home.stats.days.1' => 'Di',
			'dashboard.home.stats.days.2' => 'Mi',
			'dashboard.home.stats.days.3' => 'Do',
			'dashboard.home.stats.days.4' => 'Fr',
			'dashboard.home.stats.days.5' => 'Sa',
			'dashboard.home.stats.days.6' => 'So',
			'dashboard.home.stats.goal_reached' => 'Heutiges Ziel erreicht',
			'dashboard.home.stats.processed_words' => ({required Object words}) => 'Verarbeitete Wörter ${words}',
			'dashboard.chars_unit' => 'Zeichen',
			'dashboard.unlimited' => 'Unbegrenzt',
			'history.title' => 'Erstellungsverlauf',
			'history.time_saved' => ({required Object time}) => 'Insgesamt ${time} Tippzeit gespart.',
			'history.empty' => 'Keine Aufzeichnungen vorhanden\nDrücken Sie Fn, um zu beginnen',
			'history.mode_translate' => 'Fremdsprachenübersetzung',
			'history.mode_refine' => 'Muttersprachliche Verfeinerung',
			'history.asr_label' => '🎙️ Spracherkennung: ',
			'history.llm_label' => '✨ Smarte Verfeinerung: ',
			'history.seconds' => ({required Object seconds}) => '${seconds} Sekunden',
			'history.minutes' => ({required Object minutes}) => '${minutes} Minuten',
			'history.period.today' => 'Heute',
			'history.period.week' => 'Diese Woche',
			'history.period.month' => 'Diesen Monat',
			'history.period.all' => 'Gesamt',
			'history.kpi.usage_time' => 'Nutzungszeit',
			'history.kpi.chars' => 'Zeichen',
			'history.kpi.time_saved' => 'Eingesparte Zeit',
			'history.kpi.requests' => 'Anfragen',
			'history.kpi.refine' => 'Verfeinerungen',
			'history.kpi.translate' => 'Übersetzungen',
			'onboarding.step1_title' => 'Natürlich sprechen, perfekt schreiben',
			'onboarding.step1_subtitle' => 'Halten Sie Fn gedrückt zum Aufnehmen\nLoslassen für automatische Verfeinerung und Einfügen',
			'onboarding.step1_action' => 'Weiter',
			'onboarding.step2_title' => 'Mikrofon autorisieren',
			'onboarding.step2_action' => 'Systemberechtigung erteilen',
			'onboarding.step3_title' => 'Bedienungshilfen aktivieren',
			'onboarding.step3_subtitle' => 'Für nahtlose Eingabe\nBitte aktivieren Sie Bedienungshilfen für Audio Translate Input in den Systemeinstellungen',
			'onboarding.step3_action' => 'Systemberechtigung prüfen',
			'onboarding.step4_title' => 'Praxisübung',
			'onboarding.step4_subtitle' => 'Alles bereit! Halten Sie Fn gedrückt und sagen Sie etwas\nErleben Sie eine neue Effizienzrevolution',
			'onboarding.step4_action' => 'Reise beginnen',
			'onboarding.skip' => 'Guide überspringen',
			'onboarding.mic_permission_subtitle' => 'Audio Translate Input benötigt Mikrofonzugriff\num Ihre Stimme in präzisen Text umzuwandeln',
			'onboarding.complete_trial' => 'Test abschließen',
			'onboarding.hold_fn_hint' => 'Halten Sie Fn gedrückt und sagen Sie etwas...',
			'onboarding.listening' => 'Zuhören... (Sprechen Sie frei)',
			'onboarding.refining' => 'Verfeinern...',
			'onboarding.trial_success' => 'Test erfolgreich! Das ist die Magie von Audio Translate Input.',
			'onboarding.click_to_simulate' => '(Sie können dieses Feld anklicken, um einen Tastendruck zu simulieren)',
			'onboarding.accessibility_warning' => 'Bedienungshilfen-Berechtigung nicht erteilt. Bitte aktivieren Sie Audio Translate Input im angezeigten Systemeinstellungs-Dialog.',
			'vocab.title' => 'Persönliches Wörterbuch',
			'vocab.subtitle' => 'Bringe der KI deine bevorzugten Ausdrücke bei',
			'vocab.add_title' => 'Eigenen Ausdruck hinzufügen',
			'vocab.spoken_hint' => 'Was du sagst (gesprochene Form)',
			'vocab.written_hint' => 'Was geschrieben werden soll (Schriftform)',
			'vocab.add_btn' => 'Hinzufügen',
			'vocab.empty' => 'Noch keine eigenen Ausdrücke',
			_ => null,
		};
	}
}
