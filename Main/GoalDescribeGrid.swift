//
//  GoalDescribeGrid.swift
//
//
//  Created by Vincent Chiang on 2024/2/18.
//

import SwiftUI
import SwiftData

struct GoalDescribeGrid: View {
    @State var goal: GoalData

    var body: some View {
        let milestones = goal.milestone
        let totalMilestones = milestones.count
        let notStartedMilestones = milestones.filter { $0.status == 0 }.count
        let inProgressMilestones = milestones.filter { $0.status == 1 }.count
        let completedMilestones = milestones.filter { $0.status == 2 }.count
        
        let progress = Double(completedMilestones / max(totalMilestones, 1))
        NavigationLink(destination: GoalPage(goal: goal)) {
            VStack(alignment: .leading) {
                HStack{
                    Text(goal.goal)
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                Divider()
                    .padding(.bottom)
                HStack {
                    VStack(alignment: .leading) {
                        ZStack {
                            Circle()
                                .stroke(
                                    Color.pink.opacity(0.5),
                                    lineWidth: 13
                                )
                            Circle()
                            // 2
                                .trim(from: 0, to: progress)
                                .stroke(
                                    Color.pink,
                                    style: StrokeStyle(
                                        lineWidth: 13,
                                        lineCap: .round
                                    )
                                )
                                .rotationEffect(.degrees(-90))
                            VStack{
                                Text("\(completedMilestones)")
                                Text("\(totalMilestones)")
                            }
                        }.frame(width: 100, height: 100)
                    }
                    Divider()
                        .padding()
                    VStack(alignment: .leading) {
                        Text("Total: \(totalMilestones)")
                        Text("Not Started: \(notStartedMilestones)")
                        Text("In Progress: \(inProgressMilestones)")
                    }
                }
                Spacer()
            }
            .padding(10)
            .frame(minHeight: 150)
        }
    }
}


/*
struct CircularProgressView: View {
    @State var goal: GoalData
    @State var circleframe: CGFloat
    @State var  total: Int
    @State var completed: Int
    @State var progress: Double
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.pink.opacity(0.5),
                    lineWidth: 13
                )
            Circle()
            // 2
                .trim(from: 0, to: progress)
                .stroke(
                    Color.pink,
                    style: StrokeStyle(
                        lineWidth: 13,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
            VStack{
                Text("\(completed)")
                Text("\(total)")
            }
        }.frame(width: circleframe, height: circleframe)
    }
}
*/
