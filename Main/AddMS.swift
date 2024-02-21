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
            List{
                Section{
                    TextField("Goal Name", text: $name)
                }
                Section{
                    TextField("Detail", text: $detail)
                }
            }.toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button(action:{
                        dismiss()
                    }){
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button(action:{
                        save()
                    }){
                        Text("Save")
                    }
                }
            }
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
