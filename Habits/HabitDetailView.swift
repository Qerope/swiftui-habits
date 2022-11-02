import SwiftUI
import Charts

struct HabitDetailView: View {
    let habit: Habit

    private var week: [Date] {
        let cal = Calendar.current
        let start = cal.dateInterval(of: .weekOfYear, for: Date())!.start
        return (0..<7).map { cal.date(byAdding: .day, value: $0, to: start)! }
    }

    var body: some View {
        VStack {
            HStack {
                ForEach(week, id: \.self) { day in
                    VStack {
                        Text(day, format: .dateTime.weekday(.narrow))
                        Image(systemName: habit.isDone(on: day) ? "circle.fill" : "circle")
                    }
                }
            }
            Chart(last30, id: \.0) { day, done in
                BarMark(x: .value("Day", day, unit: .day), y: .value("Done", done ? 1 : 0))
            }
            .frame(height: 120)
        }
        .navigationTitle(habit.name)
    }

    private var last30: [(Date, Bool)] {
        (0..<30).reversed().map { offset in
            let d = Calendar.current.date(byAdding: .day, value: -offset, to: Date())!
            return (Calendar.current.startOfDay(for: d), habit.isDone(on: d))
        }
    }
}
