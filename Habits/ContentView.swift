import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: HabitStore
    @State private var showingAdd = false
    @State private var newName = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(store.habits) { habit in
                    Button { store.toggleToday(habit) } label: {
                        HStack {
                            Text(habit.name)
                            Spacer()
                            Text("\(habit.streak())")
                                .foregroundColor(.secondary)
                            if habit.isDone(on: Date()) { Image(systemName: "checkmark.circle.fill") }
                        }
                    }
                }
                .onDelete(perform: store.delete)
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
