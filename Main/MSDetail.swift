//
//  MSDetail.swift
//
//
//  Created by Vincent Chiang on 2024/2/17.
//

import SwiftUI
import SwiftData

struct Detail: View {
    @Environment(\.dismiss) private var dismiss
    @State var ms: MileStone
    @State var task: String = ""
    let color: [Color] = [.gray, .blue, .green]
    let type = ["Not started", "In progress", "Done"]
    @Environment(\.modelContext) private var context
    @State var shownotice: Bool = false
    var notUnique: Bool {
        ms.tasks.contains(where: { $0.name == task })
    }
    var body: some View{
        let total = ms.tasks.filter({$0.isCompleted == true || $0.isCompleted == false}).count
        let iscompleted = ms.tasks.filter({$0.isCompleted == true}).count
        NavigationView{
            List{
                Section{
                    VStack(alignment: .leading){
                        HStack{
                            Text(ms.detail)
                            Spacer()
                            Text(type[ms.status])
                                .foregroundStyle(color[ms.status])
                                .bold()
                        }
                        
                         Text("Progress:")
                         let pregress = Double(iscompleted/max(total,1))
                         ProgressView(value: pregress)
                         
                        
                    }.listRowBackground(Color(white: 1, opacity: 0.4))
                }
                Section{
                    HStack{
                        TextField("Task", text: $task)
                        Spacer()
                        Button(action:{
                            save()
                            ms.updateStatus()
                        }){
                            Text("Add")
                        }
                    }
                    ForEach(ms.tasks){index in
                        HStack{
                            Button(action:{
                                    index.isCompleted.toggle()
                                ms.updateStatus()

                            }){
                                TasksRow(task:index)
                            }
                            Text(index.name)
                        }
                    }.onDelete(perform: { indexSet in
                        for index in indexSet {
                            let itemToDelete = ms.tasks[index]
                            context.delete(itemToDelete)
                        }
                    })
                }.listRowBackground(Color(white: 1, opacity: 0.4))
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
            .alert("\(task) already existed", isPresented: $shownotice){
                Button("OK", role: .cancel) {}
            }
        }
    }
    func save(){
        if notUnique{
            shownotice.toggle()
        }else{
            let newtask = Tasks(name: task, isCompleted: false)
            ms.tasks.append(newtask)
            task = ""
        }
    }
}

struct TasksRow: View {
    @State var task: Tasks
    var body: some View {
        ZStack{
            Image(systemName: "circlebadge")
                .font(.system(size: 30))
            if task.isCompleted{
                Image(systemName: "circlebadge.fill")
                    .font(.system(size: 20))
            }
        }
    }
}
