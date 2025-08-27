import UIKit
import OSCKit
import Combine

class AppDelegate: UIResponder, UIApplicationDelegate, ObservableObject {
    var window: UIWindow?
    let oscClient = OSCClient()
    let oscServer = OSCServer(port: 8000)
    let oscReceiver = OSCReceiver()
    let watchConnector = WatchConnector()
    
    @Published var logs: [String] = []

    override init() {
        super.init()
        setupOSCServer()
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        oscServer.stop()
    }
    
    private func setupOSCServer() {
        oscServer.setHandler { [weak self] message, timeTag in
            do {
                try self?.oscReceiver.handle(
                    message: message,
                    timeTag: timeTag
                )
                self?.addLog("Received OSC Message: \(message)")
                if let oscMessage = message as? OSCMessage, let values = oscMessage.values as? [String] {
                    self?.watchConnector.sendMessageToWatch(message: values.first ?? "notification")
                }
            } catch {
                self?.addLog("Error handling message: \(error)")
            }
        }
        
        do {
            try oscServer.start()
            addLog("OSC Server started on port 8000")
        } catch {
            addLog("Error starting OSC Server: \(error)")
        }
    }
    
    func sendTestOSCMessage(messageValue: String) {
        let oscMessage = OSCMessage(
            "/some/address/methodB",
            values: [messageValue]  // Will be "start" or "click"
        )
        
        do {
            try oscClient.send(
                oscMessage,
                to: "localhost", // IP address or hostname
                port: 8000       // standard OSC port but can be changed
            )
            addLog("Sent OSC Message: \(oscMessage)")
            if let values = oscMessage.values as? [String] {
                watchConnector.sendMessageToWatch(message: values.first ?? "notification")
            }
        } catch {
            addLog("Error sending OSC Message: \(error)")
        }
    }
    
    func sendMessageToWatch(message: String) {
        watchConnector.sendMessageToWatch(message: message)
    }
    
    func addLog(_ log: String) {
        DispatchQueue.main.async {
            self.logs.append(log)
        }
    }
}

