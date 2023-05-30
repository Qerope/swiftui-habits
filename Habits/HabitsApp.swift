import SwiftUI

@main
struct HabitsApp: App {
    @State private var store = HabitStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(store)
        }
    }
}
