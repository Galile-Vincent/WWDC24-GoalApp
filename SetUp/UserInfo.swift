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
    @Query var quotes: [Quotes]
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
                TextField("Quote", text: $quote)
                Button(action:{
                    savequote()
                }){
                    Text("Add new")
                }
                List{
                    ForEach(quotes){ quote in
                        Text(quote.quote)
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
                    saveuser()
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
    private func saveuser() {
        let newUser = UserData(username: username, Quote: quotes)
        context.insert(newUser)
    }
    private func savequote() {
        let newquote = Quotes(quote: quote)
        context.insert(newquote)
        quote = ""
    }

}
