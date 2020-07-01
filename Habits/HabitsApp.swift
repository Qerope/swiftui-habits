import SwiftUI

@main
struct HabitsApp: App {
    @StateObject private var store = HabitStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
