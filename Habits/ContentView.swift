import SwiftUI

struct ContentView: View {
    @State private var showingAdd = false
    @State private var newName = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(store.habits) { habit in
                    Text(habit.name)
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
