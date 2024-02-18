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
    @State private var animateGradient = false
    @State var showedit: Bool = false
    @State var showadd: Bool = false
    var body: some View {
        ZStack(alignment: .bottom){
            List{
                ForEach(user.Goal){goal in
                    Section{
                        GoalDescribeGrid(goal: goal)
                            .listRowBackground(Color(white: 1, opacity: 0.3))
                    }
                }
            }
            Section{
                HStack{
                    Spacer()
                    NavigationLink(destination: AddGoal(user: user)){
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 50))
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
                .hueRotation(.degrees(animateGradient ? 45 : 0))
                .ignoresSafeArea(.all)
                .onAppear {
                    withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
        )
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
        .navigationTitle("\(user.username)'s Goal")
        
        .sheet(isPresented: $showadd) {
            //MiddleGoals(goal: GoalData)
        }
        .sheet(isPresented: $showedit) {
            //EditView(user: user)
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
