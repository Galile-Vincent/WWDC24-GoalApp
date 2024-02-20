//
//  Home.swift
//
//
//  Created by Vincent Chiang on 2024/2/18.
//

import SwiftUI
import SwiftData

struct Home: View {
    @State var user: UserData
    @State var showadd: Bool = false
    @State private var refreshFlag = UUID()
    var body: some View {
        ZStack(alignment: .bottom){
            if user.Goal.isEmpty{
                HomePageEmpty()
            }else{
                let goal = user.Goal
                List {
                    ForEach(goal) { index in
                        Section {
                            GoalDescribeGrid(goal: index)
                                .foregroundStyle(Color.black)
                                .listRowBackground(Color(white: 1, opacity: 0.3))
                        }
                    }
                    .onDelete { indexSet in
                        // Perform delete operation here
                        user.Goal.remove(atOffsets: indexSet)
                    }
                    .id(refreshFlag)
                }
                
            }
            Section{
                HStack{
                    Spacer()
                    Button(action:{
                        showadd = true
                    }){
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 70))
                            .foregroundStyle(Color.orange)
                        
                    }
                    Spacer()
                }.background(
                    LinearGradient(colors: [.clear ,.white], startPoint: .top, endPoint: .bottom)
                        .blur(radius: 30)
                        .ignoresSafeArea()
                )
            }
        }
        .scrollContentBackground(.hidden)
        .background(
            LinearGradient(colors: [.purple, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)
        )
        .navigationTitle("Goal")
        
        .sheet(isPresented: $showadd) {
            AddGoal(user: user)
        }
    }
}

/*
 private func reset(){
     do {
         try context.delete(model: UserData.self)
     } catch {
         print("Failed to clear all data.")
     }
     isOnBoarding = true
     login.page = 0
 }
 */
