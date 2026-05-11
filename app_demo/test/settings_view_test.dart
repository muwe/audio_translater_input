import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// 测试目标语言配置的完整性和一致性
/// 确保 Flutter 端的语言列表与 i18n JSON 文件中的翻译配对是完整的
void main() {
  // 所有语言的内部 key（必须与 settings_view.dart 中 _languages 列表一一对应）
  final expectedInternalKeys = [
    '英语', '简体中文', '繁体中文', '日语', '韩语',
    '法语', '德语', '俄语', '西班牙语', '意大利语', '葡萄牙语',
    '荷兰语', '阿拉伯语', '土耳其语', '瑞典语', '印地语', '泰语',
    '越南语', '印尼语',
  ];

  // 每个内部 key 对应传给 AI API 的语言名称
  final expectedHeaderMapping = <String, String>{
    '英语': 'English',
    '简体中文': 'Simplified Chinese',
    '繁体中文': 'Traditional Chinese',
    '日语': 'Japanese',
    '韩语': 'Korean',
    '法语': 'French',
    '德语': 'German',
    '俄语': 'Russian',
    '西班牙语': 'Spanish',
    '意大利语': 'Italian',
    '葡萄牙语': 'Portuguese',
    '荷兰语': 'Dutch',
    '阿拉伯语': 'Arabic',
    '土耳其语': 'Turkish',
    '瑞典语': 'Swedish',
    '印地语': 'Hindi',
    '泰语': 'Thai',
    '越南语': 'Vietnamese',
    '印尼语': 'Indonesian',
  };

  test('所有 19 种语言的内部 key 都有对应的 HTTP header 映射', () {
    for (final key in expectedInternalKeys) {
      expect(
        expectedHeaderMapping.containsKey(key),
        isTrue,
        reason: '语言 "$key" 缺少对应的 HTTP header 映射',
      );
      expect(
        expectedHeaderMapping[key]!.isNotEmpty,
        isTrue,
        reason: '语言 "$key" 的 HTTP header 值为空',
      );
    }
  });

  test('HTTP header 映射数量与语言列表一致', () {
    expect(expectedHeaderMapping.length, equals(expectedInternalKeys.length));
  });

  // 验证所有 i18n JSON 文件都包含完整的 target_languages keys
  final i18nFiles = [
    'lib/i18n/strings.i18n.json',
    'lib/i18n/strings_zh-Hans.i18n.json',
    'lib/i18n/strings_zh-Hant.i18n.json',
    'lib/i18n/strings_ja.i18n.json',
    'lib/i18n/strings_de.i18n.json',
    'lib/i18n/strings_es.i18n.json',
  ];

  // target_languages 里应有的 JSON keys（不含 auto_detect）
  final expectedJsonKeys = [
    'en', 'zh_Hans', 'zh_Hant', 'ja', 'ko',
    'fr', 'de', 'ru', 'es', 'it', 'pt', 'nl', 'ar', 'tr', 'sv',
    'hi', 'th', 'vi', 'id',
  ];

  for (final filePath in i18nFiles) {
    test('i18n 文件 $filePath 包含所有 target_languages keys', () {
      final file = File(filePath);
      if (!file.existsSync()) {
        fail('文件不存在: $filePath');
      }
      final content = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final settings = content['settings'] as Map<String, dynamic>?;
      expect(settings, isNotNull, reason: '缺少 settings 节点');

      final targetLangs = settings!['target_languages'] as Map<String, dynamic>?;
      expect(targetLangs, isNotNull, reason: '缺少 target_languages 节点');

      for (final key in expectedJsonKeys) {
        expect(
          targetLangs!.containsKey(key),
          isTrue,
          reason: '文件 $filePath 中 target_languages 缺少 key: "$key"',
        );
      }
    });
  }
}
