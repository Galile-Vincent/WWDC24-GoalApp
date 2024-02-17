//
//  HomePage.swift
//
//
//  Created by Vincent Chiang on 2024/2/16.
//

import SwiftUI
import SwiftData

struct HomePage: View {
    @EnvironmentObject var login: Login
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    //@Query var goals: [GoalData]
    @State var goal: GoalData
    @State private var animateGradient = false
    @State var steps: String = ""
    var body: some View {
        List{
            Section{
                GoalDescribe(goal: goal)
                    .listRowBackground(Color(white: 1, opacity: 0.3))
            }
            Section{
                if login.status == 0{
                    AllMSList(goal: goal)
                        .listRowBackground(Color(white: 1, opacity: 0.3))
                }
                else if goal.milestone.filter({ $0.status?.rawValue ?? 10 == login.status-1 }).isEmpty{
                    ContentUnavailableView {
                        Text("Currently Empty")
                            .bold()
                            .foregroundStyle(Color.secondary)
                    }
                    .listRowBackground(Color(white: 1, opacity: 0))
                }
                else{
                    HomepageList(goal: goal)
                        .listRowBackground(Color(white: 1, opacity: 0.3))
                }
            }header:{
                HStack{
                    Text("Middle Goal")
                        .font(.headline)
                    Spacer()
                    
                    Picker("Status", selection: $login.status) {
                        Text("All")
                            .tag(0)
                        Text("Not started")
                            .tag(1)
                        Text("Planning")
                            .tag(2)
                        Text("In progress")
                            .tag(3)
                        Text("Finished")
                            .tag(4)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(
            LinearGradient(colors: [.purple, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                .hueRotation(.degrees(animateGradient ? 45 : 0))
                .ignoresSafeArea(.all)
                .onAppear {
                    withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
        )
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


struct Home: View {
    @State var user: UserData
    @State var showedit: Bool = false
    @State var showadd: Bool = false
    var body: some View {
        VStack{
            if user.Goal.isEmpty{
                AddGoal(user: user)
            }else{
                if let firstUser = user.Goal.first {
                    HomePage(goal: firstUser)
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showedit.toggle()
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Add") {
                    showadd.toggle()
                }
            }
        }
        .navigationTitle("\(user.username)'s Goal \(user.Goal.count)")
        .sheet(isPresented: $showadd) {
            //MiddleGoals(goal: GoalData)
        }
        .sheet(isPresented: $showedit) {
            //EditView(user: user)
        }
    }
}
