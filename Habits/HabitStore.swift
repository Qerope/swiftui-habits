import Foundation

final class HabitStore: ObservableObject {
    @Published var habits: [Habit] = []
    private let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        .appendingPathComponent("habits.json")

    init() {
        load()
    }

    func load() {
        guard let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([Habit].self, from: data) else { return }
        habits = decoded
    }

    func save() {
        if let data = try? JSONEncoder().encode(habits) {
            try? data.write(to: url, options: .atomic)
        }
    }

    func add(_ name: String) {
        habits.append(Habit(name: name))
        save()
    }

    func toggleToday(_ habit: Habit) {
        guard let i = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        let today = Calendar.current.startOfDay(for: Date())
        if habits[i].completions.contains(today) {
            habits[i].completions.remove(today)
        } else {
            habits[i].completions.insert(today)
        }
        save()
    }

    func delete(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
        save()
    }
}
