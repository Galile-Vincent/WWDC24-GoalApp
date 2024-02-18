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
        NavigationLink(destination: GoalPage(goal: goal)){
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
}
