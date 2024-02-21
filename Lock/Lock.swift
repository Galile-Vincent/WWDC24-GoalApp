import SwiftUI
import Foundation
import LocalAuthentication

struct Lock: View {
    @EnvironmentObject var data: Login
    var body: some View {
        VStack{
            Image(systemName: "lock.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(.purple)
                .padding(.bottom)
            Text("Goal is Locked")
                .font(.title2)
                .bold()
            Text("Use FaceID to View Goal")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom)
            Button("View Goal"){
                authenticate()
            }.foregroundColor(.blue)
                .font(.callout)
        }.padding()
    }
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                if success {
                    self.data.isUnlocked = true
                } else {
                    self.data.isUnlocked = false
                }
            }
        } else {
            // no biometrics
        }
    }
}

