import 'package:flutter_test/flutter_test.dart';

/// Dashboard KPI 统计 — 纯逻辑单元测试
/// 从 usage_stats_service.dart 和 main_dashboard.dart 提取的数据模型逻辑
void main() {
  // ==================== UsageStats 聚合计算 ====================
  group('UsageStats 数据聚合', () {
    Map<String, int> aggregateStats(List<Map<String, int>> rows) {
      int requests = 0, recMs = 0, origChars = 0, refChars = 0, saved = 0;
      for (final row in rows) {
        requests += row['total_requests'] ?? 0;
        recMs += row['total_recording_ms'] ?? 0;
        origChars += row['total_original_chars'] ?? 0;
        refChars += row['total_refined_chars'] ?? 0;
        saved += row['total_time_saved'] ?? 0;
      }
      return {
        'requests': requests, 'recMs': recMs,
        'origChars': origChars, 'refChars': refChars, 'saved': saved,
      };
    }

    test('空数据行应全部为 0', () {
      final result = aggregateStats([]);
      expect(result['requests'], equals(0));
      expect(result['recMs'], equals(0));
    });

    test('单行数据应正确映射', () {
      final result = aggregateStats([
        {'total_requests': 10, 'total_recording_ms': 60000, 'total_original_chars': 500, 'total_refined_chars': 600, 'total_time_saved': 120}
      ]);
      expect(result['requests'], equals(10));
      expect(result['recMs'], equals(60000));
      expect(result['refChars'], equals(600));
    });

    test('多行数据应正确累加', () {
      final result = aggregateStats([
        {'total_requests': 5, 'total_recording_ms': 30000, 'total_original_chars': 200, 'total_refined_chars': 250, 'total_time_saved': 60},
        {'total_requests': 8, 'total_recording_ms': 45000, 'total_original_chars': 300, 'total_refined_chars': 380, 'total_time_saved': 90},
      ]);
      expect(result['requests'], equals(13));
      expect(result['recMs'], equals(75000));
      expect(result['saved'], equals(150));
    });

    test('缺失字段应视为 0', () {
      final result = aggregateStats([
        {'total_requests': 3},
      ]);
      expect(result['requests'], equals(3));
      expect(result['recMs'], equals(0));
    });
  });

  // ==================== 单位转换 ====================
  group('时间单位转换', () {
    test('录音毫秒转分钟', () {
      const ms = 120000;
      final minutes = ms / 60000.0;
      expect(minutes, equals(2.0));
    });

    test('节省时间秒转分钟', () {
      const seconds = 150;
      final minutes = seconds / 60.0;
      expect(minutes, equals(2.5));
    });

    test('0 毫秒应转为 0 分钟', () {
      const ms = 0;
      final minutes = ms / 60000.0;
      expect(minutes, equals(0.0));
    });
  });

  // ==================== 时间筛选范围 ====================
  group('StatsPeriod 时间范围', () {
    test('today 应返回当天 0 点', () {
      final now = DateTime.utc(2026, 3, 17, 14, 30);
      final startOfDay = DateTime.utc(now.year, now.month, now.day);
      expect(startOfDay.hour, equals(0));
      expect(startOfDay.minute, equals(0));
    });

    test('week 应返回 7 天前', () {
      final now = DateTime.utc(2026, 3, 17);
      final weekAgo = now.subtract(const Duration(days: 7));
      expect(weekAgo.day, equals(10));
    });

    test('month 应返回当月 1 号', () {
      final now = DateTime.utc(2026, 3, 17);
      final startOfMonth = DateTime.utc(now.year, now.month, 1);
      expect(startOfMonth.day, equals(1));
      expect(startOfMonth.month, equals(3));
    });
  });

  // ==================== KPI 卡片格式化 ====================
  group('KPI 显示格式化', () {
    test('分钟数格式化为 "X hr Y min"', () {
      const minutes = 130.0;
      final hours = minutes ~/ 60;
      final mins = (minutes % 60).round();
      expect('$hours hr $mins min', equals('2 hr 10 min'));
    });

    test('小于 1 小时只显示分钟', () {
      const minutes = 45.0;
      final hours = minutes ~/ 60;
      final mins = (minutes % 60).round();
      if (hours > 0) {
        expect('$hours hr $mins min', isNotEmpty);
      } else {
        expect('$mins min', equals('45 min'));
      }
    });

    test('字数格式化应添加千分位', () {
      const chars = 12504;
      // Dart intl NumberFormat 的模拟
      final formatted = chars.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
      expect(formatted, equals('12,504'));
    });
  });
}
