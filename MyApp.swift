import SwiftUI
import SwiftData
import TipKit

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [UserData.self, MileStone.self, GoalData.self], isAutosaveEnabled: true)
                .environmentObject(Login())
                .task {
                    try? Tips.configure([
                        .displayFrequency(.immediate),
                        .datastoreLocation(.applicationDefault)
                    ])
                }
        }
    }
}
