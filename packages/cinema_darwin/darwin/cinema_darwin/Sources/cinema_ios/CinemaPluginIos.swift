import AVFoundation
import Flutter
import UIKit

public class CinemaPluginIos: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = CinemaPluginIos()

    let avPlayerViewFactory = CinemaAVPlayerViewFactory(messenger: registrar.messenger())
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
    withFrame frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?
  ) -> FlutterPlatformView {
    return CinemaAVPlayerView(
      frame: frame,
      viewIdentifier: viewId,
      arguments: args,
      messenger: messenger
    )
  }

  public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
    return FlutterStandardMessageCodec.sharedInstance()
  }
}

class CinemaAVPlayerView: NSObject, FlutterPlatformView {
  private var _view: PlayerView

  init(
    frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?,
    binaryMessenger messenger: FlutterBinaryMessenger?
  ) {
    _view = PlayerView()
    super.init()

    createNativeView(view: _view, args: args)
  }

  func view() -> UIView {
    return _view
  }

  func createNativeView(view _view: PlayerView, args: Any?) {
    // Prepare view
    _view.backgroundColor = .black
    _view.clipsToBounds = true
    _view.layer.masksToBounds = true

    // Args is a pointer to AVPlayer. Unsafely unwrap it.
    //
    // This is a bit sketch, but it'll work fine if handled carefully.
    let pointer = UnsafeRawPointer(bitPattern: args as! Int)
    let player = Unmanaged<AVPlayer>.fromOpaque(pointer!).takeUnretainedValue()

    // Create player layer
    let playerLayer = AVPlayerLayer(player: player)
    playerLayer.videoGravity = .resizeAspect
    playerLayer.frame = _view.bounds

    // Add player layer to view
    _view.layer.addSublayer(playerLayer)
    _view.playerLayer = playerLayer
  }
}

class PlayerView: UIView {
  var playerLayer: AVPlayerLayer?

  override func layoutSubviews() {
    super.layoutSubviews()
    playerLayer?.frame = bounds
  }

  override func removeFromSuperview() {
    super.removeFromSuperview()
    playerLayer = nil
  }
}
