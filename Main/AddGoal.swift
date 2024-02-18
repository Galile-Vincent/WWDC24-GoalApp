//
//  AddGoal.swift
//
//
//  Created by Vincent Chiang on 2024/2/17.
//

import SwiftUI
import SwiftData

struct AddGoal: View {
    @Environment(\.dismiss) private var dismiss
    @State var user: UserData
    @State var goal: String = ""
    @State var goal_describe: String = ""
    @State var showedit: Bool = false
    @State var showadd: Bool = false

    var body: some View {
        NavigationView {
            ZStack{
                List {
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
                        
                    } header:{
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
            .foregroundStyle(Color.black)
            .scrollContentBackground(.hidden)
            .background(
                LinearGradient(colors: [.purple, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(.all)
            )
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action:{
                        save()
                        dismiss()
                    }){
                        Text("Save")
                    }
                }
            }
        }
    }

    func save(){
        let newgoal = GoalData(goal: goal, goal_describe: goal_describe)
        user.Goal.append(newgoal)
        goal = ""
        goal_describe = ""
    }
}


