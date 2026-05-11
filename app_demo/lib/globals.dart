import 'package:flutter/foundation.dart';

// 全局通知器，当设置面板更新热键时触发，通知主录音组件重新绑定
final ValueNotifier<int> globalSettingsNotifier = ValueNotifier<int>(0);

// 全局字体通知器，用于全 APP 切换字体
final ValueNotifier<String> globalFontNotifier = ValueNotifier<String>('System');

// 录音模式
enum PlayMode { refine, translate }

// 悬浮窗的各种密封状态（利用 Dart 3 的 exhaustive 检查）
sealed class BubbleState {}
class BubbleIdle extends BubbleState {}

class BubbleRecording extends BubbleState {
  final PlayMode mode;
  BubbleRecording(this.mode);
}

class BubbleProcessing extends BubbleState {
  final PlayMode mode;
  BubbleProcessing(this.mode);
}

class BubblePasting extends BubbleState {
  final PlayMode mode;
  final String successDesc;
  BubblePasting(this.mode, {this.successDesc = ''});
}

class BubbleError extends BubbleState {
  final String msg;
  BubbleError(this.msg);
}

// IPC channel 名称常量（双向通信）
const String kIpcChannelName = 'gravity/ipc';
