import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'i18n/strings.g.dart';

// 词条数据模型
class VocabEntry {
  final String spoken;   // 说话时的词
  final String written;  // 希望输出的词

  VocabEntry({required this.spoken, required this.written});

  Map<String, dynamic> toJson() => {'spoken': spoken, 'written': written};
  factory VocabEntry.fromJson(Map<String, dynamic> j) =>
      VocabEntry(spoken: j['spoken'] ?? '', written: j['written'] ?? '');
}

// 本地存储
class VocabStorage {
  static const _key = 'custom_vocabulary';

  static Future<List<VocabEntry>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    try {
      final list = jsonDecode(raw) as List;
      return list
          .whereType<Map<String, dynamic>>()
          .map((e) => VocabEntry.fromJson(e))
          .toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> save(List<VocabEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(entries.map((e) => e.toJson()).toList()));
  }
}

class VocabularyView extends StatefulWidget {
  const VocabularyView({Key? key}) : super(key: key);

  @override
  State<VocabularyView> createState() => _VocabularyViewState();
}

class _VocabularyViewState extends State<VocabularyView> {
  List<VocabEntry> _entries = [];
  final _spokenCtrl = TextEditingController();
  final _writtenCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _spokenCtrl.dispose();
    _writtenCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final entries = await VocabStorage.load();
    if (mounted) setState(() => _entries = entries);
  }

  Future<void> _add() async {
    final spoken = _spokenCtrl.text.trim();
    final written = _writtenCtrl.text.trim();
    if (spoken.isEmpty || written.isEmpty) return;
    if (spoken == written) return; // 相同的映射无意义
    _entries.add(VocabEntry(spoken: spoken, written: written));
    await VocabStorage.save(_entries);
    _spokenCtrl.clear();
    _writtenCtrl.clear();
    setState(() {});
  }

  Future<void> _delete(int index) async {
    _entries.removeAt(index);
    await VocabStorage.save(_entries);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.t.vocab.title,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87, letterSpacing: -0.5)),
        const SizedBox(height: 6),
        Text(context.t.vocab.subtitle,
            style: const TextStyle(color: Colors.black45, fontSize: 14)),
        const SizedBox(height: 24),

        // 添加词条
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.t.vocab.add_title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(_spokenCtrl, context.t.vocab.spoken_hint, Icons.mic_none_rounded),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.arrow_forward_rounded, color: Colors.black26, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(_writtenCtrl, context.t.vocab.written_hint, Icons.text_fields_rounded),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _add,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007AFF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      elevation: 0,
                    ),
                    child: Text(context.t.vocab.add_btn, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 词条列表
        Expanded(
          child: _entries.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('📖', style: TextStyle(fontSize: 48)),
                      const SizedBox(height: 16),
                      Text(context.t.vocab.empty, style: const TextStyle(color: Colors.black38, fontSize: 15)),
                    ],
                  ),
                )
              : ListView.separated(
                  itemCount: _entries.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, i) {
                    final e = _entries[i];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black.withOpacity(0.05)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F2F7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(e.spoken, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.arrow_forward_rounded, size: 16, color: Colors.black38),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(e.written, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Colors.redAccent),
                            onPressed: () => _delete(i),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String hint, IconData icon) {
    return TextField(
      controller: ctrl,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
        prefixIcon: Icon(icon, size: 18, color: Colors.black38),
        filled: true,
        fillColor: const Color(0xFFF5F5F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      onSubmitted: (_) => _add(),
    );
  }
}
