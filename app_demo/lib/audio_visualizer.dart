import 'dart:math' as math;
import 'package:flutter/material.dart';

class AudioVisualizer extends StatefulWidget {
  final double amplitude; // 0.0 to 1.0
  final bool isProcessing;
  final Color? color;
  
  const AudioVisualizer({
    super.key, 
    required this.amplitude,
    this.isProcessing = false,
    this.color,
  });

  @override
  State<AudioVisualizer> createState() => _AudioVisualizerState();
}

class _AudioVisualizerState extends State<AudioVisualizer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 使用 TweenAnimationBuilder 将生硬跳变的 widget.amplitude 转化为 150ms 连续平滑过渡的 smoothAmplitude
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: widget.amplitude),
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOutCubic, // 使用三次缓出曲线，让回弹感更细腻
      builder: (context, smoothAmplitude, child) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: const Size(120, 24),
              painter: _WavePainter(
                amplitude: smoothAmplitude,
                phase: _controller.value * 2 * math.pi,
                isProcessing: widget.isProcessing,
                color: widget.color,
              ),
            );
          },
        );
      },
    );
  }
}

class _WavePainter extends CustomPainter {
  final double amplitude;
  final double phase;
  final bool isProcessing;
  final Color? color;

  _WavePainter({
    required this.amplitude,
    required this.phase,
    required this.isProcessing,
    this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Apple 风格：白色/浅灰波纹，如果传入了 theme color 就使用之
    final mainColor = color ?? (isProcessing
        ? const Color(0xFF8E8E93) // SF Gray
        : const Color(0xFF3A3A3C)); // Dark gray on white

    final paint1 = Paint()
      ..color = mainColor.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final paint2 = Paint()
      ..color = mainColor.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final path = Path();

    _drawWave(canvas, path, size, paint1, 1.0, phase, 1.5);
    _drawWave(canvas, path, size, paint2, 0.6, phase + 1.2, 2.0);
  }

  void _drawWave(Canvas canvas, Path path, Size size, Paint paint, double heightFactor, double currentPhase, double speed) {
    path.reset();
    final centerY = size.height / 2;
    final width = size.width;

    path.moveTo(0, centerY);

    for (double x = 0; x <= width; x += 1) {
      // 核心算法：
      // h = sin(x / freq + phase) * amplitude * damping
      // damping 是为了让线段两头固定在中间，产生“胶囊内振动”的效果
      final double normalizedX = x / width;
      final double damping = math.sin(normalizedX * math.pi); // 两头为0，中间为1
      
      // 叠加一点随机噪点感
      final double sinVal = math.sin(normalizedX * 6 + currentPhase * speed);
      final double cosVal = math.cos(normalizedX * 3 - currentPhase * 0.5);
      
      // 当 amplitude 很小时，它几乎就是一条横线
      final double yOffset = (sinVal + cosVal * 0.3) * (amplitude * 15 + (isProcessing ? 3 : 0)) * damping * heightFactor;
      
      path.lineTo(x, centerY + yOffset);
    }
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) {
    return oldDelegate.amplitude != amplitude || oldDelegate.phase != phase;
  }
}
