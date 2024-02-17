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
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                HStack{
                    Text("Detail:")
                        .font(.headline)
                    Spacer()
                }
                Text(ms.detail)
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
