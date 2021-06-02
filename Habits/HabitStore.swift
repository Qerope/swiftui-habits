import Foundation
import UserNotifications
import WidgetKit
import UIKit

final class HabitStore: ObservableObject {
    @Published var habits: [Habit] = []
    private let url = FileManager.default
        .containerURL(forSecurityApplicationGroupIdentifier: "group.com.qerope.habits")!
        .appendingPathComponent("habits.json")

    init() {
        load()
        NotificationCenter.default.addObserver(
            forName: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
            object: nil, queue: .main) { [weak self] _ in self?.pullFromCloud() }
        NSUbiquitousKeyValueStore.default.synchronize()
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
        WidgetCenter.shared.reloadAllTimelines()
        if let data = try? JSONEncoder().encode(habits) {
            NSUbiquitousKeyValueStore.default.set(data, forKey: "habits")
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
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
        save()
    }

    func delete(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
        save()
    }

    func scheduleReminder(for habit: Habit, hour: Int) {
        var comps = DateComponents()
        comps.hour = hour
        let content = UNMutableNotificationContent()
        content.title = habit.name
        content.body = "Not done yet today"
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
        UNUserNotificationCenter.current().add(
            UNNotificationRequest(identifier: habit.id.uuidString, content: content, trigger: trigger))
    }

    private func pullFromCloud() {
        guard let data = NSUbiquitousKeyValueStore.default.data(forKey: "habits"),
              let remote = try? JSONDecoder().decode([Habit].self, from: data) else { return }
        habits = remote
        save()
    }
}
