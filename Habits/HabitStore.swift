
    func add(_ name: String) {
        habits.append(Habit(name: name))
    }

    func toggleToday(_ habit: Habit) {
        guard let i = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        let today = Calendar.current.startOfDay(for: Date())
        if habits[i].completions.contains(today) {
            habits[i].completions.remove(today)
        } else {
            habits[i].completions.insert(today)
        }
    }

    func delete(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
