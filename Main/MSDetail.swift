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
    @State var name: String = ""
    @State var detail: String = ""
    let color: [Color] = [.gray, .blue, .green]
    let type = ["Not started", "In progress", "Completed"]
    @Environment(\.modelContext) private var context
    @State var shownotice: Bool = false
    @State var edit: Bool = false
    var notUnique: Bool {
        ms.tasks.contains(where: { $0.name == task })
    }
    var body: some View{
        let total = ms.tasks.filter({$0.isCompleted == true || $0.isCompleted == false}).count
        let iscompleted = ms.tasks.filter({$0.isCompleted == true}).count
        NavigationView{
            List{
                if edit{
                    Section{
                        TextField("Goal Name", text: $name)
                            .listRowBackground(Color(white: 1, opacity: 0.4))
                    }
                    Section{
                        TextField("Detail", text: $detail)
                            .listRowBackground(Color(white: 1, opacity: 0.4))
                    }.onAppear{
                        name = ms.name
                        detail = ms.detail
                    }
                }else{
                    Section{
                        VStack(alignment: .leading){
                            HStack{
                                Text("Detail:")
                                    .bold()
                                Spacer()
                                Text(type[ms.status])
                                    .foregroundStyle(color[ms.status])
                                    .bold()
                            }
                            
                            Text(ms.detail)
                            
                            Text("Progress:")
                                .bold()
                            let progress = Double(Double(iscompleted)/Double(max(total,1)))
                            VStack{
                                ProgressView(value: progress)
                                    .tint(.purple)
                                HStack{
                                    Spacer()
                                    let progressText = String(format: "%.0f%%", progress * 100)
                                    Text(progressText)
                                        .bold()
                                }
                            }
                            .padding(.bottom, 5)
                            
                            
                        }.listRowBackground(Color(white: 1, opacity: 0.4))
                    }
                }
                Section{
                    HStack{
                        TextField("Task", text: $task)
                        Button(action:{
                            save()
                            ms.updateStatus()
                        }){
                            Text("Add")
                                .foregroundStyle(.blue)
                        }.disabled(task.isEmpty)
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
                if edit{
                    ToolbarItem(placement: .topBarTrailing){
                        Button(action: {
                            update()
                        }){
                            Text("Done")
                                .foregroundStyle(name.isEmpty ? .black.opacity(0.5) : .black)
                                .bold()
                        }.disabled(name.isEmpty)
                    }
                }else{
                    ToolbarItem(placement: .topBarTrailing){
                        Button(action: {
                            dismiss()
                        }){
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.black.opacity(0.4))
                        }
                    }
                }
                if edit{
                    ToolbarItem(placement: .topBarLeading){
                        Button(action: {
                            edit.toggle()
                        }){
                           Text("Cancel")
                        }
                    }
                    
                }else{
                    ToolbarItem(placement: .topBarLeading){
                        Button(action: {
                            edit.toggle()
                        }){
                            Text("Edit")
                        }
                    }
                }
            }
            .navigationTitle(edit ? "Edit" : ms.name)
            
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
    func update(){
        ms.name = name
        ms.detail = detail
        edit.toggle()
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
        }.foregroundStyle(.black)
    }
}

