import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var completions: Set<Date> = []

    func isDone(on day: Date, calendar: Calendar = .current) -> Bool {
        completions.contains(calendar.startOfDay(for: day))
    }
}
