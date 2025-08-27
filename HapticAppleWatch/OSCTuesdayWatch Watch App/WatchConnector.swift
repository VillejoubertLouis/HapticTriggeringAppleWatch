import Foundation
import WatchConnectivity
import Combine
import WatchKit

class WatchConnector: NSObject, WCSessionDelegate, ObservableObject {
    
    var session: WCSession
    @Published var receivedMessage = ""
    
    init(session: WCSession = .default){
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("WCSession activation failed with error: \(error.localizedDescription)")
        } else {
            print("WCSession activated with state: \(activationState.rawValue)")
        }
    }
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
          DispatchQueue.main.async {
              self.receivedMessage = message["message"] as? String ?? ""
              print("Received message > " + self.receivedMessage)
              UserDefaults.standard.set(self.receivedMessage, forKey: "message")
              
              // Trigger haptic feedback based on message content
              switch self.receivedMessage {
              case "notification":
                  WKInterfaceDevice.current().play(.notification)
              case "up":
                  WKInterfaceDevice.current().play(.directionUp)
              case "down":
                  WKInterfaceDevice.current().play(.directionDown)
              case "success":
                  WKInterfaceDevice.current().play(.success)
              case "failure":
                  WKInterfaceDevice.current().play(.failure)
              case "retry":
                  WKInterfaceDevice.current().play(.retry)
              case "start":
                  WKInterfaceDevice.current().play(.start)
              case "stop":
                  WKInterfaceDevice.current().play(.stop)
              case "click":
                  WKInterfaceDevice.current().play(.click)
              default:
                  WKInterfaceDevice.current().play(.notification)
              }
          }
      }
  }
