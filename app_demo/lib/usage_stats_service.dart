import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 全局单例：用于通知统计数据需要刷新
class UsageUpdateNotifier extends ChangeNotifier {
  void notifyUpdate() {
    notifyListeners();
  }
}
final usageUpdateNotifier = UsageUpdateNotifier();


/// 使用统计数据模型
class UsageStats {
  final int totalRequests;
  final int totalRecordingMs;     // 真实使用时长 (ms)
  final int totalOriginalChars;   // ASR 原识别字数
  final int totalRefinedChars;    // LLM 输出字数
  final int totalTimeSaved;       // 节省时间 (seconds)
  final int translateCount;
  final int refineCount;
  final int totalAsrMs;
  final int totalLlmMs;

  UsageStats({
    this.totalRequests = 0,
    this.totalRecordingMs = 0,
    this.totalOriginalChars = 0,
    this.totalRefinedChars = 0,
    this.totalTimeSaved = 0,
    this.translateCount = 0,
    this.refineCount = 0,
    this.totalAsrMs = 0,
    this.totalLlmMs = 0,
  });

  /// 真实使用时长（分钟）
  double get totalRecordingMinutes => totalRecordingMs / 60000.0;

  /// 节省时间（分钟）
  double get totalTimeSavedMinutes => totalTimeSaved / 60.0;

  /// 从多行日维度数据合并
  factory UsageStats.fromRows(List<Map<String, dynamic>> rows) {
    int requests = 0, recMs = 0, origChars = 0, refChars = 0;
    int saved = 0, translate = 0, refine = 0, asrMs = 0, llmMs = 0;

    for (final row in rows) {
      requests += (row['total_requests'] as int?) ?? 0;
      recMs += (row['total_recording_ms'] as int?) ?? 0;
      origChars += (row['total_original_chars'] as int?) ?? 0;
      refChars += (row['total_refined_chars'] as int?) ?? 0;
      saved += (row['total_time_saved'] as int?) ?? 0;
      translate += (row['total_translate'] as int?) ?? (row['translate_count'] as int?) ?? 0;
      refine += (row['total_refine'] as int?) ?? (row['refine_count'] as int?) ?? 0;
      asrMs += (row['total_asr_ms'] as int?) ?? 0;
      llmMs += (row['total_llm_ms'] as int?) ?? 0;
    }

    return UsageStats(
      totalRequests: requests,
      totalRecordingMs: recMs,
      totalOriginalChars: origChars,
      totalRefinedChars: refChars,
      totalTimeSaved: saved,
      translateCount: translate,
      refineCount: refine,
      totalAsrMs: asrMs,
      totalLlmMs: llmMs,
    );
  }
}

/// 时间维度枚举
enum StatsPeriod { today, week, month, allTime }

/// 日维度使用数据
class DailyUsage {
  final DateTime date;
  final int recordingMs;
  final int refinedChars;
  final int totalRequests;
  final int totalOriginalChars;
  final int totalTimeSaved;
  final int translateCount;
  final int refineCount;
  final int totalAsrMs;
  final int totalLlmMs;

  DailyUsage({
    required this.date,
    required this.recordingMs,
    required this.refinedChars,
    this.totalRequests = 0,
    this.totalOriginalChars = 0,
    this.totalTimeSaved = 0,
    this.translateCount = 0,
    this.refineCount = 0,
    this.totalAsrMs = 0,
    this.totalLlmMs = 0,
  });

  /// 转为 UsageStats.fromRows 可接受的 Map 格式
  Map<String, dynamic> toStatsMap() => {
    'total_requests': totalRequests,
    'total_recording_ms': recordingMs,
    'total_original_chars': totalOriginalChars,
    'total_refined_chars': refinedChars,
    'total_time_saved': totalTimeSaved,
    'total_translate': translateCount,
    'total_refine': refineCount,
    'total_asr_ms': totalAsrMs,
    'total_llm_ms': totalLlmMs,
  };
}

// ── 本地计算工具函数 ──────────────────────────────────────────

/// 估算打字节省时间（秒），与 Edge Function 逻辑保持一致
int _estimateTypingSeconds(String text) {
  double total = 0;
  for (final code in text.runes) {
    if ((code >= 0x4E00 && code <= 0x9FFF) || (code >= 0x3400 && code <= 0x4DBF) ||
        (code >= 0xF900 && code <= 0xFAFF) || (code >= 0x20000 && code <= 0x2A6DF)) {
      total += 0.8;
    } else if ((code >= 0x3040 && code <= 0x309F) || (code >= 0x30A0 && code <= 0x30FF)) {
      total += 1.2;
    } else if (code >= 0xAC00 && code <= 0xD7AF) {
      total += 0.5;
    } else if ((code >= 0x0041 && code <= 0x005A) || (code >= 0x0061 && code <= 0x007A) ||
               (code >= 0x00C0 && code <= 0x024F)) {
      total += 0.3;
    }
  }
  return total.round();
}

/// 使用统计服务 —— 从本地 History 计算，无需服务端
class UsageStatsService {
  static const String _historyKey = 'user_history_list';

  static List<DailyUsage> _cachedDailyData = [];

  /// 每次调用都从 SharedPreferences 重新读取（本地读取无网络延迟，成本极低）
  static Future<void> loadAllData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyStrings = prefs.getStringList(_historyKey) ?? [];

      // 解析 JSON，按日期分组
      final Map<String, _DayAccumulator> byDate = {};

      for (final jsonStr in historyStrings) {
        try {
          final item = jsonDecode(jsonStr) as Map<String, dynamic>;
          final timestamp = item['timestamp'] as String? ?? '';
          // timestamp 格式：'yyyy-MM-dd HH:mm'
          final dateKey = timestamp.length >= 10 ? timestamp.substring(0, 10) : '';
          if (dateKey.isEmpty) continue;

          final acc = byDate.putIfAbsent(dateKey, () => _DayAccumulator(dateKey));
          acc.add(item);
        } catch (_) {}
      }

      _cachedDailyData = byDate.values.map((a) => a.toDailyUsage()).toList()
        ..sort((a, b) => a.date.compareTo(b.date));

      debugPrint('📊 [Stats] 从本地 History 加载: ${historyStrings.length} 条 → ${_cachedDailyData.length} 天');
    } catch (e) {
      debugPrint('📊 [Stats] 加载失败: $e');
    }
  }

  static void clearCache() {
    _cachedDailyData = [];
  }

  /// 根据时间维度过滤，纯内存计算
  static UsageStats getStats(StatsPeriod period) {
    if (_cachedDailyData.isEmpty) return UsageStats();

    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);

    List<DailyUsage> filtered;
    switch (period) {
      case StatsPeriod.today:
        filtered = _cachedDailyData.where((d) =>
          d.date.year == todayDate.year &&
          d.date.month == todayDate.month &&
          d.date.day == todayDate.day
        ).toList();
        break;
      case StatsPeriod.week:
        final weekAgo = todayDate.subtract(const Duration(days: 7));
        filtered = _cachedDailyData.where((d) => !d.date.isBefore(weekAgo)).toList();
        break;
      case StatsPeriod.month:
        final monthStart = DateTime(now.year, now.month, 1);
        filtered = _cachedDailyData.where((d) => !d.date.isBefore(monthStart)).toList();
        break;
      case StatsPeriod.allTime:
        filtered = _cachedDailyData;
        break;
    }

    return UsageStats.fromRows(filtered.map((d) => d.toStatsMap()).toList());
  }

  /// 返回最近 N 天的趋势数据
  static List<DailyUsage> getDailyTrend({int days = 7}) {
    final now = DateTime.now();
    final cutoff = DateTime(now.year, now.month, now.day).subtract(Duration(days: days - 1));
    return _cachedDailyData.where((d) => !d.date.isBefore(cutoff)).toList();
  }
}

/// 按日期聚合的累加器（仅用于 loadAllData 内部）
class _DayAccumulator {
  final String dateKey;
  int requests = 0;
  int origChars = 0;
  int refChars = 0;
  int timeSaved = 0;
  int translateCount = 0;
  int refineCount = 0;
  int asrMs = 0;
  int llmMs = 0;
  int recordingMs = 0;

  _DayAccumulator(this.dateKey);

  void add(Map<String, dynamic> item) {
    requests++;
    final text = item['text'] as String? ?? '';
    final originalText = item['originalText'] as String? ?? '';
    final mode = item['mode'] as String? ?? 'refine';

    origChars += originalText.length;
    refChars += text.length;
    timeSaved += _estimateTypingSeconds(text);
    asrMs += (item['asrDurationMs'] as int?) ?? 0;
    llmMs += (item['llmDurationMs'] as int?) ?? 0;
    recordingMs += (item['recordingDurationMs'] as int?) ?? 0;

    if (mode == 'translate') {
      translateCount++;
    } else {
      refineCount++;
    }
  }

  DailyUsage toDailyUsage() {
    DateTime date;
    try {
      date = DateTime.parse(dateKey);
    } catch (_) {
      date = DateTime.now();
    }
    return DailyUsage(
      date: date,
      recordingMs: recordingMs,
      refinedChars: refChars,
      totalRequests: requests,
      totalOriginalChars: origChars,
      totalTimeSaved: timeSaved,
      translateCount: translateCount,
      refineCount: refineCount,
      totalAsrMs: asrMs,
      totalLlmMs: llmMs,
    );
  }
}
