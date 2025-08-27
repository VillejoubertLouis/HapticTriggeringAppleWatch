import WatchKit
import WatchConnectivity

class NotificationController: WKUserNotificationInterfaceController, WCSessionDelegate {

    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    // Required WCSessionDelegate method
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("WCSession activation failed with error: \(error.localizedDescription)")
        } else {
            print("WCSession activated with state: \(activationState.rawValue)")
        }
    }
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        if session.isReachable {
            print("Watch session is reachable")
        } else {
            print("Watch session is not reachable")
        }
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let newMessage = message["message"] as? String {
            NotificationCenter.default.post(name: NSNotification.Name("NewMessageReceived"), object: nil, userInfo: ["message": newMessage])
            print("Received message: \(newMessage)")
        }
    }
}
