//
//  EventCountdownApp.swift
//  EventCountdown
//
//  Created by Liu on 15.08.24.
//

import SwiftUI

@main
struct EventCountdownApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(events: [
                Event(id: .init(), title: "🥳 Birthday", date: .init(), textColor: .red), Event(id: .init(), title: "🏝️ Holiday", date: .init(), textColor: .blue)
            ])
        }
    }
}
