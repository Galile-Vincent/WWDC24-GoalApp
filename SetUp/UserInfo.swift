//
//  UserInfo.swift
//
//
//  Created by Vincent Chiang on 2024/2/16.
//

import SwiftUI
import SwiftData

struct UserInfo: View {
    @Environment(\.modelContext) private var context
    @AppStorage ("isOnBoarding") var isOnBoarding: Bool = true
    @EnvironmentObject var login: Login
    @FocusState var isInputActive: Bool
    @State var username: String = ""
    @State var quote: String = ""
    var quotes = [String]()
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("What's your Name?")
                    .font(.title)
                    .bold()
                TextField("Name", text: $username)
                    .textFieldStyle(CustomTextFieldStyle())
                
                Text("What's your Favorite Quotes?")
                    .font(.title)
                    .bold()
                List{
                    TextField("Quote", text: $quote)
                    ForEach(quotes, id: \.self){quote in
                        Text(quote)
                    }
                    Button(action:{
                        quotes.append(quote) // Use self to refer to the struct's properties
                        quote = "" // Resetting the quote variable to an empty string after appending
                    }){
                        Text("+ Add new")
                    }

                }
                .focused($isInputActive)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button("Done") {
                            isInputActive = false
                        }
                    }
                }
                .onTapGesture {
                    hideKeyboard()
                }
            }
            Spacer()
            ZStack{
                Button(action: {
                    save()
                    isOnBoarding = false
                }){
                    Text("Next")
                        .frame(width: 150, height: 50) // Set the frame to create a square button
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.bottom,50)
                }
            }
            
        }.padding()
    }
    private func save() {
        let newUser = UserData(username: username, quotes: quotes)
        context.insert(newUser)
    }
}
