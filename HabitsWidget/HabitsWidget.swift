import SwiftUI
import WidgetKit

struct Entry: TimelineEntry {
    let date: Date
    let habits: [Habit]
}

struct Provider: TimelineProvider {
    private func read() -> [Habit] {
        let url = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.com.qerope.habits")?
            .appendingPathComponent("habits.json")
        guard let url, let data = try? Data(contentsOf: url),
              let habits = try? JSONDecoder().decode([Habit].self, from: data) else { return [] }
        return habits
    }

    func placeholder(in context: Context) -> Entry { Entry(date: Date(), habits: []) }
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        completion(Entry(date: Date(), habits: read()))
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let next = Calendar.current.startOfDay(for: Date()).addingTimeInterval(24 * 3600)
        completion(Timeline(entries: [Entry(date: Date(), habits: read())], policy: .after(next)))
    }
}

struct HabitsWidgetView: View {
    let entry: Entry
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(entry.habits.prefix(4)) { h in
                HStack {
                    Image(systemName: h.isDone(on: entry.date) ? "checkmark.circle.fill" : "circle")
                    Text(h.name).lineLimit(1)
                }
            }
        }
    }
}

@main
struct HabitsWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "HabitsWidget", provider: Provider()) { entry in
            HabitsWidgetView(entry: entry)
        }
        .supportedFamilies([.systemSmall])
    }
}
