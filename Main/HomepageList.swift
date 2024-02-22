//
//  HomepageList.swift
//
//
//  Created by Vincent Chiang on 2023/12/12.
//

import SwiftUI
import SwiftData

struct HomepageList: View {
    @EnvironmentObject var login: Login
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State var goal: GoalData
    var body: some View {
        let goals = goal.milestone.filter({$0.status == login.status - 1})
        ForEach(goals) { goal in
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
    @State var miles: String = ""
    var body: some View {
        let name = goal.goal
        let detail = goal.goal_describe
        ForEach(goal.milestone) { ms in
            ListRow(ms: ms)
        }
        .onDelete(perform: { indexSet in
            do{
                for index in indexSet {
                    let itemToDelete = goal.milestone[index]
                    context.delete(itemToDelete)
                }
                goal.goal = name
                goal.goal_describe = detail
                try context.save()
            } catch {
            }
        })
    }
}


struct ListRow: View {
    @State var ms: MileStone
    let type = ["Not started", "In progress", "Done"]
    let color: [Color] = [.gray, .blue, .green]
    @State var showdetail: Bool = false
    var body: some View {
        Button(action:{
            showdetail = true
        }){
            HStack{
                Text(ms.name)
                Spacer()
                Text(type[ms.status])
                    .foregroundStyle(color[ms.status])
                    .bold()
                    .font(.subheadline)
            }
        }
        .sheet(isPresented: $showdetail) {
            Detail(ms: ms)
                .presentationDetents([.medium, .large])
                .presentationBackground(.thinMaterial)
        }
    }
}




