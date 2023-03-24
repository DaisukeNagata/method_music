import UIKit
import Flutter
import AVFoundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, AVAudioPlayerDelegate {
    var audioPlayer:AVAudioPlayer?
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let METHOD_CHANNEL_NAME = "com.example.flutter_sound_audio/music"
       
        // FlutterMethodChannel
        let batteryChannel = FlutterMethodChannel(name: METHOD_CHANNEL_NAME, binaryMessenger: controller as! FlutterBinaryMessenger)
        
        batteryChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            self.playAudioFile(path: call.method)
        })
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    
    private func getApplicationSupportFolderPath() -> URL? {
        do {
            let applicationSupportFolder = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            return applicationSupportFolder
        } catch {
            print("Error finding Application Support folder: \(error)")
            return nil
        }
    }
    
    private func playAudioFile(path: String) {
        let path = "\(self.getApplicationSupportFolderPath()!)"+"\(path)"
        guard let url = URL(string: path) else {
                print("Invalid URL")
                return
            }
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        audioPlayer?.delegate = self
        audioPlayer?.play()
    }
    
}
