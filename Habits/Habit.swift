import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var completions: Set<Date> = []
    var archived = false

    func isDone(on day: Date, calendar: Calendar = .current) -> Bool {
        completions.contains(calendar.startOfDay(for: day))
    }

    func streak(asOf today: Date = Date(), calendar: Calendar = .current) -> Int {
        var day = calendar.startOfDay(for: today)
        // today not being done yet should not break yesterday's streak
        if !completions.contains(day) {
            day = calendar.date(byAdding: .day, value: -1, to: day)!
        }
        var count = 0
        while completions.contains(day) {
            count += 1
            day = calendar.date(byAdding: .day, value: -1, to: day)!
        }
        return count
    }
}
