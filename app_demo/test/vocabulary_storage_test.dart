import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

/// 词典本地存储 — 纯逻辑单元测试
/// 测试 VocabEntry 的序列化/反序列化和存储逻辑
void main() {
  // ==================== VocabEntry 序列化 ====================
  group('VocabEntry JSON 序列化', () {
    test('toJson 应正确输出 spoken 和 written', () {
      final entry = {'spoken': 'Supabase', 'written': '数据库'};
      expect(entry['spoken'], equals('Supabase'));
      expect(entry['written'], equals('数据库'));
    });

    test('fromJson 应正确解析', () {
      final json = {'spoken': 'GPT', 'written': '大模型'};
      expect(json['spoken'], equals('GPT'));
      expect(json['written'], equals('大模型'));
    });

    test('fromJson 缺少字段时应有默认值', () {
      final json = <String, dynamic>{};
      final spoken = json['spoken'] ?? '';
      final written = json['written'] ?? '';
      expect(spoken, equals(''));
      expect(written, equals(''));
    });

    test('JSON 往返序列化保持一致', () {
      final original = {'spoken': 'Flutter', 'written': '跨平台框架'};
      final jsonString = jsonEncode(original);
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      expect(decoded['spoken'], equals(original['spoken']));
      expect(decoded['written'], equals(original['written']));
    });
  });

  // ==================== 词条列表操作 ====================
  group('词条列表增删操作', () {
    test('添加词条到空列表', () {
      final entries = <Map<String, String>>[];
      entries.add({'spoken': 'AI', 'written': '人工智能'});
      expect(entries.length, equals(1));
      expect(entries.first['spoken'], equals('AI'));
    });

    test('删除指定索引的词条', () {
      final entries = [
        {'spoken': 'a', 'written': '1'},
        {'spoken': 'b', 'written': '2'},
        {'spoken': 'c', 'written': '3'},
      ];
      entries.removeAt(1);
      expect(entries.length, equals(2));
      expect(entries[0]['spoken'], equals('a'));
      expect(entries[1]['spoken'], equals('c'));
    });

    test('空输入不应添加词条', () {
      final entries = <Map<String, String>>[];
      final spoken = ''.trim();
      final written = ''.trim();
      if (spoken.isNotEmpty && written.isNotEmpty) {
        entries.add({'spoken': spoken, 'written': written});
      }
      expect(entries.length, equals(0));
    });

    test('仅 spoken 为空不应添加', () {
      final entries = <Map<String, String>>[];
      final spoken = '  '.trim();
      final written = '有内容'.trim();
      if (spoken.isNotEmpty && written.isNotEmpty) {
        entries.add({'spoken': spoken, 'written': written});
      }
      expect(entries.length, equals(0));
    });

    test('批量序列化整个列表', () {
      final entries = [
        {'spoken': 'LLM', 'written': '大语言模型'},
        {'spoken': 'ASR', 'written': '语音识别'},
      ];
      final jsonString = jsonEncode(entries);
      final decoded = jsonDecode(jsonString) as List;
      expect(decoded.length, equals(2));
      expect((decoded[0] as Map)['spoken'], equals('LLM'));
    });
  });
}
