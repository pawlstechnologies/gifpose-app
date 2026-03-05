import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // Configure Google Maps
    configureGoogleMaps()
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func configureGoogleMaps() {
    GMSServices.provideAPIKey("AIzaSyD0adDCs8YaUAElLHDL19qc114FeDT5Pl8")
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}