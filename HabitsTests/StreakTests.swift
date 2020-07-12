import XCTest
@testable import Habits

final class StreakTests: XCTestCase {
    private let cal = Calendar(identifier: .gregorian)

    private func day(_ offset: Int, from base: Date) -> Date {
        cal.startOfDay(for: cal.date(byAdding: .day, value: offset, to: base)!)
    }

    func testEmptyIsZero() {
        XCTAssertEqual(Habit(name: "x").streak(), 0)
    }

    func testConsecutiveDays() {
        let today = Date()
        var h = Habit(name: "x")
        h.completions = [day(0, from: today), day(-1, from: today), day(-2, from: today)]
        XCTAssertEqual(h.streak(asOf: today), 3)
    }

    func testGapBreaksStreak() {
        let today = Date()
        var h = Habit(name: "x")
        h.completions = [day(0, from: today), day(-2, from: today)]
        XCTAssertEqual(h.streak(asOf: today), 1)
    }

    func testTodayNotDoneKeepsYesterdaysStreak() {
        let today = Date()
        var h = Habit(name: "x")
        h.completions = [day(-1, from: today), day(-2, from: today)]
        XCTAssertEqual(h.streak(asOf: today), 2)
    }
}
