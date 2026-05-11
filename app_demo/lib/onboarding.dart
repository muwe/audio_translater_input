import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'i18n/strings.g.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const OnboardingScreen({Key? key, required this.onComplete}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  bool _showFirework = false;
  late AnimationController _fireworkController;
  
  static const MethodChannel _fnKeyChannel = MethodChannel('com.audiotyper.fn_key');

  List<_OnboardingStep> _getSteps(BuildContext context) {
    return [
      _OnboardingStep(
        emoji: '🎙️',
        title: context.t.onboarding.step1_title,
        subtitle: context.t.onboarding.step1_subtitle,
        actionLabel: context.t.onboarding.step1_action,
      ),
      _OnboardingStep(
        emoji: '🎤',
        title: context.t.onboarding.step2_title,
        subtitle: context.t.onboarding.mic_permission_subtitle,
        actionLabel: context.t.onboarding.step2_action,
      ),
      _OnboardingStep(
        emoji: '⚙️',
        title: context.t.onboarding.step3_title,
        subtitle: context.t.onboarding.step3_subtitle,
        actionLabel: context.t.onboarding.step3_action,
      ),
      _OnboardingStep(
        emoji: '🪄',
        title: context.t.onboarding.step4_title,
        subtitle: context.t.onboarding.step4_subtitle,
        actionLabel: context.t.onboarding.complete_trial,
        isTrialStep: true,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _fireworkController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fireworkController.dispose();
    super.dispose();
  }

  void _nextStep(BuildContext context) async {
    // 拦截步骤 3 (索引为 2) - 强校验 macOS 辅助功能权限
    if (_currentStep == 2) {
      try {
        final bool isTrusted = await _fnKeyChannel.invokeMethod('check_accessibility');
        if (!isTrusted) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.t.onboarding.accessibility_warning, style: const TextStyle(color: Colors.white)),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
          return; // 强行拦截
        }
      } catch (e) {
        debugPrint("⚠️ [Onboarding] Accessibility check failed: $e, bypassing for dev safety");
      }
    }

    final length = _getSteps(context).length;
    if (_currentStep < length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 600), curve: Curves.fastOutSlowIn);
    } else {
      setState(() => _showFirework = true);
      _fireworkController.forward();
      await Future.delayed(const Duration(milliseconds: 1500));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_done', true);
      widget.onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 极简深色毛玻璃背景
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF2C2C2E).withOpacity(0.5),
                        const Color(0xFF1C1C1E).withOpacity(0.8)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white12, width: 1),
                  ),
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 32),
                // 顶部进度指示器 (Apple 风格平滑线条)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_getSteps(context).length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 4,
                      width: _currentStep == index ? 24 : 12,
                      decoration: BoxDecoration(
                        color: _currentStep == index ? Colors.white : Colors.white24,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  }),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(), // 禁用手势滑动，强制使用按钮
                    onPageChanged: (idx) => setState(() => _currentStep = idx),
                    itemCount: _getSteps(context).length,
                    itemBuilder: (context, index) {
                      final step = _getSteps(context)[index];
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(step.emoji, style: const TextStyle(fontSize: 80)),
                              const SizedBox(height: 30),
                              Text(
                                step.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                step.subtitle,
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 15,
                                  height: 1.6,
                                  letterSpacing: 0.2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (step.isTrialStep) ...[
                                const SizedBox(height: 40),
                                const _TrialWidget(),
                              ]
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // 底部行动按钮区
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () => _nextStep(context),
                          child: Text(
                            _getSteps(context)[_currentStep].actionLabel,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (_currentStep < _getSteps(context).length - 1)
                        TextButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('onboarding_done', true);
                            widget.onComplete();
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            minimumSize: Size.zero,
                          ),
                          child: Text(context.t.onboarding.skip, style: const TextStyle(color: Colors.white38, fontSize: 13)),
                        )
                      else
                        const SizedBox(height: 35), // 保持高度一致避免跳脚
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (_showFirework)
            _FireworkOverlay(controller: _fireworkController),
        ],
      ),
    );
  }
}

class _OnboardingStep {
  final String emoji;
  final String title;
  final String subtitle;
  final String actionLabel;
  final bool isTrialStep;
  const _OnboardingStep({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    this.isTrialStep = false,
  });
}

// ── 互动演练组件 ────────────────────────────────────────────────
class _TrialWidget extends StatefulWidget {
  const _TrialWidget({Key? key}) : super(key: key);

  @override
  State<_TrialWidget> createState() => _TrialWidgetState();
}

class _TrialWidgetState extends State<_TrialWidget> {
  _TrialPhase _phase = _TrialPhase.idle;

  void _simulateRecording() async {
    if (_phase == _TrialPhase.recording || _phase == _TrialPhase.processing) return;

    setState(() => _phase = _TrialPhase.recording);

    // 模拟录音 3 秒
    await Future.delayed(const Duration(seconds: 3));

    setState(() => _phase = _TrialPhase.processing);

    // 模拟处理 1.5 秒
    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() => _phase = _TrialPhase.done);
  }

  String _resolveText(BuildContext context) {
    switch (_phase) {
      case _TrialPhase.idle:
        return context.t.onboarding.hold_fn_hint;
      case _TrialPhase.recording:
        return context.t.onboarding.listening;
      case _TrialPhase.processing:
        return context.t.onboarding.refining;
      case _TrialPhase.done:
        return context.t.onboarding.trial_success;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRecording = _phase == _TrialPhase.recording;
    final isProcessing = _phase == _TrialPhase.processing;
    return GestureDetector(
      onTapDown: (_) => _simulateRecording(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        decoration: BoxDecoration(
          color: isRecording ? Colors.white12 : Colors.black26,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isRecording ? Colors.white38 : Colors.white12),
          boxShadow: isRecording ? [const BoxShadow(color: Colors.white10, blurRadius: 20)] : [],
        ),
        child: Column(
          children: [
            if (isProcessing)
              const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            else
              Text(
                _resolveText(context),
                style: TextStyle(
                  color: isRecording ? Colors.white : Colors.white70,
                  fontSize: 16,
                  fontWeight: isRecording ? FontWeight.bold : FontWeight.normal
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 12),
            Text(context.t.onboarding.click_to_simulate, style: const TextStyle(color: Colors.white38, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

enum _TrialPhase { idle, recording, processing, done }

// ── 烟花动画 ────────────────────────────────────────────────
class _FireworkOverlay extends StatelessWidget {
  final AnimationController controller;
  const _FireworkOverlay({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return IgnorePointer(
          child: CustomPaint(
            size: Size.infinite,
            painter: _FireworkPainter(progress: controller.value),
          ),
        );
      },
    );
  }
}

class _FireworkPainter extends CustomPainter {
  final double progress;
  static final _random = [
    [0.3, 0.3, 0xFFFF6B6B],
    [0.7, 0.25, 0xFF4ECDC4],
    [0.5, 0.4, 0xFFFFE66D],
    [0.2, 0.6, 0xFF95E1D3],
    [0.8, 0.5, 0xFFF38181],
    [0.6, 0.7, 0xFFC3A6FF],
  ];

  _FireworkPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;
    final t = progress.clamp(0.0, 1.0);
    for (final p in _random) {
      final cx = p[0] * size.width;
      final cy = p[1] * size.height;
      final color = Color(p[2].toInt());
      for (int i = 0; i < 12; i++) {
        final angle = (i / 12) * 3.14159 * 2;
        final dist = t * 80;
        final dx = cx + dist * _cos(angle);
        final dy = cy + dist * _sin(angle);
        final paint = Paint()
          ..color = color.withOpacity((1.0 - t).clamp(0.0, 1.0))
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(
          Offset(cx + (dx - cx) * 0.3, cy + (dy - cy) * 0.3),
          Offset(dx, dy),
          paint,
        );
      }
    }
  }

  double _cos(double a) => a < 3.14159 / 2 ? 1 - a * a / 2 : (a < 3.14159 ? -(a - 3.14159) * (a - 3.14159) / 2 + 1 - 1 : (a < 3 * 3.14159 / 2 ? -(a - 3.14159) : (2 * 3.14159 - a) * (2 * 3.14159 - a) / 2 - 1));
  double _sin(double a) => _cos(a - 3.14159 / 2);

  @override
  bool shouldRepaint(_FireworkPainter oldDelegate) => oldDelegate.progress != progress;
}
