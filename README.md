# Habits

Small habit tracker. SwiftUI, no third party dependencies.

    brew install xcodegen
    xcodegen
    open Habits.xcodeproj
The widget extension reads the same JSON file through the app group
`group.com.qerope.habits`.
Habits sync across devices with iCloud key-value storage (limit 1MB, fine for
a list of habits). Completion history is part of the same payload.
