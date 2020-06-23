import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            List {
                ForEach(habits) { habit in
                    Text(habit.name)
                }
            }
            .navigationTitle("Habits")
        }
    }
}
