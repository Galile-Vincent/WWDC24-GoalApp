//
//  QuoteView.swift
//
//
//  Created by Vincent Chiang on 2024/2/23.
//

import SwiftUI
import SwiftData

struct QuoteView: View {
    @State var user: UserData
    @State private var currentIndex = 0
    var body: some View {
                Text("\"\(user.quotes[currentIndex])\"")
                    .font(.system(.title3, design: .serif))
                    .fontWeight(.regular) // Use appropriate font weight
                    .foregroundColor(.black) // Choose an appropriate text color
                    .multilineTextAlignment(.center) // Align the text to the center
                    .padding() // Add padding around the text
                    .cornerRadius(10) // Round the corners of the text container
                    .onAppear {
                // Start the timer when the view appears
                Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
                    // Update the index every minute
                    self.updateIndex()
                }
            }
    }
    func updateIndex() {
        // Get a random index
        let randomIndex = Int.random(in: 0..<user.quotes.count)
        // Set currentIndex to the random index
        currentIndex = randomIndex
    }
}
