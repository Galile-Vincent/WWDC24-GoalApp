//
//  SplashScreen.swift
//
//
//  Created by Vincent Chiang on 2024/2/18.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack{
            Color.orange
                .ignoresSafeArea(.all)
            
            Image("icon")
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 250)
        }
    }
}
