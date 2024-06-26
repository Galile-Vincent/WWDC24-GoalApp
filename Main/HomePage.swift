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
    @Environment(\.dismiss) private var dismiss
    //@Query var goals: [GoalData]
    @State var goal: GoalData
    @State var showedit: Bool = false
    @State var showadd: Bool = false
    @State var steps: String = ""
    var body: some View {
        NavigationStack{
            List{
                Section{
                    GoalDescribe(goal: $goal)
                        .foregroundStyle(Color.black)
                        .listRowBackground(Color(white: 1, opacity: 0.3))
                }
                Section{
                    if login.status == 0{
                        AllMSList(goal: goal)
                            .foregroundStyle(Color.black)
                            .listRowBackground(Color(white: 1, opacity: 0.3))
                    }
                    else if goal.milestone.filter({$0.status == login.status - 1}).isEmpty{
                        ContentUnavailableView {
                            Text("Currently Empty")
                                .bold()
                                .foregroundStyle(Color.secondary)
                        }
                        .listRowBackground(Color(white: 1, opacity: 0))
                        .padding(.top, 50)
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
                        Menu {
                            Button(action: { login.status = 0 }) {
                                HStack{
                                    Text("All")
                                    Spacer()
                                    if login.status == 0{
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                            
                            Button(action: { login.status = 1 }) {
                                HStack{
                                    Text("Not started")
                                    Spacer()
                                    if login.status == 1{
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                            
                            Button(action: { login.status = 2 }) {
                                HStack{
                                    Text("In progress")
                                    Spacer()
                                    if login.status == 2{
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                            
                            Button(action: { login.status = 3 }) {
                                HStack{
                                    Text("Completed")
                                    Spacer()
                                    if login.status == 3{
                                        Image(systemName: "checkmark")
                                    }
                                }
                                
                            }
                            
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                .foregroundStyle(.white.opacity(0.6))
                                .font(.title3)
                        }.padding(.bottom,5)
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
                    }.bold().font(.system(.body, design: .rounded))
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        showadd.toggle()
                    }){
                        HStack{
                            Image(systemName: "plus.circle.fill")
                            Text("Add New")
                                .font(.system(.body, design: .rounded))
                        }.foregroundStyle(.purple)
                            .bold()
                    }.popoverTip(addmstip(), arrowEdge:.top)
                    Spacer()
                }
            }
            .navigationTitle(goal.goal)
            //.navigationTitle("\(goal.user!.username)'s Goal")
            .sheet(isPresented: $showadd) {
                AddMS(goal: goal)
                    .presentationDetents([.medium])
                    .presentationBackground(.thinMaterial)
                
            }
            .sheet(isPresented: $showedit) {
                GoalEdit(goal: goal, onDelete: onDeleteGoal)
            }
        }.accentColor(.orange)
    }
    func onDeleteGoal() {
        dismiss()
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
