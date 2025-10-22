import AVFoundation
import Cocoa
import FlutterMacOS

public class CinemaPluginMacOS: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = CinemaPluginMacOS()

    let avPlayerViewFactory = CinemaAVPlayerViewFactory(messenger: registrar.messenger)
    registrar.register(avPlayerViewFactory, withId: "CinemaAVPlayerView")
  }
}

class CinemaAVPlayerViewFactory: NSObject, FlutterPlatformViewFactory {
  private var messenger: FlutterBinaryMessenger

  init(messenger: FlutterBinaryMessenger) {
    self.messenger = messenger
    super.init()
  }

  func create(
    withViewIdentifier viewId: Int64,
    arguments args: Any?
  ) -> NSView {
    return CinemaAVPlayerView(
      viewIdentifier: viewId,
      arguments: args,
      binaryMessenger: messenger
    )
  }

  public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
    return FlutterStandardMessageCodec.sharedInstance()
  }
}

class CinemaAVPlayerView: NSView {
  init(
    viewIdentifier viewId: Int64,
    arguments args: Any?,
    binaryMessenger messenger: FlutterBinaryMessenger?
  ) {
    super.init(frame: .zero)
    wantsLayer = true
    createNativeView(view: self, args: args)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  private var playerLayer: AVPlayerLayer?

  func createNativeView(view _view: NSView, args: Any?) {
    // Prepare view
    _view.wantsLayer = true
    _view.layer?.backgroundColor = NSColor.black.cgColor
    _view.layer?.masksToBounds = true

    // Args is a pointer to AVPlayer. Unsafely unwrap it.
    //
    // This is a bit sketch, but it'll work fine if handled carefully.
    let pointer = UnsafeRawPointer(bitPattern: args as! Int)
    let player = Unmanaged<AVPlayer>.fromOpaque(pointer!).takeUnretainedValue()
    
    // Create AVPlayerLayer
    let playerLayer = AVPlayerLayer(player: player)
    playerLayer.videoGravity = .resizeAspect
    playerLayer.frame = _view.bounds

    // Add player layer to view
    _view.layer?.addSublayer(playerLayer)
    self.playerLayer = playerLayer
  }

  override func layout() {
    super.layout()
    self.playerLayer?.frame = self.bounds
  }
}
