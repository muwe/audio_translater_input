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
class TranslationsJa with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsJa({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ja,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ja>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsJa _root = this; // ignore: unused_field

	@override 
	TranslationsJa $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsJa(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsStatusJa status = _TranslationsStatusJa._(_root);
	@override late final _TranslationsCommonJa common = _TranslationsCommonJa._(_root);
	@override late final _TranslationsLocalesJa locales = _TranslationsLocalesJa._(_root);
	@override late final _TranslationsSettingsJa settings = _TranslationsSettingsJa._(_root);
	@override late final _TranslationsDashboardJa dashboard = _TranslationsDashboardJa._(_root);
	@override late final _TranslationsHistoryJa history = _TranslationsHistoryJa._(_root);
	@override late final _TranslationsOnboardingJa onboarding = _TranslationsOnboardingJa._(_root);
	@override late final _TranslationsVocabJa vocab = _TranslationsVocabJa._(_root);
}

// Path: status
class _TranslationsStatusJa implements TranslationsStatusEn {
	_TranslationsStatusJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get idle => 'Fnを押して録音';
	@override String get translating => '🌐 翻訳中... (Fnを離して停止)';
	@override String get listening => '🎤 リスニング中... (Fnを離して停止)';
	@override String get network_disconnected_title => '🔴 ネットワーク未接続';
	@override String get network_disconnected_desc => 'ネットワーク接続をご確認ください';
	@override String get network_disconnected_short => 'ネットワークなし';
	@override String get accessibility_permission => '自動貼り付けにはアクセシビリティ権限が必要です。システム設定で許可してください';
	@override String get mic_permission => 'マイク未認証';
	@override String get processing => '✨ 処理中...';
	@override String get paste_success => '✅ 貼り付け成功';
	@override String paste_success_times({required Object asrSec, required Object llmSec}) => '✅ [ASR: ${asrSec}s | LLM: ${llmSec}s]';
	@override String get mode_recording => '録音';
	@override String get mode_translating => '翻訳';
	@override String get recording_failed => '録音開始に失敗しました';
	@override String get no_voice_detected => '音声が検出されません';
	@override String get processing_short => '処理中';
}

// Path: common
class _TranslationsCommonJa implements TranslationsCommonEn {
	_TranslationsCommonJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String min_sec({required Object min, required Object sec}) => '${min}分 ${sec}秒';
	@override String hour_min({required Object hour, required Object min}) => '${hour}時間 ${min}分';
	@override String n_minutes({required Object n}) => '${n} 分';
	@override String n_hours({required Object n, required Object min}) => '${n} 時間 ${min} 分';
}

// Path: locales
class _TranslationsLocalesJa implements TranslationsLocalesEn {
	_TranslationsLocalesJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get en => '英語';
	@override String get zhHans => '簡体字中国語';
	@override String get zhHant => '繁体字中国語';
	@override String get ja => '日本語';
	@override String get de => 'ドイツ語';
	@override String get es => 'スペイン語';
}

// Path: settings
class _TranslationsSettingsJa implements TranslationsSettingsEn {
	_TranslationsSettingsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'アプリ設定';
	@override String get subtitle => '独自のタイピング体験をカスタマイズ。';
	@override late final _TranslationsSettingsUiSettingsJa ui_settings = _TranslationsSettingsUiSettingsJa._(_root);
	@override late final _TranslationsSettingsSystemSettingsJa system_settings = _TranslationsSettingsSystemSettingsJa._(_root);
	@override late final _TranslationsSettingsHotkeysJa hotkeys = _TranslationsSettingsHotkeysJa._(_root);
	@override late final _TranslationsSettingsTranslationJa translation = _TranslationsSettingsTranslationJa._(_root);
	@override late final _TranslationsSettingsTargetLanguagesJa target_languages = _TranslationsSettingsTargetLanguagesJa._(_root);
}

// Path: dashboard
class _TranslationsDashboardJa implements TranslationsDashboardEn {
	_TranslationsDashboardJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDashboardSidebarJa sidebar = _TranslationsDashboardSidebarJa._(_root);
	@override late final _TranslationsDashboardHomeJa home = _TranslationsDashboardHomeJa._(_root);
	@override String get chars_unit => '文字';
	@override String get unlimited => '無制限';
}

// Path: history
class _TranslationsHistoryJa implements TranslationsHistoryEn {
	_TranslationsHistoryJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '作成履歴';
	@override String time_saved({required Object time}) => '合計 ${time} のタイピング時間を節約しました。';
	@override String get empty => '記録がありません\nFnキーを押して最初の音声文字起こしを開始してください';
	@override String get mode_translate => '外国語翻訳';
	@override String get mode_refine => '母国語リファイン';
	@override String get asr_label => '🎙️ 音声認識: ';
	@override String get llm_label => '✨ スマートリファイン: ';
	@override String seconds({required Object seconds}) => '${seconds} 秒';
	@override String minutes({required Object minutes}) => '${minutes} 分';
	@override late final _TranslationsHistoryPeriodJa period = _TranslationsHistoryPeriodJa._(_root);
	@override late final _TranslationsHistoryKpiJa kpi = _TranslationsHistoryKpiJa._(_root);
}

// Path: onboarding
class _TranslationsOnboardingJa implements TranslationsOnboardingEn {
	_TranslationsOnboardingJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get step1_title => '自然に話して、完璧に書く';
	@override String get step1_subtitle => 'Fn を長押しして録音開始\n離すと自動的に校正してアクティブウィンドウに貼り付け';
	@override String get step1_action => '次へ';
	@override String get step2_title => 'マイクを許可';
	@override String get step2_action => 'システム権限を許可';
	@override String get step3_title => 'アクセシビリティを有効化';
	@override String get step3_subtitle => 'シームレスな入力のため\nシステム環境設定で Audio Translate Input のアクセシビリティを有効にしてください';
	@override String get step3_action => 'システム権限を確認';
	@override String get step4_title => '実践練習';
	@override String get step4_subtitle => '準備完了！Fnを長押しして何か話してみてください\n新しい効率革命を体験しましょう';
	@override String get step4_action => '旅を始める';
	@override String get skip => 'ガイドをスキップ';
	@override String get mic_permission_subtitle => 'Audio Translate Input は音声を正確なテキストに変換するために\nマイクの許可が必要です';
	@override String get complete_trial => '体験を完了';
	@override String get hold_fn_hint => 'Fn キーを押しながら何か話してください...';
	@override String get listening => '聞いています...（自由にお話しください）';
	@override String get refining => '校正中...';
	@override String get trial_success => '体験成功！これが Audio Translate Input の魔法です。';
	@override String get click_to_simulate => '（このボックスをクリックしてキー押下をシミュレートできます）';
	@override String get accessibility_warning => 'アクセシビリティ権限が付与されていません。表示されるシステム設定ダイアログで Audio Translate Input を有効にしてください。';
}

// Path: vocab
class _TranslationsVocabJa implements TranslationsVocabEn {
	_TranslationsVocabJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'マイ辞書';
	@override String get subtitle => 'AIにあなたの好みの表現を教える';
	@override String get add_title => 'カスタム表現を追加';
	@override String get spoken_hint => 'あなたが言うこと（話し言葉）';
	@override String get written_hint => '書きたいこと（書き言葉）';
	@override String get add_btn => '追加';
	@override String get empty => 'カスタム表現はまだありません';
}

// Path: settings.ui_settings
class _TranslationsSettingsUiSettingsJa implements TranslationsSettingsUiSettingsEn {
	_TranslationsSettingsUiSettingsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'UI設定';
	@override late final _TranslationsSettingsUiSettingsAppLanguageJa app_language = _TranslationsSettingsUiSettingsAppLanguageJa._(_root);
	@override late final _TranslationsSettingsUiSettingsFontJa font = _TranslationsSettingsUiSettingsFontJa._(_root);
}

// Path: settings.system_settings
class _TranslationsSettingsSystemSettingsJa implements TranslationsSettingsSystemSettingsEn {
	_TranslationsSettingsSystemSettingsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'システム設定';
	@override late final _TranslationsSettingsSystemSettingsStartupJa startup = _TranslationsSettingsSystemSettingsStartupJa._(_root);
	@override late final _TranslationsSettingsSystemSettingsBackendJa backend = _TranslationsSettingsSystemSettingsBackendJa._(_root);
}

// Path: settings.hotkeys
class _TranslationsSettingsHotkeysJa implements TranslationsSettingsHotkeysEn {
	_TranslationsSettingsHotkeysJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'ホットキーとトリガー';
	@override late final _TranslationsSettingsHotkeysRefineJa refine = _TranslationsSettingsHotkeysRefineJa._(_root);
	@override late final _TranslationsSettingsHotkeysTranslateJa translate = _TranslationsSettingsHotkeysTranslateJa._(_root);
	@override String get click_to_set => 'クリックして設定';
	@override String get cancel => 'キャンセル';
	@override String record_title({required Object title}) => '${title}のホットキーを記録';
	@override String get record_desc => 'ご希望のキーの組み合わせを直接キーボードで押してください...';
}

// Path: settings.translation
class _TranslationsSettingsTranslationJa implements TranslationsSettingsTranslationEn {
	_TranslationsSettingsTranslationJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '翻訳エンジンの戦略';
	@override late final _TranslationsSettingsTranslationTargetLangJa target_lang = _TranslationsSettingsTranslationTargetLangJa._(_root);
}

// Path: settings.target_languages
class _TranslationsSettingsTargetLanguagesJa implements TranslationsSettingsTargetLanguagesEn {
	_TranslationsSettingsTargetLanguagesJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get en => '英語';
	@override String get ja => '日本語';
	@override String get ko => '韓国語';
	@override String get fr => 'フランス語';
	@override String get de => 'ドイツ語';
	@override String get ru => 'ロシア語';
	@override String get es => 'スペイン語';
	@override String get it => 'イタリア語';
	@override String get pt => 'ポルトガル語';
	@override String get nl => 'オランダ語';
	@override String get ar => 'アラビア語';
	@override String get tr => 'トルコ語';
	@override String get sv => 'スウェーデン語';
	@override String get hi => 'ヒンディー語';
	@override String get th => 'タイ語';
	@override String get vi => 'ベトナム語';
	@override String get id => 'インドネシア語';
	@override String get zh_Hans => '簡体字中国語';
	@override String get zh_Hant => '繁体字中国語';
}

// Path: dashboard.sidebar
class _TranslationsDashboardSidebarJa implements TranslationsDashboardSidebarEn {
	_TranslationsDashboardSidebarJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get home => 'ホーム';
	@override String get history => '履歴';
	@override String get settings => '設定';
}

// Path: dashboard.home
class _TranslationsDashboardHomeJa implements TranslationsDashboardHomeEn {
	_TranslationsDashboardHomeJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get greeting => 'こんにちは、クリエイター';
	@override String get subtitle => '今日のフォーカス、フローの準備ができました';
	@override late final _TranslationsDashboardHomeGuideJa guide = _TranslationsDashboardHomeGuideJa._(_root);
	@override late final _TranslationsDashboardHomeStatsJa stats = _TranslationsDashboardHomeStatsJa._(_root);
}

// Path: history.period
class _TranslationsHistoryPeriodJa implements TranslationsHistoryPeriodEn {
	_TranslationsHistoryPeriodJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get today => '今日';
	@override String get week => '今週';
	@override String get month => '今月';
	@override String get all => '累計';
}

// Path: history.kpi
class _TranslationsHistoryKpiJa implements TranslationsHistoryKpiEn {
	_TranslationsHistoryKpiJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get usage_time => '利用時間';
	@override String get chars => '生成文字数';
	@override String get time_saved => '節約時間';
	@override String get requests => 'リクエスト数';
	@override String get refine => 'リファイン回数';
	@override String get translate => '翻訳回数';
}

// Path: settings.ui_settings.app_language
class _TranslationsSettingsUiSettingsAppLanguageJa implements TranslationsSettingsUiSettingsAppLanguageEn {
	_TranslationsSettingsUiSettingsAppLanguageJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'アプリの言語';
	@override String get subtitle => 'アプリケーション全体の言語を変更する';
}

// Path: settings.ui_settings.font
class _TranslationsSettingsUiSettingsFontJa implements TranslationsSettingsUiSettingsFontEn {
	_TranslationsSettingsUiSettingsFontJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '表示フォント';
	@override String get subtitle => 'テキスト表示フォントをグローバルに変更します';
}

// Path: settings.system_settings.startup
class _TranslationsSettingsSystemSettingsStartupJa implements TranslationsSettingsSystemSettingsStartupEn {
	_TranslationsSettingsSystemSettingsStartupJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'スタートアップ起動';
	@override String get subtitle => 'ログイン後にバックグラウンドで自動実行され、常に待機します';
}

// Path: settings.system_settings.backend
class _TranslationsSettingsSystemSettingsBackendJa implements TranslationsSettingsSystemSettingsBackendEn {
	_TranslationsSettingsSystemSettingsBackendJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'バックエンドノード';
	@override String get subtitle => '米国超高速ノード（Groq）または国内準拠ノード（SiliconFlow）';
	@override String get us => '欧米地域 (US/Europe)';
	@override String get cn => '中国国内 (China)';
}

// Path: settings.hotkeys.refine
class _TranslationsSettingsHotkeysRefineJa implements TranslationsSettingsHotkeysRefineEn {
	_TranslationsSettingsHotkeysRefineJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'リファインモード（トグル）';
	@override String get subtitle => 'Fnキーを押し続けたくない場合は、グローバルトグルキーをバインドできます';
}

// Path: settings.hotkeys.translate
class _TranslationsSettingsHotkeysTranslateJa implements TranslationsSettingsHotkeysTranslateEn {
	_TranslationsSettingsHotkeysTranslateJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => '翻訳モード（トグル）';
	@override String get subtitle => '話すとすぐにターゲット言語に翻訳して出力されます';
}

// Path: settings.translation.target_lang
class _TranslationsSettingsTranslationTargetLangJa implements TranslationsSettingsTranslationTargetLangEn {
	_TranslationsSettingsTranslationTargetLangJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'ターゲット言語の選択';
	@override String get subtitle => '翻訳モードをトリガーした際のデフォルトの翻訳先言語';
}

// Path: dashboard.home.guide
class _TranslationsDashboardHomeGuideJa implements TranslationsDashboardHomeGuideEn {
	_TranslationsDashboardHomeGuideJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'クイックスタートガイド';
	@override late final _TranslationsDashboardHomeGuideVoiceInputJa voice_input = _TranslationsDashboardHomeGuideVoiceInputJa._(_root);
	@override late final _TranslationsDashboardHomeGuideRealtimeTranslateJa realtime_translate = _TranslationsDashboardHomeGuideRealtimeTranslateJa._(_root);
	@override late final _TranslationsDashboardHomeGuideSmartFormatJa smart_format = _TranslationsDashboardHomeGuideSmartFormatJa._(_root);
}

// Path: dashboard.home.stats
class _TranslationsDashboardHomeStatsJa implements TranslationsDashboardHomeStatsEn {
	_TranslationsDashboardHomeStatsJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get focus_performance => 'フォーカス実績';
	@override String hours({required Object hours}) => '${hours} 時間';
	@override List<String> get days => [
		'月',
		'火',
		'水',
		'木',
		'金',
		'土',
		'日',
	];
	@override String get goal_reached => '今日のインスピレーション';
	@override String processed_words({required Object words}) => '処理された単語数 ${words}';
}

// Path: dashboard.home.guide.voice_input
class _TranslationsDashboardHomeGuideVoiceInputJa implements TranslationsDashboardHomeGuideVoiceInputEn {
	_TranslationsDashboardHomeGuideVoiceInputJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'Fnで音声入力';
	@override String get desc => 'テキストボックスでFnを長押しして話し、離すと自動的にリファインされて貼り付けられます。';
}

// Path: dashboard.home.guide.realtime_translate
class _TranslationsDashboardHomeGuideRealtimeTranslateJa implements TranslationsDashboardHomeGuideRealtimeTranslateEn {
	_TranslationsDashboardHomeGuideRealtimeTranslateJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'Shift + Fnでリアルタイム翻訳';
	@override String get desc => 'ShiftとFnを長押しして翻訳します。';
}

// Path: dashboard.home.guide.smart_format
class _TranslationsDashboardHomeGuideSmartFormatJa implements TranslationsDashboardHomeGuideSmartFormatEn {
	_TranslationsDashboardHomeGuideSmartFormatJa._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'スマートフォーマットアシスタント';
	@override String get desc => 'システムは頻繁に使用するフレーズやライティングスタイルを自動的に記録します。';
}

/// The flat map containing all translations for locale <ja>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsJa {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'status.idle' => 'Fnを押して録音',
			'status.translating' => '🌐 翻訳中... (Fnを離して停止)',
			'status.listening' => '🎤 リスニング中... (Fnを離して停止)',
			'status.network_disconnected_title' => '🔴 ネットワーク未接続',
			'status.network_disconnected_desc' => 'ネットワーク接続をご確認ください',
			'status.network_disconnected_short' => 'ネットワークなし',
			'status.accessibility_permission' => '自動貼り付けにはアクセシビリティ権限が必要です。システム設定で許可してください',
			'status.mic_permission' => 'マイク未認証',
			'status.processing' => '✨ 処理中...',
			'status.paste_success' => '✅ 貼り付け成功',
			'status.paste_success_times' => ({required Object asrSec, required Object llmSec}) => '✅ [ASR: ${asrSec}s | LLM: ${llmSec}s]',
			'status.mode_recording' => '録音',
			'status.mode_translating' => '翻訳',
			'status.recording_failed' => '録音開始に失敗しました',
			'status.no_voice_detected' => '音声が検出されません',
			'status.processing_short' => '処理中',
			'common.min_sec' => ({required Object min, required Object sec}) => '${min}分 ${sec}秒',
			'common.hour_min' => ({required Object hour, required Object min}) => '${hour}時間 ${min}分',
			'common.n_minutes' => ({required Object n}) => '${n} 分',
			'common.n_hours' => ({required Object n, required Object min}) => '${n} 時間 ${min} 分',
			'locales.en' => '英語',
			'locales.zhHans' => '簡体字中国語',
			'locales.zhHant' => '繁体字中国語',
			'locales.ja' => '日本語',
			'locales.de' => 'ドイツ語',
			'locales.es' => 'スペイン語',
			'settings.title' => 'アプリ設定',
			'settings.subtitle' => '独自のタイピング体験をカスタマイズ。',
			'settings.ui_settings.title' => 'UI設定',
			'settings.ui_settings.app_language.title' => 'アプリの言語',
			'settings.ui_settings.app_language.subtitle' => 'アプリケーション全体の言語を変更する',
			'settings.ui_settings.font.title' => '表示フォント',
			'settings.ui_settings.font.subtitle' => 'テキスト表示フォントをグローバルに変更します',
			'settings.system_settings.title' => 'システム設定',
			'settings.system_settings.startup.title' => 'スタートアップ起動',
			'settings.system_settings.startup.subtitle' => 'ログイン後にバックグラウンドで自動実行され、常に待機します',
			'settings.system_settings.backend.title' => 'バックエンドノード',
			'settings.system_settings.backend.subtitle' => '米国超高速ノード（Groq）または国内準拠ノード（SiliconFlow）',
			'settings.system_settings.backend.us' => '欧米地域 (US/Europe)',
			'settings.system_settings.backend.cn' => '中国国内 (China)',
			'settings.hotkeys.title' => 'ホットキーとトリガー',
			'settings.hotkeys.refine.title' => 'リファインモード（トグル）',
			'settings.hotkeys.refine.subtitle' => 'Fnキーを押し続けたくない場合は、グローバルトグルキーをバインドできます',
			'settings.hotkeys.translate.title' => '翻訳モード（トグル）',
			'settings.hotkeys.translate.subtitle' => '話すとすぐにターゲット言語に翻訳して出力されます',
			'settings.hotkeys.click_to_set' => 'クリックして設定',
			'settings.hotkeys.cancel' => 'キャンセル',
			'settings.hotkeys.record_title' => ({required Object title}) => '${title}のホットキーを記録',
			'settings.hotkeys.record_desc' => 'ご希望のキーの組み合わせを直接キーボードで押してください...',
			'settings.translation.title' => '翻訳エンジンの戦略',
			'settings.translation.target_lang.title' => 'ターゲット言語の選択',
			'settings.translation.target_lang.subtitle' => '翻訳モードをトリガーした際のデフォルトの翻訳先言語',
			'settings.target_languages.en' => '英語',
			'settings.target_languages.ja' => '日本語',
			'settings.target_languages.ko' => '韓国語',
			'settings.target_languages.fr' => 'フランス語',
			'settings.target_languages.de' => 'ドイツ語',
			'settings.target_languages.ru' => 'ロシア語',
			'settings.target_languages.es' => 'スペイン語',
			'settings.target_languages.it' => 'イタリア語',
			'settings.target_languages.pt' => 'ポルトガル語',
			'settings.target_languages.nl' => 'オランダ語',
			'settings.target_languages.ar' => 'アラビア語',
			'settings.target_languages.tr' => 'トルコ語',
			'settings.target_languages.sv' => 'スウェーデン語',
			'settings.target_languages.hi' => 'ヒンディー語',
			'settings.target_languages.th' => 'タイ語',
			'settings.target_languages.vi' => 'ベトナム語',
			'settings.target_languages.id' => 'インドネシア語',
			'settings.target_languages.zh_Hans' => '簡体字中国語',
			'settings.target_languages.zh_Hant' => '繁体字中国語',
			'dashboard.sidebar.home' => 'ホーム',
			'dashboard.sidebar.history' => '履歴',
			'dashboard.sidebar.settings' => '設定',
			'dashboard.home.greeting' => 'こんにちは、クリエイター',
			'dashboard.home.subtitle' => '今日のフォーカス、フローの準備ができました',
			'dashboard.home.guide.title' => 'クイックスタートガイド',
			'dashboard.home.guide.voice_input.title' => 'Fnで音声入力',
			'dashboard.home.guide.voice_input.desc' => 'テキストボックスでFnを長押しして話し、離すと自動的にリファインされて貼り付けられます。',
			'dashboard.home.guide.realtime_translate.title' => 'Shift + Fnでリアルタイム翻訳',
			'dashboard.home.guide.realtime_translate.desc' => 'ShiftとFnを長押しして翻訳します。',
			'dashboard.home.guide.smart_format.title' => 'スマートフォーマットアシスタント',
			'dashboard.home.guide.smart_format.desc' => 'システムは頻繁に使用するフレーズやライティングスタイルを自動的に記録します。',
			'dashboard.home.stats.focus_performance' => 'フォーカス実績',
			'dashboard.home.stats.hours' => ({required Object hours}) => '${hours} 時間',
			'dashboard.home.stats.days.0' => '月',
			'dashboard.home.stats.days.1' => '火',
			'dashboard.home.stats.days.2' => '水',
			'dashboard.home.stats.days.3' => '木',
			'dashboard.home.stats.days.4' => '金',
			'dashboard.home.stats.days.5' => '土',
			'dashboard.home.stats.days.6' => '日',
			'dashboard.home.stats.goal_reached' => '今日のインスピレーション',
			'dashboard.home.stats.processed_words' => ({required Object words}) => '処理された単語数 ${words}',
			'dashboard.chars_unit' => '文字',
			'dashboard.unlimited' => '無制限',
			'history.title' => '作成履歴',
			'history.time_saved' => ({required Object time}) => '合計 ${time} のタイピング時間を節約しました。',
			'history.empty' => '記録がありません\nFnキーを押して最初の音声文字起こしを開始してください',
			'history.mode_translate' => '外国語翻訳',
			'history.mode_refine' => '母国語リファイン',
			'history.asr_label' => '🎙️ 音声認識: ',
			'history.llm_label' => '✨ スマートリファイン: ',
			'history.seconds' => ({required Object seconds}) => '${seconds} 秒',
			'history.minutes' => ({required Object minutes}) => '${minutes} 分',
			'history.period.today' => '今日',
			'history.period.week' => '今週',
			'history.period.month' => '今月',
			'history.period.all' => '累計',
			'history.kpi.usage_time' => '利用時間',
			'history.kpi.chars' => '生成文字数',
			'history.kpi.time_saved' => '節約時間',
			'history.kpi.requests' => 'リクエスト数',
			'history.kpi.refine' => 'リファイン回数',
			'history.kpi.translate' => '翻訳回数',
			'onboarding.step1_title' => '自然に話して、完璧に書く',
			'onboarding.step1_subtitle' => 'Fn を長押しして録音開始\n離すと自動的に校正してアクティブウィンドウに貼り付け',
			'onboarding.step1_action' => '次へ',
			'onboarding.step2_title' => 'マイクを許可',
			'onboarding.step2_action' => 'システム権限を許可',
			'onboarding.step3_title' => 'アクセシビリティを有効化',
			'onboarding.step3_subtitle' => 'シームレスな入力のため\nシステム環境設定で Audio Translate Input のアクセシビリティを有効にしてください',
			'onboarding.step3_action' => 'システム権限を確認',
			'onboarding.step4_title' => '実践練習',
			'onboarding.step4_subtitle' => '準備完了！Fnを長押しして何か話してみてください\n新しい効率革命を体験しましょう',
			'onboarding.step4_action' => '旅を始める',
			'onboarding.skip' => 'ガイドをスキップ',
			'onboarding.mic_permission_subtitle' => 'Audio Translate Input は音声を正確なテキストに変換するために\nマイクの許可が必要です',
			'onboarding.complete_trial' => '体験を完了',
			'onboarding.hold_fn_hint' => 'Fn キーを押しながら何か話してください...',
			'onboarding.listening' => '聞いています...（自由にお話しください）',
			'onboarding.refining' => '校正中...',
			'onboarding.trial_success' => '体験成功！これが Audio Translate Input の魔法です。',
			'onboarding.click_to_simulate' => '（このボックスをクリックしてキー押下をシミュレートできます）',
			'onboarding.accessibility_warning' => 'アクセシビリティ権限が付与されていません。表示されるシステム設定ダイアログで Audio Translate Input を有効にしてください。',
			'vocab.title' => 'マイ辞書',
			'vocab.subtitle' => 'AIにあなたの好みの表現を教える',
			'vocab.add_title' => 'カスタム表現を追加',
			'vocab.spoken_hint' => 'あなたが言うこと（話し言葉）',
			'vocab.written_hint' => '書きたいこと（書き言葉）',
			'vocab.add_btn' => '追加',
			'vocab.empty' => 'カスタム表現はまだありません',
			_ => null,
		};
	}
}
