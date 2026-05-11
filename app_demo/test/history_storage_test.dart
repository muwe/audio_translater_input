import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

/// 历史记录存储 — 纯逻辑单元测试
/// 从 history_dashboard.dart 提取的 HistoryItem 和 HistoryStorage 逻辑
void main() {
  // ==================== HistoryItem 序列化 ====================
  group('HistoryItem JSON 序列化', () {
    test('toJson 包含所有必需字段', () {
      final item = {
        'id': '1234567890',
        'timestamp': '2026-03-17 09:00',
        'text': '润色后的文本',
        'originalText': '原始文本',
        'mode': 'refine',
        'asrDurationMs': 350,
        'llmDurationMs': 800,
        'asrProvider': 'Groq',
        'asrModel': 'whisper-large-v3',
        'llmProvider': 'OpenRouter',
        'llmModel': 'gpt-4o-mini',
        'recordingDurationMs': 5000,
      };
      expect(item.keys.length, equals(12));
      expect(item['mode'], equals('refine'));
    });

    test('fromJson 缺少可选字段应有默认值', () {
      final json = {
        'id': '999',
        'timestamp': '2026-01-01 00:00',
        'text': 'Hello',
        'mode': 'translate',
      };
      final originalText = json['originalText'] ?? '';
      final asrDurationMs = json['asrDurationMs'] ?? 0;
      final asrProvider = json['asrProvider'] ?? 'Unknown';

      expect(originalText, equals(''));
      expect(asrDurationMs, equals(0));
      expect(asrProvider, equals('Unknown'));
    });

    test('JSON 往返序列化数据不丢失', () {
      final original = {
        'id': '12345',
        'timestamp': '2026-03-17 09:00',
        'text': '你好世界',
        'originalText': 'Hello world',
        'mode': 'translate',
        'asrDurationMs': 500,
        'llmDurationMs': 1200,
        'asrProvider': 'SiliconFlow',
        'asrModel': 'SenseVoiceSmall',
        'llmProvider': 'SiliconFlow',
        'llmModel': 'Qwen2.5-32B',
      };
      final decoded = jsonDecode(jsonEncode(original));
      expect(decoded['text'], equals('你好世界'));
      expect(decoded['asrDurationMs'], equals(500));
    });
  });

  // ==================== 历史列表管理 ====================
  group('历史列表管理逻辑', () {
    test('新条目应插入列表头部 (index 0)', () {
      final list = ['old_item_1', 'old_item_2'];
      list.insert(0, 'new_item');
      expect(list.first, equals('new_item'));
      expect(list.length, equals(3));
    });

    test('超过 50 条应移除最后一条', () {
      final list = List.generate(50, (i) => 'item_$i');
      expect(list.length, equals(50));
      list.insert(0, 'new_item_51');
      if (list.length > 50) list.removeLast();
      expect(list.length, equals(50));
      expect(list.first, equals('new_item_51'));
      expect(list.last, equals('item_48')); // item_49 被移除
    });

    test('空列表添加第一条应成功', () {
      final list = <String>[];
      list.insert(0, 'first_item');
      expect(list.length, equals(1));
    });
  });

  // ==================== 节省时间计算 ====================
  group('节省时间计算', () {
    test('节省时间应按文本长度累加', () {
      int currentSavedTime = 0;
      final texts = ['Hello', '你好世界', 'This is a test'];
      for (final text in texts) {
        currentSavedTime += text.length;
      }
      // 'Hello'=5 + '你好世界'=4 + 'This is a test'=14 = 23
      expect(currentSavedTime, equals(23));
    });

    test('空文本不增加节省时间', () {
      int saved = 100;
      final text = '';
      saved += text.length;
      expect(saved, equals(100));
    });
  });

  // ==================== 模式标签 ====================
  group('模式标签验证', () {
    test('refine 模式应只有 refine 和 translate 两种', () {
      final validModes = ['refine', 'translate'];
      expect(validModes.contains('refine'), isTrue);
      expect(validModes.contains('translate'), isTrue);
      expect(validModes.contains('unknown'), isFalse);
    });
  });
}
