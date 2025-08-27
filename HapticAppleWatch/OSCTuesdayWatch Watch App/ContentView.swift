//
//  ContentView.swift
//  OSCTuesdayWatch Watch App
//
//  Created by Louis Villejoubert on 24/07/2024.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @ObservedObject var watchConnector = WatchConnector()

    var body: some View {
        VStack {
            Text("Received message:")
                .font(.headline)
            Text(watchConnector.receivedMessage)
                .font(.body)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
