import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'usage_stats_service.dart';
import 'i18n/strings.g.dart';
class HistoryItem {
  final String id;
  final String timestamp;
  final String text;
  final String originalText;
  final String mode; // 'refine' or 'translate'
  
  // New debugging metadata
  final int asrDurationMs;
  final int llmDurationMs;
  final String asrProvider;
  final String asrModel;
  final String llmProvider;
  final String llmModel;
  final int recordingDurationMs;

  HistoryItem({
    required this.id,
    required this.timestamp,
    required this.text,
    this.originalText = '',
    required this.mode,
    this.asrDurationMs = 0,
    this.llmDurationMs = 0,
    this.asrProvider = 'Unknown',
    this.asrModel = 'Unknown',
    this.llmProvider = 'Unknown',
    this.llmModel = 'Unknown',
    this.recordingDurationMs = 0,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'timestamp': timestamp,
        'text': text,
        'originalText': originalText,
        'mode': mode,
        'asrDurationMs': asrDurationMs,
        'llmDurationMs': llmDurationMs,
        'asrProvider': asrProvider,
        'asrModel': asrModel,
        'llmProvider': llmProvider,
        'llmModel': llmModel,
        'recordingDurationMs': recordingDurationMs,
      };

  factory HistoryItem.fromJson(Map<String, dynamic> json) => HistoryItem(
        id: json['id'] as String? ?? '',
        timestamp: json['timestamp'] as String? ?? '',
        text: json['text'] as String? ?? '',
        originalText: json['originalText'] as String? ?? '',
        mode: json['mode'] as String? ?? 'refine',
        asrDurationMs: json['asrDurationMs'] ?? 0,
        llmDurationMs: json['llmDurationMs'] ?? 0,
        asrProvider: json['asrProvider'] ?? 'Unknown',
        asrModel: json['asrModel'] ?? 'Unknown',
        llmProvider: json['llmProvider'] ?? 'Unknown',
        llmModel: json['llmModel'] ?? 'Unknown',
        recordingDurationMs: json['recordingDurationMs'] ?? 0,
      );
}

// 本地存储服务
class HistoryStorage {
  static const String _historyKey = 'user_history_list';

  static Future<void> saveHistory(
      String text,
      String originalText,
      String mode,
      {
        int asrDurationMs = 0,
        int llmDurationMs = 0,
        String asrProvider = 'Unknown',
        String asrModel = 'Unknown',
        String llmProvider = 'Unknown',
        String llmModel = 'Unknown',
        int recordingDurationMs = 0,
      }) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> historyStrings = prefs.getStringList(_historyKey) ?? [];
    final newItem = HistoryItem(
      id: const Uuid().v4(),
      timestamp: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
      text: text,
      originalText: originalText,
      mode: mode,
      asrDurationMs: asrDurationMs,
      llmDurationMs: llmDurationMs,
      asrProvider: asrProvider,
      asrModel: asrModel,
      llmProvider: llmProvider,
      llmModel: llmModel,
      recordingDurationMs: recordingDurationMs,
    );
    historyStrings.insert(0, jsonEncode(newItem.toJson()));
    if (historyStrings.length > 50) historyStrings.removeLast(); // 仅保留最近50条
    await prefs.setStringList(_historyKey, historyStrings);

  }

  static Future<List<HistoryItem>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> historyStrings = prefs.getStringList(_historyKey) ?? [];
    final List<HistoryItem> result = [];
    for (final s in historyStrings) {
      try {
        result.add(HistoryItem.fromJson(jsonDecode(s)));
      } catch (e) {
        debugPrint('⚠️ [History] Skipping malformed entry: $e');
      }
    }
    return result;
  }

}

// 供 Dashboard 嵌入的历史记录干净视图
class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<HistoryItem> _histories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    usageUpdateNotifier.addListener(_onUsageUpdated);
  }

  @override
  void dispose() {
    usageUpdateNotifier.removeListener(_onUsageUpdated);
    super.dispose();
  }

  void _onUsageUpdated() {
    if (mounted) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    final histories = await HistoryStorage.getHistory();
    if (mounted) {
      setState(() {
        _histories = histories;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator(strokeWidth: 2));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.t.history.title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87, letterSpacing: -0.5)),
        const SizedBox(height: 24),
        Expanded(
          child: _histories.isEmpty 
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.inbox_rounded, size: 48, color: Colors.black12),
                      const SizedBox(height: 16),
                      Text(context.t.history.empty, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black38, fontSize: 14, height: 1.5)),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(bottom: 32, right: 16),
                  itemCount: _histories.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = _histories[index];
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black.withOpacity(0.05)),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: item.mode == 'translate' ? const Color(0xFFE5F0FF) : const Color(0xFFF0E5FF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  item.mode == 'translate' ? context.t.history.mode_translate : context.t.history.mode_refine,
                                  style: TextStyle(
                                    color: item.mode == 'translate' ? const Color(0xFF0066FF) : const Color(0xFF8A2BE2),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Text(item.timestamp, style: const TextStyle(color: Colors.black38, fontSize: 12, fontWeight: FontWeight.w500)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Debug 模式：显示 ASR 原文 + 调试信息 + 分割线
                          if (kDebugMode && item.originalText.isNotEmpty) ...[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(context.t.history.asr_label, style: const TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.bold)),
                                Expanded(child: Text(item.originalText, style: const TextStyle(color: Colors.black54, fontSize: 13, height: 1.5))),
                              ],
                            ),
                            const SizedBox(height: 8),
                            if (item.asrDurationMs > 0) ...[
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9F9FB),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black.withOpacity(0.05)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.speed_rounded, size: 14, color: Colors.blueGrey),
                                        const SizedBox(width: 4),
                                        Text('ASR [${item.asrProvider}]: ${item.asrModel} (${item.asrDurationMs}ms)', style: const TextStyle(fontSize: 12, color: Colors.blueGrey, fontFamily: 'monospace')),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.memory_rounded, size: 14, color: Colors.blueGrey),
                                        const SizedBox(width: 4),
                                        Text('LLM [${item.llmProvider}]: ${item.llmModel} (${item.llmDurationMs}ms)', style: const TextStyle(fontSize: 12, color: Colors.blueGrey, fontFamily: 'monospace')),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                            const Divider(height: 1, color: Colors.black12),
                            const SizedBox(height: 12),
                          ],
                          // 最终结果：Release 只看这行，Debug 在上方还有原文+调试
                          Text(item.text, style: const TextStyle(color: Colors.black87, fontSize: 15, height: 1.6))
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
