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
class TranslationsEs with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsStatusEs status = _TranslationsStatusEs._(_root);
	@override late final _TranslationsCommonEs common = _TranslationsCommonEs._(_root);
	@override late final _TranslationsLocalesEs locales = _TranslationsLocalesEs._(_root);
	@override late final _TranslationsSettingsEs settings = _TranslationsSettingsEs._(_root);
	@override late final _TranslationsDashboardEs dashboard = _TranslationsDashboardEs._(_root);
	@override late final _TranslationsHistoryEs history = _TranslationsHistoryEs._(_root);
	@override late final _TranslationsOnboardingEs onboarding = _TranslationsOnboardingEs._(_root);
	@override late final _TranslationsVocabEs vocab = _TranslationsVocabEs._(_root);
}

// Path: status
class _TranslationsStatusEs implements TranslationsStatusEn {
	_TranslationsStatusEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get idle => 'Presiona Fn para grabar';
	@override String get translating => '🌐 Traducción... (Suelta Fn para detener)';
	@override String get listening => '🎤 Escuchando... (Suelta Fn para detener)';
	@override String get network_disconnected_title => '🔴 Sin conexión a red';
	@override String get network_disconnected_desc => 'Verifica tu conexión a red';
	@override String get network_disconnected_short => 'Sin red';
	@override String get accessibility_permission => 'Permiso de accesibilidad requerido para autopegar, otórgalo en los ajustes';
	@override String get mic_permission => 'Micrófono no autorizado';
	@override String get processing => '✨ Procesando...';
	@override String get paste_success => '✅ Pegado exitoso';
	@override String paste_success_times({required Object asrSec, required Object llmSec}) => '✅ [ASR: ${asrSec}s | LLM: ${llmSec}s]';
	@override String get mode_recording => 'Grabando';
	@override String get mode_translating => 'Traduciendo';
	@override String get recording_failed => 'Error al grabar';
	@override String get no_voice_detected => 'No se detectó voz';
	@override String get processing_short => 'Procesando';
}

// Path: common
class _TranslationsCommonEs implements TranslationsCommonEn {
	_TranslationsCommonEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String min_sec({required Object min, required Object sec}) => '${min}m ${sec}s';
	@override String hour_min({required Object hour, required Object min}) => '${hour}h ${min}m';
	@override String n_minutes({required Object n}) => '${n} min';
	@override String n_hours({required Object n, required Object min}) => '${n} h ${min} min';
}

// Path: locales
class _TranslationsLocalesEs implements TranslationsLocalesEn {
	_TranslationsLocalesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get en => 'Inglés';
	@override String get zhHans => 'Chino Simplificado';
	@override String get zhHant => 'Chino Tradicional';
	@override String get ja => 'Japonés';
	@override String get de => 'Alemán';
	@override String get es => 'Español';
}

// Path: settings
class _TranslationsSettingsEs implements TranslationsSettingsEn {
	_TranslationsSettingsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ajustes de la aplicación';
	@override String get subtitle => 'Personaliza tu experiencia de escritura.';
	@override late final _TranslationsSettingsUiSettingsEs ui_settings = _TranslationsSettingsUiSettingsEs._(_root);
	@override late final _TranslationsSettingsSystemSettingsEs system_settings = _TranslationsSettingsSystemSettingsEs._(_root);
	@override late final _TranslationsSettingsHotkeysEs hotkeys = _TranslationsSettingsHotkeysEs._(_root);
	@override late final _TranslationsSettingsTranslationEs translation = _TranslationsSettingsTranslationEs._(_root);
	@override late final _TranslationsSettingsTargetLanguagesEs target_languages = _TranslationsSettingsTargetLanguagesEs._(_root);
}

// Path: dashboard
class _TranslationsDashboardEs implements TranslationsDashboardEn {
	_TranslationsDashboardEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDashboardSidebarEs sidebar = _TranslationsDashboardSidebarEs._(_root);
	@override late final _TranslationsDashboardHomeEs home = _TranslationsDashboardHomeEs._(_root);
	@override String get chars_unit => 'caracteres';
	@override String get unlimited => 'Ilimitado';
}

// Path: history
class _TranslationsHistoryEs implements TranslationsHistoryEn {
	_TranslationsHistoryEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Historial de creación';
	@override String time_saved({required Object time}) => 'Has ahorrado ${time} de tiempo de escritura.';
	@override String get empty => 'Sin registros aún\nPresiona Fn para comenzar tu primera transcripción';
	@override String get mode_translate => 'Traducción extranjera';
	@override String get mode_refine => 'Refinamiento nativo';
	@override String get asr_label => '🎙️ Reconocimiento de voz: ';
	@override String get llm_label => '✨ Refinamiento inteligente: ';
	@override String seconds({required Object seconds}) => '${seconds} segundos';
	@override String minutes({required Object minutes}) => '${minutes} minutos';
	@override late final _TranslationsHistoryPeriodEs period = _TranslationsHistoryPeriodEs._(_root);
	@override late final _TranslationsHistoryKpiEs kpi = _TranslationsHistoryKpiEs._(_root);
}

// Path: onboarding
class _TranslationsOnboardingEs implements TranslationsOnboardingEn {
	_TranslationsOnboardingEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get step1_title => 'Habla natural, escribe perfecto';
	@override String get step1_subtitle => 'Mantén Fn para grabar\nSuelta para refinar automáticamente y pegar en la ventana activa';
	@override String get step1_action => 'Siguiente';
	@override String get step2_title => 'Autorizar micrófono';
	@override String get step2_action => 'Otorgar permiso del sistema';
	@override String get step3_title => 'Activar accesibilidad';
	@override String get step3_subtitle => 'Para una entrada perfecta\nActiva la accesibilidad para Audio Translate Input en Preferencias del Sistema';
	@override String get step3_action => 'Verificar permiso del sistema';
	@override String get step4_title => 'Práctica';
	@override String get step4_subtitle => '¡Todo listo! Mantén Fn y di algo\nPrepárate para una nueva revolución de eficiencia';
	@override String get step4_action => 'Comenzar viaje';
	@override String get skip => 'Saltar guía';
	@override String get mic_permission_subtitle => 'Audio Translate Input necesita permiso de micrófono\npara convertir tu voz en texto preciso';
	@override String get complete_trial => 'Completar prueba';
	@override String get hold_fn_hint => 'Mantén presionada la tecla Fn y di algo...';
	@override String get listening => 'Escuchando... (Habla libremente)';
	@override String get refining => 'Refinando...';
	@override String get trial_success => '¡Prueba exitosa! Esta es la magia de Audio Translate Input.';
	@override String get click_to_simulate => '(Puedes hacer clic en este cuadro para simular una pulsación de tecla)';
	@override String get accessibility_warning => 'Permiso de accesibilidad no otorgado. Por favor, habilita Audio Translate Input en el diálogo de configuración del sistema que aparece.';
}

// Path: vocab
class _TranslationsVocabEs implements TranslationsVocabEn {
	_TranslationsVocabEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Diccionario Personal';
	@override String get subtitle => 'Enseña a la IA tus expresiones preferidas';
	@override String get add_title => 'Agregar expresión personalizada';
	@override String get spoken_hint => 'Lo que dices (forma hablada)';
	@override String get written_hint => 'Lo que quieres escrito (forma escrita)';
	@override String get add_btn => 'Agregar';
	@override String get empty => 'Aún no hay expresiones personalizadas';
}

// Path: settings.ui_settings
class _TranslationsSettingsUiSettingsEs implements TranslationsSettingsUiSettingsEn {
	_TranslationsSettingsUiSettingsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ajustes de UI';
	@override late final _TranslationsSettingsUiSettingsAppLanguageEs app_language = _TranslationsSettingsUiSettingsAppLanguageEs._(_root);
	@override late final _TranslationsSettingsUiSettingsFontEs font = _TranslationsSettingsUiSettingsFontEs._(_root);
}

// Path: settings.system_settings
class _TranslationsSettingsSystemSettingsEs implements TranslationsSettingsSystemSettingsEn {
	_TranslationsSettingsSystemSettingsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ajustes del sistema';
	@override late final _TranslationsSettingsSystemSettingsStartupEs startup = _TranslationsSettingsSystemSettingsStartupEs._(_root);
	@override late final _TranslationsSettingsSystemSettingsBackendEs backend = _TranslationsSettingsSystemSettingsBackendEs._(_root);
}

// Path: settings.hotkeys
class _TranslationsSettingsHotkeysEs implements TranslationsSettingsHotkeysEn {
	_TranslationsSettingsHotkeysEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Teclas de acceso rápido y activadores';
	@override late final _TranslationsSettingsHotkeysRefineEs refine = _TranslationsSettingsHotkeysRefineEs._(_root);
	@override late final _TranslationsSettingsHotkeysTranslateEs translate = _TranslationsSettingsHotkeysTranslateEs._(_root);
	@override String get click_to_set => 'Hacer clic para establecer';
	@override String get cancel => 'Cancelar';
	@override String record_title({required Object title}) => 'Grabar tecla rápida para ${title}';
	@override String get record_desc => 'Presiona tu combinación de teclas deseada directamente en el teclado...';
}

// Path: settings.translation
class _TranslationsSettingsTranslationEs implements TranslationsSettingsTranslationEn {
	_TranslationsSettingsTranslationEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Estrategia de traducción';
	@override late final _TranslationsSettingsTranslationTargetLangEs target_lang = _TranslationsSettingsTranslationTargetLangEs._(_root);
}

// Path: settings.target_languages
class _TranslationsSettingsTargetLanguagesEs implements TranslationsSettingsTargetLanguagesEn {
	_TranslationsSettingsTargetLanguagesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get en => 'Inglés';
	@override String get ja => 'Japonés';
	@override String get ko => 'Coreano';
	@override String get fr => 'Francés';
	@override String get de => 'Alemán';
	@override String get ru => 'Ruso';
	@override String get es => 'Español';
	@override String get it => 'Italiano';
	@override String get pt => 'Portugués';
	@override String get nl => 'Holandés';
	@override String get ar => 'Árabe';
	@override String get tr => 'Turco';
	@override String get sv => 'Sueco';
	@override String get hi => 'Hindi';
	@override String get th => 'Tailandés';
	@override String get vi => 'Vietnamita';
	@override String get id => 'Indonesio';
	@override String get zh_Hans => 'Chino Simplificado';
	@override String get zh_Hant => 'Chino Tradicional';
}

// Path: dashboard.sidebar
class _TranslationsDashboardSidebarEs implements TranslationsDashboardSidebarEn {
	_TranslationsDashboardSidebarEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get home => 'Inicio';
	@override String get history => 'Historial';
	@override String get settings => 'Ajustes';
}

// Path: dashboard.home
class _TranslationsDashboardHomeEs implements TranslationsDashboardHomeEn {
	_TranslationsDashboardHomeEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get greeting => 'Hola, Creador';
	@override String get subtitle => 'Flujo de enfoque listo para hoy';
	@override late final _TranslationsDashboardHomeGuideEs guide = _TranslationsDashboardHomeGuideEs._(_root);
	@override late final _TranslationsDashboardHomeStatsEs stats = _TranslationsDashboardHomeStatsEs._(_root);
}

// Path: history.period
class _TranslationsHistoryPeriodEs implements TranslationsHistoryPeriodEn {
	_TranslationsHistoryPeriodEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get today => 'Hoy';
	@override String get week => 'Esta semana';
	@override String get month => 'Este mes';
	@override String get all => 'Total';
}

// Path: history.kpi
class _TranslationsHistoryKpiEs implements TranslationsHistoryKpiEn {
	_TranslationsHistoryKpiEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get usage_time => 'Tiempo de uso';
	@override String get chars => 'Caracteres';
	@override String get time_saved => 'Tiempo ahorrado';
	@override String get requests => 'Solicitudes';
	@override String get refine => 'Refinamientos';
	@override String get translate => 'Traducciones';
}

// Path: settings.ui_settings.app_language
class _TranslationsSettingsUiSettingsAppLanguageEs implements TranslationsSettingsUiSettingsAppLanguageEn {
	_TranslationsSettingsUiSettingsAppLanguageEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Idioma de la aplicación';
	@override String get subtitle => 'Cambia el idioma general de la aplicación';
}

// Path: settings.ui_settings.font
class _TranslationsSettingsUiSettingsFontEs implements TranslationsSettingsUiSettingsFontEn {
	_TranslationsSettingsUiSettingsFontEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Fuente de visualización';
	@override String get subtitle => 'Cambiar globalmente la fuente de visualización de texto';
}

// Path: settings.system_settings.startup
class _TranslationsSettingsSystemSettingsStartupEs implements TranslationsSettingsSystemSettingsStartupEn {
	_TranslationsSettingsSystemSettingsStartupEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Iniciar al arrancar';
	@override String get subtitle => 'Ejecutar automáticamente en segundo plano después de iniciar sesión';
}

// Path: settings.system_settings.backend
class _TranslationsSettingsSystemSettingsBackendEs implements TranslationsSettingsSystemSettingsBackendEn {
	_TranslationsSettingsSystemSettingsBackendEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nodo de backend';
	@override String get subtitle => 'Nodo ultra rápido de EE. UU. (Groq) o Nodo de CN (SiliconFlow)';
	@override String get us => 'EE. UU./Europa';
	@override String get cn => 'China';
}

// Path: settings.hotkeys.refine
class _TranslationsSettingsHotkeysRefineEs implements TranslationsSettingsHotkeysRefineEn {
	_TranslationsSettingsHotkeysRefineEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Modo de refinamiento (Alternar)';
	@override String get subtitle => 'Asigna una tecla de alternancia global';
}

// Path: settings.hotkeys.translate
class _TranslationsSettingsHotkeysTranslateEs implements TranslationsSettingsHotkeysTranslateEn {
	_TranslationsSettingsHotkeysTranslateEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Modo de traducción (Alternar)';
	@override String get subtitle => 'Habla y traduce inmediatamente al idioma de destino';
}

// Path: settings.translation.target_lang
class _TranslationsSettingsTranslationTargetLangEs implements TranslationsSettingsTranslationTargetLangEn {
	_TranslationsSettingsTranslationTargetLangEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Idioma destino';
	@override String get subtitle => 'Idioma predeterminado para traducir';
}

// Path: dashboard.home.guide
class _TranslationsDashboardHomeGuideEs implements TranslationsDashboardHomeGuideEn {
	_TranslationsDashboardHomeGuideEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Guía de inicio rápido';
	@override late final _TranslationsDashboardHomeGuideVoiceInputEs voice_input = _TranslationsDashboardHomeGuideVoiceInputEs._(_root);
	@override late final _TranslationsDashboardHomeGuideRealtimeTranslateEs realtime_translate = _TranslationsDashboardHomeGuideRealtimeTranslateEs._(_root);
	@override late final _TranslationsDashboardHomeGuideSmartFormatEs smart_format = _TranslationsDashboardHomeGuideSmartFormatEs._(_root);
}

// Path: dashboard.home.stats
class _TranslationsDashboardHomeStatsEs implements TranslationsDashboardHomeStatsEn {
	_TranslationsDashboardHomeStatsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get focus_performance => 'Rendimiento de enfoque';
	@override String hours({required Object hours}) => '${hours} Horas';
	@override List<String> get days => [
		'Lun',
		'Mar',
		'Mié',
		'Jue',
		'Vie',
		'Sáb',
		'Dom',
	];
	@override String get goal_reached => 'Inspiración de hoy';
	@override String processed_words({required Object words}) => 'Palabras procesadas ${words}';
}

// Path: dashboard.home.guide.voice_input
class _TranslationsDashboardHomeGuideVoiceInputEs implements TranslationsDashboardHomeGuideVoiceInputEn {
	_TranslationsDashboardHomeGuideVoiceInputEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Fn para entrada de voz';
	@override String get desc => 'Mantén presionado Fn en cualquier cuadro de texto para hablar, suelta para refinar y pegar automáticamente.';
}

// Path: dashboard.home.guide.realtime_translate
class _TranslationsDashboardHomeGuideRealtimeTranslateEs implements TranslationsDashboardHomeGuideRealtimeTranslateEn {
	_TranslationsDashboardHomeGuideRealtimeTranslateEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Shift + Fn para Traducción';
	@override String get desc => 'Mantén presionado Shift y Fn para traducir en tiempo real.';
}

// Path: dashboard.home.guide.smart_format
class _TranslationsDashboardHomeGuideSmartFormatEs implements TranslationsDashboardHomeGuideSmartFormatEn {
	_TranslationsDashboardHomeGuideSmartFormatEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Asistente de formato inteligente';
	@override String get desc => 'El sistema registrará automáticamente tu estilo de escritura.';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'status.idle' => 'Presiona Fn para grabar',
			'status.translating' => '🌐 Traducción... (Suelta Fn para detener)',
			'status.listening' => '🎤 Escuchando... (Suelta Fn para detener)',
			'status.network_disconnected_title' => '🔴 Sin conexión a red',
			'status.network_disconnected_desc' => 'Verifica tu conexión a red',
			'status.network_disconnected_short' => 'Sin red',
			'status.accessibility_permission' => 'Permiso de accesibilidad requerido para autopegar, otórgalo en los ajustes',
			'status.mic_permission' => 'Micrófono no autorizado',
			'status.processing' => '✨ Procesando...',
			'status.paste_success' => '✅ Pegado exitoso',
			'status.paste_success_times' => ({required Object asrSec, required Object llmSec}) => '✅ [ASR: ${asrSec}s | LLM: ${llmSec}s]',
			'status.mode_recording' => 'Grabando',
			'status.mode_translating' => 'Traduciendo',
			'status.recording_failed' => 'Error al grabar',
			'status.no_voice_detected' => 'No se detectó voz',
			'status.processing_short' => 'Procesando',
			'common.min_sec' => ({required Object min, required Object sec}) => '${min}m ${sec}s',
			'common.hour_min' => ({required Object hour, required Object min}) => '${hour}h ${min}m',
			'common.n_minutes' => ({required Object n}) => '${n} min',
			'common.n_hours' => ({required Object n, required Object min}) => '${n} h ${min} min',
			'locales.en' => 'Inglés',
			'locales.zhHans' => 'Chino Simplificado',
			'locales.zhHant' => 'Chino Tradicional',
			'locales.ja' => 'Japonés',
			'locales.de' => 'Alemán',
			'locales.es' => 'Español',
			'settings.title' => 'Ajustes de la aplicación',
			'settings.subtitle' => 'Personaliza tu experiencia de escritura.',
			'settings.ui_settings.title' => 'Ajustes de UI',
			'settings.ui_settings.app_language.title' => 'Idioma de la aplicación',
			'settings.ui_settings.app_language.subtitle' => 'Cambia el idioma general de la aplicación',
			'settings.ui_settings.font.title' => 'Fuente de visualización',
			'settings.ui_settings.font.subtitle' => 'Cambiar globalmente la fuente de visualización de texto',
			'settings.system_settings.title' => 'Ajustes del sistema',
			'settings.system_settings.startup.title' => 'Iniciar al arrancar',
			'settings.system_settings.startup.subtitle' => 'Ejecutar automáticamente en segundo plano después de iniciar sesión',
			'settings.system_settings.backend.title' => 'Nodo de backend',
			'settings.system_settings.backend.subtitle' => 'Nodo ultra rápido de EE. UU. (Groq) o Nodo de CN (SiliconFlow)',
			'settings.system_settings.backend.us' => 'EE. UU./Europa',
			'settings.system_settings.backend.cn' => 'China',
			'settings.hotkeys.title' => 'Teclas de acceso rápido y activadores',
			'settings.hotkeys.refine.title' => 'Modo de refinamiento (Alternar)',
			'settings.hotkeys.refine.subtitle' => 'Asigna una tecla de alternancia global',
			'settings.hotkeys.translate.title' => 'Modo de traducción (Alternar)',
			'settings.hotkeys.translate.subtitle' => 'Habla y traduce inmediatamente al idioma de destino',
			'settings.hotkeys.click_to_set' => 'Hacer clic para establecer',
			'settings.hotkeys.cancel' => 'Cancelar',
			'settings.hotkeys.record_title' => ({required Object title}) => 'Grabar tecla rápida para ${title}',
			'settings.hotkeys.record_desc' => 'Presiona tu combinación de teclas deseada directamente en el teclado...',
			'settings.translation.title' => 'Estrategia de traducción',
			'settings.translation.target_lang.title' => 'Idioma destino',
			'settings.translation.target_lang.subtitle' => 'Idioma predeterminado para traducir',
			'settings.target_languages.en' => 'Inglés',
			'settings.target_languages.ja' => 'Japonés',
			'settings.target_languages.ko' => 'Coreano',
			'settings.target_languages.fr' => 'Francés',
			'settings.target_languages.de' => 'Alemán',
			'settings.target_languages.ru' => 'Ruso',
			'settings.target_languages.es' => 'Español',
			'settings.target_languages.it' => 'Italiano',
			'settings.target_languages.pt' => 'Portugués',
			'settings.target_languages.nl' => 'Holandés',
			'settings.target_languages.ar' => 'Árabe',
			'settings.target_languages.tr' => 'Turco',
			'settings.target_languages.sv' => 'Sueco',
			'settings.target_languages.hi' => 'Hindi',
			'settings.target_languages.th' => 'Tailandés',
			'settings.target_languages.vi' => 'Vietnamita',
			'settings.target_languages.id' => 'Indonesio',
			'settings.target_languages.zh_Hans' => 'Chino Simplificado',
			'settings.target_languages.zh_Hant' => 'Chino Tradicional',
			'dashboard.sidebar.home' => 'Inicio',
			'dashboard.sidebar.history' => 'Historial',
			'dashboard.sidebar.settings' => 'Ajustes',
			'dashboard.home.greeting' => 'Hola, Creador',
			'dashboard.home.subtitle' => 'Flujo de enfoque listo para hoy',
			'dashboard.home.guide.title' => 'Guía de inicio rápido',
			'dashboard.home.guide.voice_input.title' => 'Fn para entrada de voz',
			'dashboard.home.guide.voice_input.desc' => 'Mantén presionado Fn en cualquier cuadro de texto para hablar, suelta para refinar y pegar automáticamente.',
			'dashboard.home.guide.realtime_translate.title' => 'Shift + Fn para Traducción',
			'dashboard.home.guide.realtime_translate.desc' => 'Mantén presionado Shift y Fn para traducir en tiempo real.',
			'dashboard.home.guide.smart_format.title' => 'Asistente de formato inteligente',
			'dashboard.home.guide.smart_format.desc' => 'El sistema registrará automáticamente tu estilo de escritura.',
			'dashboard.home.stats.focus_performance' => 'Rendimiento de enfoque',
			'dashboard.home.stats.hours' => ({required Object hours}) => '${hours} Horas',
			'dashboard.home.stats.days.0' => 'Lun',
			'dashboard.home.stats.days.1' => 'Mar',
			'dashboard.home.stats.days.2' => 'Mié',
			'dashboard.home.stats.days.3' => 'Jue',
			'dashboard.home.stats.days.4' => 'Vie',
			'dashboard.home.stats.days.5' => 'Sáb',
			'dashboard.home.stats.days.6' => 'Dom',
			'dashboard.home.stats.goal_reached' => 'Inspiración de hoy',
			'dashboard.home.stats.processed_words' => ({required Object words}) => 'Palabras procesadas ${words}',
			'dashboard.chars_unit' => 'caracteres',
			'dashboard.unlimited' => 'Ilimitado',
			'history.title' => 'Historial de creación',
			'history.time_saved' => ({required Object time}) => 'Has ahorrado ${time} de tiempo de escritura.',
			'history.empty' => 'Sin registros aún\nPresiona Fn para comenzar tu primera transcripción',
			'history.mode_translate' => 'Traducción extranjera',
			'history.mode_refine' => 'Refinamiento nativo',
			'history.asr_label' => '🎙️ Reconocimiento de voz: ',
			'history.llm_label' => '✨ Refinamiento inteligente: ',
			'history.seconds' => ({required Object seconds}) => '${seconds} segundos',
			'history.minutes' => ({required Object minutes}) => '${minutes} minutos',
			'history.period.today' => 'Hoy',
			'history.period.week' => 'Esta semana',
			'history.period.month' => 'Este mes',
			'history.period.all' => 'Total',
			'history.kpi.usage_time' => 'Tiempo de uso',
			'history.kpi.chars' => 'Caracteres',
			'history.kpi.time_saved' => 'Tiempo ahorrado',
			'history.kpi.requests' => 'Solicitudes',
			'history.kpi.refine' => 'Refinamientos',
			'history.kpi.translate' => 'Traducciones',
			'onboarding.step1_title' => 'Habla natural, escribe perfecto',
			'onboarding.step1_subtitle' => 'Mantén Fn para grabar\nSuelta para refinar automáticamente y pegar en la ventana activa',
			'onboarding.step1_action' => 'Siguiente',
			'onboarding.step2_title' => 'Autorizar micrófono',
			'onboarding.step2_action' => 'Otorgar permiso del sistema',
			'onboarding.step3_title' => 'Activar accesibilidad',
			'onboarding.step3_subtitle' => 'Para una entrada perfecta\nActiva la accesibilidad para Audio Translate Input en Preferencias del Sistema',
			'onboarding.step3_action' => 'Verificar permiso del sistema',
			'onboarding.step4_title' => 'Práctica',
			'onboarding.step4_subtitle' => '¡Todo listo! Mantén Fn y di algo\nPrepárate para una nueva revolución de eficiencia',
			'onboarding.step4_action' => 'Comenzar viaje',
			'onboarding.skip' => 'Saltar guía',
			'onboarding.mic_permission_subtitle' => 'Audio Translate Input necesita permiso de micrófono\npara convertir tu voz en texto preciso',
			'onboarding.complete_trial' => 'Completar prueba',
			'onboarding.hold_fn_hint' => 'Mantén presionada la tecla Fn y di algo...',
			'onboarding.listening' => 'Escuchando... (Habla libremente)',
			'onboarding.refining' => 'Refinando...',
			'onboarding.trial_success' => '¡Prueba exitosa! Esta es la magia de Audio Translate Input.',
			'onboarding.click_to_simulate' => '(Puedes hacer clic en este cuadro para simular una pulsación de tecla)',
			'onboarding.accessibility_warning' => 'Permiso de accesibilidad no otorgado. Por favor, habilita Audio Translate Input en el diálogo de configuración del sistema que aparece.',
			'vocab.title' => 'Diccionario Personal',
			'vocab.subtitle' => 'Enseña a la IA tus expresiones preferidas',
			'vocab.add_title' => 'Agregar expresión personalizada',
			'vocab.spoken_hint' => 'Lo que dices (forma hablada)',
			'vocab.written_hint' => 'Lo que quieres escrito (forma escrita)',
			'vocab.add_btn' => 'Agregar',
			'vocab.empty' => 'Aún no hay expresiones personalizadas',
			_ => null,
		};
	}
}
