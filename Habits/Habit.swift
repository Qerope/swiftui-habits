import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var completions: Set<Date> = []

    func isDone(on day: Date, calendar: Calendar = .current) -> Bool {
        completions.contains(calendar.startOfDay(for: day))
    }

    func streak(asOf today: Date = Date(), calendar: Calendar = .current) -> Int {
        var day = calendar.startOfDay(for: today)
        var count = 0
        while completions.contains(day) {
            count += 1
            day = calendar.date(byAdding: .day, value: -1, to: day)!
        }
        return count
    }
}
