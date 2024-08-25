//
//  EventCountdownApp.swift
//  EventCountdown
//
//  Created by Liu on 15.08.24.
//

import SwiftUI

@main
struct EventCountdownApp: App {
    
    // TODO: using EnvironmentObject for Caching
//    @EnvironmentObject var eventsCacheJSON : JSONFileManagerCache
    @StateObject var fileCache = JSONFileManagerCache()
    @State private var events: [Event] = []

    init() {
        if let loadedEvents = fileCache.load() {
            self._events = State(initialValue: loadedEvents)
        } else {
            self._events = State(initialValue: [
                Event(id: .init(), title: "🥳 Birthday", date: .init(), textColor: .red),
                Event(id: .init(), title: "🏝️ Holiday", date: .init(), textColor: .blue)
            ])
        }
    }

    var body: some Scene {
        WindowGroup {
            EventsView(events: events)
                .environmentObject(fileCache)
        }
    }
}


