
    func add(_ name: String) {
        habits.append(Habit(name: name))
    }

    func delete(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
