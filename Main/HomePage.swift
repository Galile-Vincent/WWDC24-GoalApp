//
//  HomePage.swift
//
//
//  Created by Vincent Chiang on 2024/2/16.
//

import SwiftUI
import SwiftData

struct GoalPage: View {
    @EnvironmentObject var login: Login
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    //@Query var goals: [GoalData]
    @State var goal: GoalData
    @State var showedit: Bool = false
    @State var showadd: Bool = false
    @State var steps: String = ""
    @State private var refreshFlag = UUID()
    var body: some View {
        List{
            Section{
                GoalDescribe(goal: goal)
                    .foregroundStyle(Color.black)
                    .listRowBackground(Color(white: 1, opacity: 0.3))
            }
            Section{
                if login.status == 0{
                    AllMSList(goal: goal)
                        .foregroundStyle(Color.black)
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
                    Text("Short-term Goal")
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
                .ignoresSafeArea(.all)
        )
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showedit.toggle()
                }
            }
        }
        .navigationTitle(goal.goal)
        //.navigationTitle("\(goal.user!.username)'s Goal")
        .sheet(isPresented: $showadd) {
            //MiddleGoals(goal: GoalData)
        }
        .sheet(isPresented: $showedit) {
            GoalEdit(goal: goal, onDelete: onDeleteGoal)
                .onDisappear(perform: refresh)
        }
    }
    func onDeleteGoal() {
        // Navigate back to the home page
        dismiss()
    }
    func refresh() {
        // Change the state variable to trigger refresh
        refreshFlag = UUID()
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
