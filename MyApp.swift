import SwiftUI
import SwiftData

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [UserData.self, MileStone.self, GoalData.self], isAutosaveEnabled: true)
                .environmentObject(Login())
        }
    }
}
