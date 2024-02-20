//
//  MiddleGoals.swift
//
//
//  Created by Vincent Chiang on 2023/11/29.
//

import SwiftUI
import SwiftData

struct MiddleGoals: View {
    @Environment(\.dismiss) private var dismiss
    @State var goalname: String = ""
    @State var detail: String = ""
    @State var goal: GoalData
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Text("In order to complete your final goal, what do you think you should do or reach.")
                        .font(.headline)
                }
                TextField("Goal", text: $goalname)
                TextField("Detail", text: $detail)
            }.toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let ml = MileStone(name: goalname, detail: detail, status: 0)
                        goal.milestone.append(ml)
                        dismiss()
                    }.disabled(goalname.isEmpty)
                }
            }
        }
        .navigationTitle("Middle Goal")
    }
}
