import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appDelegate: AppDelegate

    var body: some View {
        VStack(spacing: 0) {
            // Top half button for "START"
            Button(action: {
                appDelegate.sendTestOSCMessage(messageValue: "start")
            }) {
                Text("STRONG HAPTIC")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(0)
            }

            // Bottom half button for "CLICK"
            Button(action: {
                appDelegate.sendTestOSCMessage(messageValue: "click")
            }) {
                Text("SOFT HAPTIC")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(0)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppDelegate())
    }
}

