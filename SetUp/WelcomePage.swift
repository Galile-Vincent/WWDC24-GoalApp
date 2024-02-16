//
//  WelcomePage.swift
//
//
//  Created by Vincent Chiang on 2024/2/16.
//

import SwiftData
import SwiftUI

struct WelcomePage: View {
    var body: some View {
        ZStack {
            // Background image or gradient
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                // App logo or icon
                Image("your_app_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 30)
                
                // Headline
                Text("Unlock Your Potential:")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Set and Achieve Your Goals!")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                
                // Body text
                Text("Tired of unfulfilled resolutions? Want to finally reach your goals? [App Name] is here to help!")
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                // Benefits
                Text("With [App Name], you can:")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 30)
                
                VStack(alignment: .leading) {
                    Text("- Easily set and track your goals")
                        .font(.body)
                        .foregroundColor(.white)
                    Text("- Create personalized plans and reminders")
                        .font(.body)
                        .foregroundColor(.white)
                    Text("- Visualize your progress and stay motivated")
                        .font(.body)
                        .foregroundColor(.white)
                }
                
                // Get Started button
                Button(action: {
                    // Handle get started action
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 30)
            }
        }
    }
}
