import 'package:flutter_test/flutter_test.dart';
import 'package:app_demo/usage_stats_service.dart';

/// 计时/计费模块 —— UsageStats 数据模型单元测试
void main() {
  // ==================== UsageStats 默认值 ====================
  group('UsageStats 默认构造', () {
    test('所有字段默认为 0', () {
      final stats = UsageStats();
      expect(stats.totalRequests, equals(0));
      expect(stats.totalRecordingMs, equals(0));
      expect(stats.totalOriginalChars, equals(0));
      expect(stats.totalRefinedChars, equals(0));
      expect(stats.totalTimeSaved, equals(0));
      expect(stats.translateCount, equals(0));
      expect(stats.refineCount, equals(0));
      expect(stats.totalAsrMs, equals(0));
      expect(stats.totalLlmMs, equals(0));
    });

    test('默认录音时长为 0 分钟', () {
      final stats = UsageStats();
      expect(stats.totalRecordingMinutes, equals(0.0));
    });

    test('默认节省时间为 0 分钟', () {
      final stats = UsageStats();
      expect(stats.totalTimeSavedMinutes, equals(0.0));
    });
  });

  // ==================== UsageStats.fromRows 单行解析 ====================
  group('UsageStats.fromRows 单行数据', () {
    test('正确解析单行完整数据', () {
      final rows = [
        {
          'total_requests': 5,
          'total_recording_ms': 60000,
          'total_original_chars': 200,
          'total_refined_chars': 180,
          'total_time_saved': 120,
          'total_asr_ms': 3000,
          'total_llm_ms': 5000,
          'translate_count': 2,
          'refine_count': 3,
        }
      ];
      final stats = UsageStats.fromRows(rows);
      expect(stats.totalRequests, equals(5));
      expect(stats.totalRecordingMs, equals(60000));
      expect(stats.totalOriginalChars, equals(200));
      expect(stats.totalRefinedChars, equals(180));
      expect(stats.totalTimeSaved, equals(120));
      expect(stats.totalAsrMs, equals(3000));
      expect(stats.totalLlmMs, equals(5000));
      expect(stats.translateCount, equals(2));
      expect(stats.refineCount, equals(3));
    });

    test('兼容 total_translate / total_refine 备用 key', () {
      final rows = [
        {
          'total_requests': 10,
          'total_recording_ms': 0,
          'total_original_chars': 0,
          'total_refined_chars': 0,
          'total_time_saved': 0,
          'total_asr_ms': 0,
          'total_llm_ms': 0,
          'total_translate': 7,
          'total_refine': 3,
        }
      ];
      final stats = UsageStats.fromRows(rows);
      expect(stats.translateCount, equals(7));
      expect(stats.refineCount, equals(3));
    });
  });

  // ==================== UsageStats.fromRows 多行聚合 ====================
  group('UsageStats.fromRows 多行聚合', () {
    test('多行数据正确累加', () {
      final rows = [
        {
          'total_requests': 3,
          'total_recording_ms': 30000,
          'total_original_chars': 100,
          'total_refined_chars': 90,
          'total_time_saved': 60,
          'total_asr_ms': 1000,
          'total_llm_ms': 2000,
          'translate_count': 1,
          'refine_count': 2,
        },
        {
          'total_requests': 7,
          'total_recording_ms': 70000,
          'total_original_chars': 300,
          'total_refined_chars': 250,
          'total_time_saved': 180,
          'total_asr_ms': 4000,
          'total_llm_ms': 6000,
          'translate_count': 4,
          'refine_count': 3,
        },
      ];
      final stats = UsageStats.fromRows(rows);
      expect(stats.totalRequests, equals(10));
      expect(stats.totalRecordingMs, equals(100000));
      expect(stats.totalOriginalChars, equals(400));
      expect(stats.totalRefinedChars, equals(340));
      expect(stats.totalTimeSaved, equals(240));
      expect(stats.totalAsrMs, equals(5000));
      expect(stats.totalLlmMs, equals(8000));
      expect(stats.translateCount, equals(5));
      expect(stats.refineCount, equals(5));
    });

    test('空数据列表返回全 0', () {
      final stats = UsageStats.fromRows([]);
      expect(stats.totalRequests, equals(0));
      expect(stats.totalRecordingMs, equals(0));
    });
  });

  // ==================== null 字段容错 ====================
  group('null 字段容错', () {
    test('字段为 null 时默认为 0', () {
      final rows = [
        {
          'total_requests': null,
          'total_recording_ms': null,
          'total_original_chars': 100,
          'total_refined_chars': null,
          'total_time_saved': null,
          'total_asr_ms': null,
          'total_llm_ms': null,
          'translate_count': null,
          'refine_count': null,
        }
      ];
      final stats = UsageStats.fromRows(rows);
      expect(stats.totalRequests, equals(0));
      expect(stats.totalRecordingMs, equals(0));
      expect(stats.totalOriginalChars, equals(100));
      expect(stats.totalRefinedChars, equals(0));
    });

    test('字段完全缺失时默认为 0', () {
      final rows = [<String, dynamic>{}];
      final stats = UsageStats.fromRows(rows);
      expect(stats.totalRequests, equals(0));
      expect(stats.totalRecordingMs, equals(0));
    });
  });

  // ==================== 时间换算 ====================
  group('时间换算精度', () {
    test('60000ms = 1.0 分钟', () {
      final stats = UsageStats(totalRecordingMs: 60000);
      expect(stats.totalRecordingMinutes, closeTo(1.0, 0.001));
    });

    test('90000ms = 1.5 分钟', () {
      final stats = UsageStats(totalRecordingMs: 90000);
      expect(stats.totalRecordingMinutes, closeTo(1.5, 0.001));
    });

    test('120 秒节省 = 2.0 分钟', () {
      final stats = UsageStats(totalTimeSaved: 120);
      expect(stats.totalTimeSavedMinutes, closeTo(2.0, 0.001));
    });

    test('90 秒节省 = 1.5 分钟', () {
      final stats = UsageStats(totalTimeSaved: 90);
      expect(stats.totalTimeSavedMinutes, closeTo(1.5, 0.001));
    });
  });

  // ==================== DailyUsage ====================
  group('DailyUsage 数据模型', () {
    test('正确构造和读取字段', () {
      final du = DailyUsage(
        date: DateTime(2026, 3, 16),
        recordingMs: 120000,
        refinedChars: 500,
      );
      expect(du.date.year, equals(2026));
      expect(du.date.month, equals(3));
      expect(du.date.day, equals(16));
      expect(du.recordingMs, equals(120000));
      expect(du.refinedChars, equals(500));
    });
  });
}
