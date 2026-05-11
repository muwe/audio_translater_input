import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'settings_view.dart';
import 'history_dashboard.dart';
import 'vocabulary_view.dart';
import 'i18n/strings.g.dart';
import 'usage_stats_service.dart';

class MainDashboard extends StatefulWidget {
  final VoidCallback onClose;
  const MainDashboard({Key? key, required this.onClose}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;
  UsageStats _stats = UsageStats();
  List<DailyUsage> _trendData = [];
  bool _statsLoading = true;
  StatsPeriod _selectedPeriod = StatsPeriod.allTime;
  

  @override
  void initState() {
    super.initState();
    _loadStats();
    usageUpdateNotifier.addListener(_onStatsUpdated);
  }

  @override
  void dispose() {
    usageUpdateNotifier.removeListener(_onStatsUpdated);
    super.dispose();
  }

  void _onStatsUpdated() {
    _loadStats();
  }

  Future<void> _loadStats() async {
    // 确保全量数据已加载到内存缓存
    await UsageStatsService.loadAllData();
    if (mounted) {
      setState(() {
        _stats = UsageStatsService.getStats(_selectedPeriod);
        _trendData = UsageStatsService.getDailyTrend(days: 7);
        _statsLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFFBFBFD), // Apple Very Light Gray
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black.withOpacity(0.05), width: 1.5),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 40, offset: const Offset(0, 10))
          ],
        ),
        child: Row(
          children: [
            _buildSidebar(),
            const VerticalDivider(width: 1, color: Color(0xFFE5E5E7)),
            Expanded(child: _buildMainContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 220,
      color: const Color(0xFFF5F5F7).withOpacity(0.8),
      padding: const EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Text('GRAVITY', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black45, letterSpacing: 1.2)),
          ),
          _sidebarItem(0, Icons.compass_calibration_rounded, context.t.dashboard.sidebar.home),
          _sidebarItem(1, Icons.auto_awesome_motion_rounded, context.t.dashboard.sidebar.history),
          _sidebarItem(2, Icons.library_books_rounded, context.t.vocab.title),
          _sidebarItem(3, Icons.settings_rounded, context.t.dashboard.sidebar.settings),
          
          const Spacer(),
        ],
      ),
    );
  }


  Widget _sidebarItem(int index, IconData icon, String title) {
    final isSelected = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: InkWell(
        onTap: () => setState(() => _selectedIndex = index),
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected ? [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4, offset: const Offset(0, 2))] : [],
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: isSelected ? const Color(0xFF007AFF) : Colors.black54),
              const SizedBox(width: 12),
              Flexible(
                child: Text(title, overflow: TextOverflow.ellipsis, style: TextStyle(
                  fontSize: 14, 
                  color: isSelected ? Colors.black87 : Colors.black54, 
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
      child: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeView(),
          HistoryView(key: ValueKey(1)),
          VocabularyView(key: ValueKey(2)),
          const SettingsView(key: ValueKey(3)),
        ],
      ),
    );
  }

  Widget _buildHomeView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                key: const ValueKey(0),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(context.t.dashboard.home.greeting, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87, letterSpacing: -0.8)),
                          const SizedBox(height: 4),
                          Text(context.t.dashboard.home.subtitle, style: const TextStyle(fontSize: 16, color: Colors.black45)),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Color(0xFFF2F2F7),
                        child: Icon(Icons.person_outline_rounded, color: Colors.black54),
                      )
                    ],
                  ),
        const SizedBox(height: 24),

        // ── 时间段选择器 ──
        Row(
          children: [
            for (final period in StatsPeriod.values)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(_periodLabel(period)),
                  selected: _selectedPeriod == period,
                  onSelected: (_) {
                    setState(() {
                      _selectedPeriod = period;
                      _stats = UsageStatsService.getStats(_selectedPeriod);
                    });
                  },
                  selectedColor: const Color(0xFF007AFF).withOpacity(0.15),
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: _selectedPeriod == period ? FontWeight.bold : FontWeight.normal,
                    color: _selectedPeriod == period ? const Color(0xFF007AFF) : Colors.black54,
                  ),
                  backgroundColor: const Color(0xFFF2F2F7),
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  visualDensity: VisualDensity.compact,
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        // ── 三大 KPI 统计卡片 ──
        _statsLoading
          ? const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator(strokeWidth: 2)))
          : Row(
              children: [
                Expanded(child: _buildKPICard(
                  icon: Icons.timer_outlined,
                  iconColor: const Color(0xFF007AFF),
                  label: context.t.history.kpi.usage_time,
                  value: _formatDuration(context, _stats.totalRecordingMs),
                )),
                const SizedBox(width: 12),
                Expanded(child: _buildKPICard(
                  icon: Icons.text_fields_rounded,
                  iconColor: const Color(0xFF34C759),
                  label: context.t.history.kpi.chars,
                  value: _formatNumber(_stats.totalRefinedChars),
                )),
                const SizedBox(width: 12),
                Expanded(child: _buildKPICard(
                  icon: Icons.speed_rounded,
                  iconColor: const Color(0xFFFF9500),
                  label: context.t.history.kpi.time_saved,
                  value: _formatTimeSaved(context, _stats.totalTimeSaved),
                )),
              ],
            ),
        const SizedBox(height: 12),
        // ── 次要统计行 ──
        if (!_statsLoading && _stats.totalRequests > 0)
          Row(
            children: [
              _buildMiniStat(Icons.mic_rounded, '${context.t.history.kpi.refine}: ${_stats.refineCount}'),
              const SizedBox(width: 12),
              _buildMiniStat(Icons.translate_rounded, '${context.t.history.kpi.translate}: ${_stats.translateCount}'),
              const SizedBox(width: 12),
              _buildMiniStat(Icons.bar_chart_rounded, '${context.t.history.kpi.requests}: ${_stats.totalRequests}'),
            ],
          ),
              const SizedBox(height: 24),
              Flexible(
                child: Row(
                  children: [
                     Expanded(
                       flex: 9,
                       child: SizedBox(
                         height: 220,
                         child: _buildTrendChartCard(),
                       ),
                     ),
                     const SizedBox(width: 20),
                     Expanded(
                       flex: 5,
                       child: SizedBox(
                         height: 220,
                         child: _buildGoalGaugeCard(),
                        ),
                      ),
                   ],
                 ),
               ),
               const SizedBox(height: 20),
               // ── 快速指南（紧凑行） ──
               Text(context.t.dashboard.home.guide.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
               const SizedBox(height: 8),
               Row(
                 children: [
                   Expanded(child: _buildGuideItemCompact(Icons.mic_none_rounded, context.t.dashboard.home.guide.voice_input.title, context.t.dashboard.home.guide.voice_input.desc)),
                   const SizedBox(width: 12),
                   Expanded(child: _buildGuideItemCompact(Icons.translate_rounded, context.t.dashboard.home.guide.realtime_translate.title, context.t.dashboard.home.guide.realtime_translate.desc)),
                   const SizedBox(width: 12),
                   Expanded(child: _buildGuideItemCompact(Icons.history_edu_rounded, context.t.dashboard.home.guide.smart_format.title, context.t.dashboard.home.guide.smart_format.desc)),
                 ],
               ),
             ],
           ),
         ),
       ),
     );
   },
 );
}

  Widget _buildTrendChartCard() {
    // Generate latest 7 days for X-axis labels implicitly
    final now = DateTime.now();
    final List<String> last7Days = List.generate(7, (i) {
      final date = now.subtract(Duration(days: 6 - i));
      return '${date.month}/${date.day}';
    });
    
    // Map trend data to spots — O(n) via date-keyed lookup
    List<FlSpot> spots = [];
    double maxY = 1.0;

    if (_trendData.isNotEmpty) {
      // 预建日期→数据的映射，避免 O(7n) 嵌套循环
      final dataByDate = <String, DailyUsage>{};
      for (final d in _trendData) {
        dataByDate['${d.date.year}-${d.date.month}-${d.date.day}'] = d;
      }
      for (int i = 0; i < 7; i++) {
        final dateOfInterest = now.subtract(Duration(days: 6 - i));
        final key = '${dateOfInterest.year}-${dateOfInterest.month}-${dateOfInterest.day}';
        final match = dataByDate[key];

        double val = match != null ? match.recordingMs / 60000.0 : 0;
        spots.add(FlSpot(i.toDouble(), val));
        if (val > maxY) maxY = val;
      }
    } else {
      for (int i = 0; i < 7; i++) spots.add(FlSpot(i.toDouble(), 0));
    }

    final displayHours = (_stats.totalRecordingMs / 3600000.0).toStringAsFixed(1);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.t.dashboard.home.stats.focus_performance, style: const TextStyle(fontSize: 14, color: Colors.black45, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text(context.t.dashboard.home.stats.hours(hours: displayHours), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFF2F2F7), borderRadius: BorderRadius.circular(12)),
                child: const Text('Live', style: TextStyle(color: Color(0xFF007AFF), fontSize: 12, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx >= 0 && idx < 7) {
                          return Text(last7Days[idx], style: const TextStyle(color: Colors.black45, fontSize: 11));
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minY: 0,
                maxY: maxY * 1.2,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: const Color(0xFF007AFF),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF007AFF).withOpacity(0.3),
                          const Color(0xFF007AFF).withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalGaugeCard() {
    double progress = (_stats.totalRefinedChars / 10000.0).clamp(0.0, 1.0); // 1万字为一个小目标

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(context.t.dashboard.home.stats.goal_reached, style: const TextStyle(fontSize: 14, color: Colors.black45, fontWeight: FontWeight.w500)),
          const SizedBox(height: 16),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 10,
                  backgroundColor: const Color(0xFFF2F2F7),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFF9500)),
                  strokeAlign: CircularProgressIndicator.strokeAlignCenter,
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${(progress * 100).toInt()}%', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87, height: 1.0)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(context.t.dashboard.home.stats.processed_words(words: _formatNumber(_stats.totalRefinedChars)), style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // ── KPI 卡片与辅助方法 ──

  String _periodLabel(StatsPeriod period) {
    switch (period) {
      case StatsPeriod.today: return context.t.history.period.today;
      case StatsPeriod.week: return context.t.history.period.week;
      case StatsPeriod.month: return context.t.history.period.month;
      case StatsPeriod.allTime: return context.t.history.period.all;
    }
  }

  String _formatDuration(BuildContext context, int ms) {
    if (ms < 60000) return '${(ms / 1000).toStringAsFixed(0)}s';
    final minutes = ms ~/ 60000;
    final seconds = (ms % 60000) ~/ 1000;
    if (minutes < 60) return context.t.common.min_sec(min: minutes, sec: seconds);
    final hours = minutes ~/ 60;
    return context.t.common.hour_min(hour: hours, min: minutes % 60);
  }

  String _formatTimeSaved(BuildContext context, int seconds) {
    if (seconds < 60) return '${seconds}s';
    final minutes = seconds ~/ 60;
    if (minutes < 60) return context.t.common.n_minutes(n: minutes);
    final hours = minutes ~/ 60;
    return context.t.common.n_hours(n: hours, min: minutes % 60);
  }

  String _formatNumber(int n) {
    if (n < 1000) return '$n';
    if (n < 10000) return '${(n / 1000).toStringAsFixed(1)}k';
    return '${(n / 10000).toStringAsFixed(1)}w';
  }

  Widget _buildKPICard({required IconData icon, required Color iconColor, required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 6))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87, letterSpacing: -0.5)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.black45, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildMiniStat(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.04)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.black38),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildGuideItemCompact(IconData icon, String title, String desc) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                Text(desc, style: const TextStyle(fontSize: 11, color: Colors.black38), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
