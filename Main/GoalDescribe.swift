//
//  GoalDescribe.swift
//
//
//  Created by Vincent Chiang on 2023/12/15.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct GoalDescribe: View {
    @State var goal: GoalData
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(goal.goal)
                    .font(.title2)
                    .bold()
                Spacer()
            }
            Divider()
            Text(goal.goal_describe)

            Spacer()
        }
        .padding(10)
        .frame(minHeight: 150)
        //.background(.ultraThinMaterial)
        //.cornerRadius(10)

    }
}





