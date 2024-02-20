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
                    }
                    Section{
                        //add middlegoal
                        //.listRowBackground(Color(white: 1, opacity: 0.3))
                        
                    } header:{
                        Text("Middle Goal")
                            .font(.headline)
                    }
                }
            }
            .foregroundStyle(Color.black)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action:{
                        save()
                    }){
                        Text("Done")
                    }.disabled(goal.isEmpty)
                }
            }.alert("\(goal) already existed", isPresented: $shownotice){
                Button("OK", role: .cancel) {}
                }
        }
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


