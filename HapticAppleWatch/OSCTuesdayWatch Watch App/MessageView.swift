//
//  MessageView.swift
//  OSCTuesdayWatch Watch App
//
//  Created by Louis Villejoubert on 24/07/2024.
//

import SwiftUI

struct MessageView: View {
    @State private var message: String = "Waiting for messages..."

    var body: some View {
        VStack {
            Text(message)
                .padding()
                .multilineTextAlignment(.center)
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("NewMessageReceived"), object: nil, queue: .main) { notification in
                if let newMessage = notification.userInfo?["message"] as? String {
                    message = newMessage
                }
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MessageView()
                .previewDevice("Apple Watch Series 6 - 44mm")
        }
    }
}
