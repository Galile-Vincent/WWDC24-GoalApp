//
//  GoalEdit.swift
//
//
//  Created by Vincent Chiang on 2024/2/19.
//

import SwiftUI
import SwiftData

struct GoalEdit: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage ("isOnBoarding") var isOnBoarding: Bool = true
    @Environment(\.modelContext) private var context
    @State private var isDeleting = false
    @State var goal: GoalData
    @State var goalname: String = ""
    @State var goaldescribe: String = ""
    var onDelete: () -> Void
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Name", text: $goalname)
                }
                Section{
                    TextField("Detail", text: $goaldescribe)
                }
                Section{
                    Button {
                        isDeleting = true
                    } label: {
                        HStack{
                            Spacer()
                            Text("Delete")
                                .foregroundColor(.white)
                            Spacer()
                        }.padding(.horizontal, 3)
                    }.confirmationDialog("You cannot undo this action", isPresented: $isDeleting, titleVisibility: .visible){
                        Button("Delete", role: .destructive){ delete() }
                        Button("Cancel", role: .cancel){}
                    }message: {
                        Text("Delete this Goal")
                    }
                }.listRowBackground(Color.red)
                
            }.onAppear {
                goalname = goal.goal
                goaldescribe = goal.goal_describe
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        update()
                        dismiss()
                    }.disabled(goalname.isEmpty)
                }
            }
            .navigationTitle("Goal")
            .navigationBarTitleDisplayMode(.inline)
        }
        .interactiveDismissDisabled()
    }
    private func update() {
        goal.goal = goalname
        goal.goal_describe = goaldescribe
    }
    
    private func delete(){
        context.delete(goal)
        onDelete()
    }
}
