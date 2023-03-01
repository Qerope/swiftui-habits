import SwiftUI
import Charts

struct ContentView: View {
    @EnvironmentObject var store: HabitStore
    @State private var showingAdd = false
    @State private var newName = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(store.active) { habit in
                    NavigationLink(destination: HabitDetailView(habit: habit)) {
                        HStack {
                            Text(habit.name)
                            Spacer()
                            Text("\(habit.streak())")
                                .foregroundColor(.secondary)
                        }
                    }
                    .swipeActions {
                        Button("Archive") { store.archive(habit) }.tint(.orange)
                    }
                }
            }
            .navigationTitle("Habits")
            .toolbar {
                Button { showingAdd = true } label: { Image(systemName: "plus") }
            }
            .sheet(isPresented: $showingAdd) {
                Form {
                    TextField("Name", text: $newName)
                    Button("Add") {
                        store.add(newName)
                        newName = ""
                        showingAdd = false
                    }
                }
            }
        }
    }
}
