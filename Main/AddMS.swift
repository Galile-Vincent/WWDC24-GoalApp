//
//  AddMS.swift
//
//
//  Created by Vincent Chiang on 2024/2/18.
//

import SwiftUI
import SwiftData

struct AddMS: View {
    @State var goal: GoalData
    @Environment(\.dismiss) private var dismiss
    @State var name: String = ""
    @State var detail: String = ""
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section{
                        TextField("Goal Name", text: $name)
                            .listRowBackground(Color(white: 1, opacity: 0.4))
                    }
                    Section{
                        TextField("Detail", text: $detail)
                            .listRowBackground(Color(white: 1, opacity: 0.4))
                    }
                }.padding(.top,10)
                Button(action:{
                    save()
                }){
                    Text("Save")
                }.disabled(name.isEmpty)
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom, 20)
            }
            .scrollContentBackground(.hidden)
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
        .navigationTitle("Add new goal")
        }
    }
    func save(){
        let newms = MileStone(name: name, detail: detail, status: 0, tasks: [])
        goal.milestone.append(newms)
        name = ""
        detail = ""
        dismiss()
    }
}

struct MSRow: View {
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
