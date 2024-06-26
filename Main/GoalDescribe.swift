//
//  GoalDescribe.swift
//
//
//  Created by Vincent Chiang on 2023/12/15.
//

import SwiftUI
import SwiftData

struct GoalDescribe: View {
    @Binding var goal: GoalData
    var body: some View {
        let milestones = goal.milestone
        let totalMilestones = milestones.count
        let notStartedMilestones = milestones.filter { $0.status == 0 }.count
        let inProgressMilestones = milestones.filter { $0.status == 1 }.count
        let completedMilestones = milestones.filter { $0.status == 2 }.count
        VStack(alignment: .leading){
            Text("Detail:")
                .bold()
            if goal.goal_describe.isEmpty{
                Text("Add detail of your goal in edit.")
            }else{
                Text(goal.goal_describe)
            }
            Divider()
                .padding(.bottom)
            HStack{
                VStack(alignment: .leading){
                    ZStack {
                        Circle()
                            .stroke(
                                Color.pink.opacity(0.5),
                                lineWidth: 13
                            )
                        Circle()
                        // 2
                            .trim(from: 0, to: Double(completedMilestones / max(totalMilestones, 1)))
                            .stroke(
                                Color.pink,
                                style: StrokeStyle(
                                    lineWidth: 13,
                                    lineCap: .round
                                )
                            )
                            .rotationEffect(.degrees(-90))
                        let progressText = String(format: "%.0f%%", Double(completedMilestones / max(totalMilestones, 1)) * 100)
                        Text(progressText)
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                            .foregroundStyle(Color(.systemGray))
                    }.frame(width: 100, height: 100)
                }
                Divider()
                    .padding()
                VStack(alignment: .leading){
                    Text("Total: \(totalMilestones)")
                    Text("Not Started: \(notStartedMilestones)")
                    Text("In Progress: \(inProgressMilestones)")
                }
            }
        }
        .padding(10)
        .frame(minHeight: 150)
        //.background(.ultraThinMaterial)
        //.cornerRadius(10)
        
    }
}





