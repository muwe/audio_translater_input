import Cocoa
import FlutterMacOS
import CoreGraphics
import desktop_multi_window

@main
class AppDelegate: FlutterAppDelegate {

  // 用于回调到 Dart 层的 MethodChannel
  var fnKeyChannel: FlutterMethodChannel?
  // 全局事件监听句柄
  var globalMonitor: Any?
  // 本地事件监听句柄
  var localMonitor: Any?
  // 追踪 Fn 键当前是否已按下（仅在主线程操作）
  private var isFnKeyDown: Bool = false
  // 记录最近一次 Fn 操作的时间（防抖核心）
  private var lastFnActivityTime: Date = Date.distantPast
  // 录音开始时保存的前台 App（粘贴时需要切回去）
  private weak var savedFrontmostApp: NSRunningApplication?

  override func applicationDidFinishLaunching(_ notification: Notification) {
    guard let controller = mainFlutterWindow?.contentViewController as? FlutterViewController else {
      NSLog("[AppDelegate] ERROR: mainFlutterWindow or contentViewController is nil")
      return
    }

    // 为 desktop_multi_window 创建的子窗口注册所有 Flutter 插件
    FlutterMultiWindowPlugin.setOnWindowCreatedCallback { flutterViewController in
      RegisterGeneratedPlugins(registry: flutterViewController)

      // 强行拦截子窗口，剥夺它的原生黑底背景和阴影
      DispatchQueue.main.async {
        if let window = flutterViewController.view.window {
          window.isOpaque = false
          window.backgroundColor = NSColor.clear
          window.hasShadow = false
        }
      }
    }

    fnKeyChannel = FlutterMethodChannel(
      name: "com.audiotyper.fn_key",
      binaryMessenger: controller.engine.binaryMessenger
    )

    // Dart → Swift 方法调用处理
    fnKeyChannel?.setMethodCallHandler { [weak self] (call, result) in
      guard let self = self else { return }
      switch call.method {
      case "paste_to_frontmost":
        // 粘贴到录音前保存的前台 App
        self.pasteToSavedApp {
          result(nil)
        }
      case "save_frontmost":
        let myBundleId = Bundle.main.bundleIdentifier ?? ""
        if let front = NSWorkspace.shared.frontmostApplication,
           front.bundleIdentifier != myBundleId {
          self.savedFrontmostApp = front
          NSLog("[SaveFrontmost] Saved via Flutter explicit call: \(front.localizedName ?? "nil")")
        }
        result(nil)
      case "check_accessibility":
        // 检查并请求辅助功能权限（若未授权，macOS会自动弹窗提示跳转设置）
        let options = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options as CFDictionary)
        NSLog("[Accessibility] Status: \(accessEnabled)")
        result(accessEnabled)
      case "play_success_sound":
        DispatchQueue.main.async {
          NSSound(named: "Glass")?.play()
        }
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }

    // 全局监听：App 不在前台时也能检测 Fn 键
    globalMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.flagsChanged]) { [weak self] event in
      DispatchQueue.main.async {
        self?.handleFlagsChanged(event)
      }
    }
    // 本地监听：App 在前台时
    localMonitor = NSEvent.addLocalMonitorForEvents(matching: [.flagsChanged]) { [weak self] event in
      DispatchQueue.main.async {
        self?.handleFlagsChanged(event)
      }
      return event
    }

    // 启动时主动激活应用到前台（frameless 窗口不响应 `open` 命令）
    DispatchQueue.main.async {
      NSApp.activate(ignoringOtherApps: true)
      self.mainFlutterWindow?.makeKeyAndOrderFront(nil)
    }
  }

  // Fn+Shift 同时按下的抖动检测
  private var fnDebounceWorkItem: DispatchWorkItem?
  private var fnDebounceTranslate = false
  private static let fnDebounceMs: Int = 150  // 同时按键的容差窗口
  // 延迟恢复 allowActivation 的工作项（可取消）
  private var activationRestoreWorkItem: DispatchWorkItem?

  /// 检测 Fn 键按下/松开，带 Shift 抖动检测
  /// 注意：此方法始终在主线程调用（通过 DispatchQueue.main.async 保证）
  func handleFlagsChanged(_ event: NSEvent) {
    let isFunctionKeyPressed = event.modifierFlags.contains(.function)
    let isShiftPressed = event.modifierFlags.contains(.shift)

    // 只要有任何针对 Fn 键的判定和状态变更，刷新最近活跃时间
    if isFunctionKeyPressed || isFnKeyDown {
      lastFnActivityTime = Date()
    }

    if isFunctionKeyPressed && !isFnKeyDown {
      // Fn 首次按下：保存前台 App
      let myBundleId = Bundle.main.bundleIdentifier ?? ""
      if let front = NSWorkspace.shared.frontmostApplication,
         front.bundleIdentifier != myBundleId {
        savedFrontmostApp = front
      } else {
        savedFrontmostApp = NSWorkspace.shared.runningApplications.first(where: {
          $0.activationPolicy == .regular &&
          $0.bundleIdentifier != myBundleId &&
          !$0.isHidden
        })
      }
      isFnKeyDown = true
      // 🔒 录音模式：禁止窗口获取焦点，防止 Flutter setOpacity 时抢夺前台
      // 取消之前的恢复任务
      activationRestoreWorkItem?.cancel()
      activationRestoreWorkItem = nil
      MainFlutterWindow.allowActivation = false

      // 乐观 UI 更新：无论是否按住 Shift，立刻下发一次首帧事件，消除 UI 延迟感
      let initialIsTranslate = isShiftPressed
      self.fnKeyChannel?.invokeMethod("fn_down", arguments: ["isTranslate": initialIsTranslate])

      if initialIsTranslate {
        NSLog("[FnKey] Fn+Shift simultaneous (Shift already held), isTranslate=true")
        fnDebounceWorkItem?.cancel()
        fnDebounceWorkItem = nil
      } else {
        // Shift 未按住：启动 150ms 观察窗口，如果期间按下 Shift 则触发升级
        NSLog("[FnKey] Fn pressed (optimistic refine), watching for Shift for \(AppDelegate.fnDebounceMs)ms...")
        let workItem = DispatchWorkItem { [weak self] in
          // 仅作为防抖超时的清空守卫
          self?.fnDebounceWorkItem = nil
        }
        fnDebounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(
          deadline: .now() + .milliseconds(AppDelegate.fnDebounceMs),
          execute: workItem
        )
      }
    } else if isFunctionKeyPressed && isFnKeyDown {
      // Fn 保持按住状态：如果在抖动窗口内检测到 Shift，立刻平滑过渡 (Upgrade) 为翻译模式
      if isShiftPressed, let workItem = fnDebounceWorkItem, !workItem.isCancelled {
        NSLog("[FnKey] Shift detected within debounce window, immediately upgrading to translate")
        workItem.cancel()
        fnDebounceWorkItem = nil
        self.fnKeyChannel?.invokeMethod("fn_down", arguments: ["isTranslate": true])
      }
    } else if !isFunctionKeyPressed && isFnKeyDown {
      // Fn 被松开：取消任何残余探测窗口
      if let workItem = fnDebounceWorkItem, !workItem.isCancelled {
        workItem.cancel()
        fnDebounceWorkItem = nil
        NSLog("[FnKey] Fn released during debounce, cancelled detector.")
      }
      isFnKeyDown = false
      // 🔓 延迟恢复窗口激活能力（等录音处理流程结束后再解锁）
      let restoreItem = DispatchWorkItem { [weak self] in
        guard let self = self else { return }
        // 只有在没有新的 Fn 按下事件时才恢复
        if !self.isFnKeyDown {
          MainFlutterWindow.allowActivation = true
        }
        self.activationRestoreWorkItem = nil
      }
      activationRestoreWorkItem = restoreItem
      DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: restoreItem)

      self.fnKeyChannel?.invokeMethod("fn_up", arguments: nil)
    }
  }

  /// 激活录音前的前台 App，然后发送 Cmd+V 粘贴
  func pasteToSavedApp(completion: @escaping () -> Void) {
    guard let app = savedFrontmostApp else {
      NSLog("[Paste] No saved app reference, sending Cmd+V to current active process")
      sendCmdV(completion: completion)
      return
    }

    // 检查目标 App 是否仍在运行
    guard !app.isTerminated else {
      NSLog("[Paste] Target app was terminated, sending Cmd+V to current active process")
      savedFrontmostApp = nil
      sendCmdV(completion: completion)
      return
    }

    let name = app.localizedName ?? "Unknown"

    NSLog("[Paste] → Attempting to activate target: \(name)")

    // 激活目标 App
    let success = app.activate(options: .activateIgnoringOtherApps)
    NSLog("[Paste] → Activation success: \(success)")

    // 增加延迟到 0.3s，确保目标 App 的 UI 线程完成切换并获取焦点
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
      self?.sendCmdV(completion: completion)
      // 粘贴完成后清除引用，防止持有已终止的 App
      self?.savedFrontmostApp = nil
    }
  }

  /// 使用 NSAppleScript 发送 Cmd+V（高层模拟，兼容性极高）
  func sendCmdV(completion: @escaping () -> Void) {
    let scriptSource = """
    tell application "System Events"
        keystroke "v" using command down
    end tell
    """
    if let script = NSAppleScript(source: scriptSource) {
      var errorDict: NSDictionary? = nil
      script.executeAndReturnError(&errorDict)
      if let err = errorDict {
        NSLog("[Paste] AppleScript Cmd+V failed: \(err)")
      } else {
        NSLog("[Paste] Cmd+V sent successfully via AppleScript")
      }
    }
    completion()
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  // 点击 Dock 图标时显式发送打开大盘面板的指令
  override func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
    // 延迟 100 毫秒处理，确保 Fn 的 flagsChanged 事件能被先处理并标记 isFnKeyDown
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
      guard let self = self else { return }

      let timeSinceLastFn = Date().timeIntervalSince(self.lastFnActivityTime)
      // 如果正在录音（Fn 键按住），或者在过去 1.5 秒内刚刚操作过 Fn 键（短按防抖），
      // 则坚决不触发 show_dashboard，防止应用因为被系统突然唤醒而错误弹出主面板。
      if self.isFnKeyDown || timeSinceLastFn < 1.5 {
        NSLog("[Reopen] Ignored: Fn key is down or recently pressed (%.2fs ago)", timeSinceLastFn)
        return
      }

      // 🔓 Dashboard 模式：恢复窗口激活能力
      MainFlutterWindow.allowActivation = true
      self.fnKeyChannel?.invokeMethod("show_dashboard", arguments: nil)
    }
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  deinit {
    if let monitor = globalMonitor {
      NSEvent.removeMonitor(monitor)
    }
    if let monitor = localMonitor {
      NSEvent.removeMonitor(monitor)
    }
  }
}
