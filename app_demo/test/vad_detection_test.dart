import 'package:flutter_test/flutter_test.dart';

/// VAD 语音活动检测 — 纯逻辑单元测试
/// 从 main.dart 中提取的 VAD 判定逻辑
void main() {
  // ==================== 振幅归一化 ====================
  group('振幅归一化 (dB → 0.0~1.0)', () {
    double normalize(double dbValue) {
      return ((dbValue + 60.0) / 60.0).clamp(0.0, 1.0);
    }

    test('完全静音 (-60 dB) 应归一化为 0.0', () {
      expect(normalize(-60.0), equals(0.0));
    });

    test('最大振幅 (0 dB) 应归一化为 1.0', () {
      expect(normalize(0.0), equals(1.0));
    });

    test('中间振幅 (-30 dB) 应归一化为 0.5', () {
      expect(normalize(-30.0), equals(0.5));
    });

    test('低于 -60 dB 应钳制为 0.0', () {
      expect(normalize(-100.0), equals(0.0));
    });

    test('高于 0 dB 应钳制为 1.0', () {
      expect(normalize(10.0), equals(1.0));
    });
  });

  // ==================== 活跃帧判定 ====================
  group('活跃帧判定 (threshold = 0.15)', () {
    bool isActiveFrame(double normalized) => normalized > 0.15;

    test('振幅 0.16 应判定为活跃', () {
      expect(isActiveFrame(0.16), isTrue);
    });

    test('振幅 0.15 应判定为非活跃 (等于阈值)', () {
      expect(isActiveFrame(0.15), isFalse);
    });

    test('振幅 0.0 应判定为非活跃', () {
      expect(isActiveFrame(0.0), isFalse);
    });

    test('振幅 1.0 应判定为活跃', () {
      expect(isActiveFrame(1.0), isTrue);
    });
  });

  // ==================== VAD 综合判定 ====================
  group('VAD 静音/有效判定', () {
    /// 镜像 floating_window.dart:567 的 VAD 判定逻辑
    /// 阈值: activeRatio < 0.15 || fileSize < 3000 || durationMs < 800
    bool shouldDiscard({
      required int activeFrames,
      required int totalFrames,
      required int fileSize,
      required int durationMs,
    }) {
      final activeRatio = totalFrames > 0 ? (activeFrames / totalFrames) : 0.0;
      return activeRatio < 0.15 || fileSize < 3000 || durationMs < 800;
    }

    test('正常录音: 活跃帧 50%, 大文件, 长时间 → 不应丢弃', () {
      expect(shouldDiscard(activeFrames: 50, totalFrames: 100, fileSize: 50000, durationMs: 3000), isFalse);
    });

    test('活跃帧比例 8% → 应丢弃 (低于 15%)', () {
      expect(shouldDiscard(activeFrames: 8, totalFrames: 100, fileSize: 50000, durationMs: 3000), isTrue);
    });

    test('活跃帧比例恰好 15% → 不应丢弃', () {
      expect(shouldDiscard(activeFrames: 15, totalFrames: 100, fileSize: 50000, durationMs: 3000), isFalse);
    });

    test('文件太小 (2KB) → 应丢弃', () {
      expect(shouldDiscard(activeFrames: 50, totalFrames: 100, fileSize: 2000, durationMs: 3000), isTrue);
    });

    test('时长太短 (300ms) → 应丢弃', () {
      expect(shouldDiscard(activeFrames: 50, totalFrames: 100, fileSize: 50000, durationMs: 300), isTrue);
    });

    test('总帧数为 0 → 应丢弃 (无任何采样)', () {
      expect(shouldDiscard(activeFrames: 0, totalFrames: 0, fileSize: 50000, durationMs: 3000), isTrue);
    });

    test('恰好边界: 15% ratio, 3KB file, 800ms → 不应丢弃', () {
      expect(shouldDiscard(activeFrames: 15, totalFrames: 100, fileSize: 3000, durationMs: 800), isFalse);
    });

    test('三项全部不达标 → 应丢弃', () {
      expect(shouldDiscard(activeFrames: 2, totalFrames: 100, fileSize: 2000, durationMs: 200), isTrue);
    });
  });
}
