//
//  WelcomePage.swift
//
//
//  Created by Vincent Chiang on 2024/2/16.
//

import SwiftData
import SwiftUI

struct WelcomePage: View {
    @State private var start: Bool = false
    @EnvironmentObject var login: Login
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                
                Image("icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 30)
                
                Text("Unlock Your Potential")
                    .font(.title)
                    .bold()
                
                
                Text("Tired of unfulfilled resolutions?\nWant to finally reach your goals?\nGoal App is here to help!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                VStack(alignment: .leading) {
                    Text("With Goal, you can:")
                        .font(.body)
                        .bold()
                        .padding(.top, 30)
                    
                    Text("- Easily set and track your goals")
                        .font(.body)
                    Text("- Stay motivated by your favorite quotes")
                        .font(.body)
                }.padding(.horizontal, 30)
                
                Button(action: {
                    start = true
                    login.page+=1
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .padding()
                        .background(.thinMaterial)
                        .cornerRadius(10)
                } .sensoryFeedback(.success, trigger: start)
                .padding(.top, 30)
            }.foregroundStyle(.white)
        }
    }
}
