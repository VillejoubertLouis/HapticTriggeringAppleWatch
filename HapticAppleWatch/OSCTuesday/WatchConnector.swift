//
//  WatchConnector.swift
//  OSCTuesday
//
//  Created by Louis Villejoubert on 24/07/2024.
//

import Foundation
import WatchConnectivity
import Combine

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
    
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    
    func sendMessageToWatch(message: String) {
        if session.activationState == .activated {
            if session.isReachable {
                session.sendMessage(["message": message], replyHandler: nil, errorHandler: { error in
                    print("Error sending message to watch: \(error)")
                })
            } else {
                print("Watch session is not reachable")
            }
        } else {
            print("WCSession is not activated")
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async {
            self.receivedMessage = message["message"] as? String ?? ""
            print("Received message > " + self.receivedMessage)
            UserDefaults.standard.set(self.receivedMessage, forKey: "message")
        }
    }
}
