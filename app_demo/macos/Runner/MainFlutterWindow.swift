import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  /// 当此开关为 false 时，窗口拒绝成为 Key/Main Window，
  /// 从而阻止 macOS 在窗口变可见时将焦点从其他应用抢夺过来。
  /// - 录音悬浮球模式：设为 false
  /// - Dashboard 面板模式：设为 true
  static var allowActivation: Bool = true

  override var canBecomeKey: Bool {
    return MainFlutterWindow.allowActivation
  }

  override var canBecomeMain: Bool {
    return MainFlutterWindow.allowActivation
  }

  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
