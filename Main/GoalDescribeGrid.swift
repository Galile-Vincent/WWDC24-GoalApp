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
        let progress = Double(Double(goal.DoneMilestoneCount()) / Double(max(goal.totalMilestoneCount(), 1)))
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
                            let progressText = String(format: "%.0f%%", progress * 100)
                            Text(progressText)
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                                .foregroundStyle(Color(.systemGray))
                        }.frame(width: 100, height: 100)
                    }
                    Divider()
                        .padding()
                    VStack(alignment: .leading) {
                        Text("Total: \(goal.totalMilestoneCount())")
                        Text("Not Started: \(goal.NotStartedMilestoneCount())")
                        Text("In Progress: \(goal.inProgressMilestoneCount())")
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
