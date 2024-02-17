//
//  HomepageList.swift
//
//
//  Created by Vincent Chiang on 2023/12/12.
//

import SwiftUI
import SwiftData

struct HomepageList: View {
    @EnvironmentObject var data: Login
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State var goal: GoalData
    var body: some View {
        ForEach(goal.milestone.filter { $0.status?.rawValue ?? 10 == data.status-1 }) { goal in
            ListRow(ms: goal)
        }
        .onDelete(perform: { indexSet in
            for index in indexSet {
                let itemToDelete = goal.milestone[index]
                context.delete(itemToDelete)
            }
        })
    }
}


struct AllMSList: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State var goal: GoalData
    var body: some View {
        ForEach(goal.milestone) { ms in
            ListRow(ms: ms)
        }
        .onDelete(perform: { indexSet in
            for index in indexSet {
                let itemToDelete = goal.milestone[index]
                context.delete(itemToDelete)
            }
        })
    }
}


struct ListRow: View {
    @State var ms: MileStone
    let type = ["Not started", "In progress", "Done"]
    let color: [Color] = [.gray, .blue, .green]
    
    var body: some View {
        NavigationLink(destination: MSDetail(ms: ms)){
            HStack{
                Text(ms.name)
                Spacer()
                Text(type[ms.status?.rawValue ?? 0])
                    .foregroundStyle(color[ms.status?.rawValue ?? 0])
                    .bold()
                    .font(.subheadline)
            }
        }
    }
}



