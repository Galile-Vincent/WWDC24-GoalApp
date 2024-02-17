//
//  AddGoal.swift
//
//
//  Created by Vincent Chiang on 2024/2/17.
//

import SwiftUI
import SwiftData

struct AddGoal: View {
    @State var user: UserData
    @State var goal: String = ""
    @State var goal_describe: String = ""
    @State private var animateGradient = false
    var body: some View {
        ZStack{
            List{
                Section{
                    VStack(alignment: .leading){
                        HStack{
                            TextField("Goal", text: $goal)
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        Divider()
                        TextField("Detail",text: $goal_describe)
                        
                        Spacer()
                    }
                    .padding(10)
                    .frame(minHeight: 150)
                    .listRowBackground(Color(white: 1, opacity: 0.3))
                }
                Section{
                    //add middlegoal
                    //.listRowBackground(Color(white: 1, opacity: 0.3))
                    
                }header:{
                    Text("Middle Goal")
                        .font(.headline)
                }
            }
            Button(action: {
                withAnimation{
                    save()
                }
            }){
                Text("Add")
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
    func save(){
        let newgoal = GoalData(goal: goal, goal_describe: goal_describe)
        user.Goal.append(newgoal)
        goal = ""
        goal_describe = ""
    }
}
