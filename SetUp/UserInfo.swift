//
//  UserInfo.swift
//
//
//  Created by Vincent Chiang on 2024/2/16.
//

import SwiftUI
import SwiftData

struct Quote: Identifiable {
    let id = UUID()
    let quote: String
}

struct UserInfo: View {
    @Environment(\.modelContext) private var context
    @AppStorage ("isOnBoarding") var isOnBoarding: Bool = true
    @EnvironmentObject var login: Login
    @FocusState var isInputActive: Bool
    @State var defaultQuotesAdded: Bool = false
    @State var username: String = ""
    @State var quote: String = ""
    @State var NotCompleted: Bool = false
    @State var quotes: [Quote] = []
    let defaultquotes = ["The greatest glory in living lies not in never falling, but in rising every time we fall. -Nelson Mandela", "Your time is limited, so don't waste it living someone else's life. Don't be trapped by dogma – which is living with the results of other people's thinking. -Steve Jobs","You must be the change you wish to see in the world. -Mahatma Gandhi"]
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("What's your Name?")
                    .font(.title)
                    .bold()
                VStack(alignment: .leading){
                    TextField("Name", text: $username)
                        .textFieldStyle(CustomTextFieldStyle())
                        .submitLabel(.done)
                    if NotCompleted{
                        HStack{
                            Image(systemName: "exclamationmark.circle.fill")
                            Text("Please Enter Your Name")
                        }.font(.subheadline)
                            .padding(.horizontal)
                            .foregroundStyle(.red)
                    }else{
                        Text("P")
                            .font(.subheadline)
                            .padding(.horizontal)
                            .foregroundStyle(.white)
                    }
                }.padding(.bottom,5)
                
                
                Text("What's your Favorite Quotes?")
                    .font(.title)
                    .bold()
                HStack{
                    TextField("Quote", text: $quote)
                        .submitLabel(.done)
                    Button(action:{
                        quotes.append(Quote(quote: quote))
                        quote = ""
                    }){
                        Text("Add")
                            .bold()
                    }.disabled(quote.isEmpty)
                }
                    .padding(25)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(Color.black, lineWidth: 3)
                    ).padding(.horizontal)
                Button(action:{
                    if !defaultQuotesAdded {
                        for defaultQuote in defaultquotes {
                            quotes.append(Quote(quote: defaultQuote))
                        }
                        defaultQuotesAdded = true
                    }
                }){
                    Text("Add default quotes?")
                        .font(.caption)
                        .bold()
                        .padding(.horizontal)
                }
                List {
                    ForEach(quotes) { quote in
                        Text(quote.quote)
                            .listRowBackground(Color(.systemGray3))
                           
                    }.onDelete(perform: deleteQuote)
                }
            }
            Spacer()
            VStack{
                Text("Next")
                    .frame(width: 150, height: 50) // Set the frame to create a square button
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.bottom,25)
            }.onTapGesture {
                if !username.isEmpty{
                    saveUser()
                    isOnBoarding = false
                }else{
                    NotCompleted = true
                }
            }
        }.padding()
            .scrollContentBackground(.hidden)
            .ignoresSafeArea(.keyboard)
    }
    func saveUser() {
        let quoteStrings = quotes.map { $0.quote } // Extract quotes from Quote struct and convert them to strings
        let newUser = UserData(username: username, quotes: quoteStrings)
        context.insert(newUser)
    }
    func deleteQuote(at offsets: IndexSet) {
            quotes.remove(atOffsets: offsets)
        }
    
}
