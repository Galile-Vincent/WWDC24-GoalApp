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
    @State var shownotice: Bool = false
    var notUnique: Bool {
        user.Goal.contains(where: { $0.goal == goal })
    }
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    Section{
                        TextField("Goal", text: $goal)
                            .listRowBackground(Color(white: 1, opacity: 0.4))
                    }
                    Section{
                        TextField("Detail", text: $goal_describe)
                            .listRowBackground(Color(white: 1, opacity: 0.4))
                    }
                }.padding(.top, 10)
                Button(action:{
                    save()
                }){
                    Text("Save")
                }.disabled(goal.isEmpty)
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom, 20)
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        dismiss()
                    }){
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.black.opacity(0.4))
                    }
                }
            }.alert("\(goal) already existed", isPresented: $shownotice){
                Button("OK", role: .cancel) {}
            }
            .navigationTitle("Add Goal")
        }            .scrollContentBackground(.hidden)
    }

    func save(){
        if notUnique{
            shownotice = true
        }else{
            let newgoal = GoalData(goal: goal, goal_describe: goal_describe)
            user.Goal.append(newgoal)
            goal = ""
            goal_describe = ""
            dismiss()
        }
    }
}


