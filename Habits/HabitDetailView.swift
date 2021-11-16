import SwiftUI

struct HabitDetailView: View {
    let habit: Habit

    private var week: [Date] {
        let cal = Calendar(identifier: .gregorian)
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
        }
        .navigationTitle(habit.name)
    }
}
