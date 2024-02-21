//
//  MSDetail.swift
//
//
//  Created by Vincent Chiang on 2024/2/17.
//

import SwiftUI
import SwiftData

struct MSDetail: View {
    @State var ms: MileStone
    @State var taskname: String = ""
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                HStack{
                    Text("Detail:")
                        .font(.headline)
                    Spacer()
                }
                Text(ms.detail)
                List{
                    Section{
                        HStack{
                            TextField("Task", text: $taskname)
                            Spacer()
                            Button(action: {
                                
                            }){
                                Text("Add")
                            }
                        }
                    }
                    
                    Section{
                        ForEach(ms.tasks, id: \.self){task in
                            Text(task)
                        }
                    }
                }
            }.padding(20)
                .navigationTitle(ms.name)
        }.toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    //edit.toggle()
                }
            }
        }
    }
}
