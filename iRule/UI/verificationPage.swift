//
//  verificationPage.swift
//  iRule
//
//  Created by user1 on 17/12/23.
//

import SwiftUI
import LocalAuthentication

struct verificationPage: View {
    
    @Binding var mainPageState: String
    
    @State private var success = false
    @State private var status = "Checking"
    
    let backgroundGradient = LinearGradient(gradient: Gradient(colors: [Color.gray, Color.teal, Color.cyan, Color.indigo, Color.blue]),startPoint: .topTrailing, endPoint: .bottom)
    
    func authenticate(){
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "This is a security check reason.") { success, authenticationError in
                
                if success {
                    status = "UNLOCKED"
                    mainPageState = "Poll"
                } else {
                    status = "There was a problem!"
                }
            }
        } else {
            status = "Phone does not have biometrics"
        }
    }
    
    var body: some View {
        ZStack{
            backgroundGradient.ignoresSafeArea(.all)
            VStack{
                Text(status)
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
            }
        }
        .task {
            authenticate()
        }
    }
}
