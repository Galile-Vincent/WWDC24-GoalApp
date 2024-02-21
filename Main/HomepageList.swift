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
            do{
                for index in indexSet {
                    let itemToDelete = goal.milestone[index]
                    context.delete(itemToDelete)
                }
                try context.save()
            } catch {
            }
        })
    }
}


struct AllMSList: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State var goal: GoalData
    @State var miles: String = ""
    @State var showdetail: Bool = false
    var body: some View {
        ForEach(goal.milestone) { ms in
            Button(action:{
                showdetail.toggle()
            }){
                ListRow(ms: ms)
            }
            .sheet(isPresented: $showdetail) {
                Detail(ms: ms)
                    .presentationDetents([.medium])
                    .presentationBackground(.thinMaterial)
            }
        }
        .onDelete(perform: { indexSet in
            do{
                for index in indexSet {
                    let itemToDelete = goal.milestone[index]
                    context.delete(itemToDelete)
                }
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
    var body: some View {
        HStack{
            Text(ms.name)
            Spacer()
            Text(type[ms.status])
                .foregroundStyle(color[ms.status])
                .bold()
                .font(.subheadline)
        }
    }
}

struct Detail: View {
    @Environment(\.dismiss) private var dismiss
    @State var ms: MileStone
    @State var task: String = ""
    var body: some View{
        NavigationView{
            List{
                HStack{
                    Text(ms.detail)
                }
                Section{
                    HStack{
                        TextField("Task", text: $task)
                        Spacer()
                        Button(action:{
                            save()
                            task = ""
                        }){
                            Text("Add")
                        }
                    } .listRowBackground(Color(white: 1, opacity: 0.4))
                    ForEach(ms.tasks, id: \.self){task in
                        Text(task)
                    }
                }
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
                }
                .navigationTitle(ms.name)
        }
    }
    func save(){
        ms.tasks.append(task)
    }
}



