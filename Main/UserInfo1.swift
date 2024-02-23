
 import SwiftUI
 import SwiftData
 
struct UserInfo1 : View {
    @State var user: UserData
    @EnvironmentObject var login: Login
    @Environment(\.modelContext) private var context
    @AppStorage ("isOnBoarding") var isOnBoarding: Bool = true
    @Environment(\.dismiss) private var dismiss
    @State private var isDeleting = false
    @State var username: String = ""
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("User Name", text: $username)
                        .listRowBackground(Color(white: 1, opacity: 0.4))
                }header: {
                    Text("User Name")
                }
                
                Section{
                    ForEach(user.quotes, id: \.self){ quote in
                        Text(quote)
                            .listRowBackground(Color(white: 1, opacity: 0.4))
                    }.onDelete(perform: delete)
                }header: {
                    Text("Quotes")
                }
                Button(action:{
                    isDeleting = true
                }){
                    HStack{
                        Spacer()
                        Text("Reset")
                            .foregroundStyle(.white)
                        Spacer()
                    }
                }.listRowBackground(Color.red)
                    .confirmationDialog("You cannot undo this action", isPresented: $isDeleting, titleVisibility: .visible){
                        Button("Reset", role: .destructive){ reset() }
                        Button("Cancel", role: .cancel){}
                    }message: {
                        Text("Delete this Goal")
                    }
            }.onAppear{
                username = user.username
            }
            .toolbar{
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
                        dismiss()
                    }){
                        Text("Save")
                    }.disabled(username.isEmpty)
                }
            }
            .navigationTitle("User Info")
        }
        .scrollContentBackground(.hidden)
    }
    func reset(){
        do {
            try context.delete(model: UserData.self)
        } catch {
            print("Failed to clear all data.")
        }
        isOnBoarding = true
        login.page = 0
    }
   func save(){
        user.username = username
    }
    func delete(at offsets: IndexSet) {
        user.quotes.remove(atOffsets: offsets)
    }
}
 

