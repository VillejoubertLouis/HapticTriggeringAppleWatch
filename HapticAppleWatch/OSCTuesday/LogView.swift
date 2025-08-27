//
//  LogView.swift
//  OSCTuesday
//
//  Created by Louis Villejoubert on 24/07/2024.
//

import SwiftUI

struct LogView: View {
    @EnvironmentObject var appDelegate: AppDelegate

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(appDelegate.logs, id: \.self) { log in
                    Text(log)
                        .padding(.vertical, 2)
                }
            }
            .padding()
        }
    }
}
