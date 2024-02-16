//
//  HomePage.swift
//
//
//  Created by Vincent Chiang on 2024/2/16.
//

import SwiftUI

struct HomePage: View {
    @Environment(\.modelContext) private var context
    @AppStorage ("isOnBoarding") var isOnBoarding: Bool = true
    @EnvironmentObject var login: Login
    @State var user: UserData
    var body: some View {
        Text("Welcome\(user.username)")
            .onTapGesture(perform: {
                reset()
                
            })
        
        List{
            ForEach(user.quotes, id: \.self){quote in
                Text(quote)
            }
        }
    }
    private func reset(){
        do {
            try context.delete(model: UserData.self)
        } catch {
            print("Failed to clear all data.")
        }
        isOnBoarding = true
        login.page = 0
    }
}
