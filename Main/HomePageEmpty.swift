//
//  HomePageEmpty.swift
//
//
//  Created by Vincent Chiang on 2024/2/19.
//

import SwiftUI

struct HomePageEmpty: View {
    @State var user: UserData
    var body: some View {
        VStack(alignment: .center){
            QuoteView(user: user)
                .listRowBackground(Color.black.opacity(0.2))
            Spacer()
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 75, height: 75)
            
            Text("Unlock Your Potential")
                .font(.headline)
                .bold()
                .padding(.top, -10)
                .foregroundStyle(.white)
            
            Text("Set up your life time goals.")
                .font(.callout)
                .foregroundStyle(.thickMaterial)
            Text("Tap the plus button to get started.")
                .font(.callout)
                .foregroundStyle(.thickMaterial)
                .padding(.bottom, 100)
            Spacer()
            
        }
    }

}


