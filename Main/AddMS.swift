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
    var body: some View {
        Section{
            ForEach(goal.milestone){ms in
                MSRow(ms: ms)
            }
        }
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
            Text(type[ms.status?.rawValue ?? 0])
                .foregroundStyle(color[ms.status?.rawValue ?? 0])
                .bold()
                .font(.subheadline)
        }
    }
}
