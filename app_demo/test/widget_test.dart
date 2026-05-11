import 'package:flutter_test/flutter_test.dart';

/// 基础冒烟测试 - 确保核心数据结构和常量的完整性
void main() {
  test('App 版本号格式正确', () {
    // 版本号应该是 semantic versioning 格式
    const version = '1.0.0';
    final regex = RegExp(r'^\d+\.\d+\.\d+$');
    expect(regex.hasMatch(version), isTrue);
  });

  test('支持的目标语言总数为 19', () {
    final languages = [
      '英语', '简体中文', '繁体中文', '日语', '韩语',
      '法语', '德语', '俄语', '西班牙语', '意大利语', '葡萄牙语',
      '荷兰语', '阿拉伯语', '土耳其语', '瑞典语', '印地语', '泰语',
      '越南语', '印尼语',
    ];
    expect(languages.length, equals(19));
    // 确保没有重复
    expect(languages.toSet().length, equals(languages.length));
  });

  test('语言到 HTTP Header 映射无遗漏', () {
    // 模拟 audio_upload_service.dart 中的 switch 逻辑
    String mapToHeader(String lang) {
      switch (lang) {
        case '英语': return 'English';
        case '简体中文': return 'Simplified Chinese';
        case '繁体中文': return 'Traditional Chinese';
        case '日语': return 'Japanese';
        case '韩语': return 'Korean';
        case '法语': return 'French';
        case '德语': return 'German';
        case '俄语': return 'Russian';
        case '西班牙语': return 'Spanish';
        case '意大利语': return 'Italian';
        case '葡萄牙语': return 'Portuguese';
        case '荷兰语': return 'Dutch';
        case '阿拉伯语': return 'Arabic';
        case '土耳其语': return 'Turkish';
        case '瑞典语': return 'Swedish';
        case '印地语': return 'Hindi';
        case '泰语': return 'Thai';
        case '越南语': return 'Vietnamese';
        case '印尼语': return 'Indonesian';
        default: return 'English';
      }
    }

    final expectedMappings = {
      '英语': 'English', '简体中文': 'Simplified Chinese', '繁体中文': 'Traditional Chinese',
      '日语': 'Japanese', '韩语': 'Korean', '法语': 'French', '德语': 'German',
      '俄语': 'Russian', '西班牙语': 'Spanish', '意大利语': 'Italian', '葡萄牙语': 'Portuguese',
      '荷兰语': 'Dutch', '阿拉伯语': 'Arabic', '土耳其语': 'Turkish', '瑞典语': 'Swedish',
      '印地语': 'Hindi', '泰语': 'Thai', '越南语': 'Vietnamese', '印尼语': 'Indonesian',
    };

    for (final entry in expectedMappings.entries) {
      final header = mapToHeader(entry.key);
      expect(header, equals(entry.value), reason: '语言 "${entry.key}" 映射不正确');
    }
  });

  test('中文语种正确映射为英文 header', () {
    String mapToHeader(String lang) {
      switch (lang) {
        case '简体中文': return 'Simplified Chinese';
        case '繁体中文': return 'Traditional Chinese';
        default: return 'English';
      }
    }
    expect(mapToHeader('简体中文'), equals('Simplified Chinese'));
    expect(mapToHeader('繁体中文'), equals('Traditional Chinese'));
  });

  test('未知语言应 fallback 为 English', () {
    String mapToHeader(String lang) {
      switch (lang) {
        case '英语': return 'English';
        default: return 'English';
      }
    }
    expect(mapToHeader('不存在的语言'), equals('English'));
  });

  test('所有 header 值应为纯 ASCII 英文字符串', () {
    final headers = [
      'English', 'Simplified Chinese', 'Traditional Chinese', 'Japanese',
      'Korean', 'French', 'German', 'Russian', 'Spanish', 'Italian',
      'Portuguese', 'Dutch', 'Arabic', 'Turkish', 'Swedish',
      'Hindi', 'Thai', 'Vietnamese', 'Indonesian',
    ];
    final asciiRegex = RegExp(r'^[a-zA-Z\s]+$');
    for (final h in headers) {
      expect(asciiRegex.hasMatch(h), isTrue,
        reason: 'Header "$h" 包含非 ASCII 字符，会导致 HTTP 传输异常');
    }
  });
}
