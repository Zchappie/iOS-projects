//
//  EventCountdownApp.swift
//  EventCountdown
//
//  Created by Liu on 15.08.24.
//

import SwiftUI

@main
struct EventCountdownApp: App {
    
    // TODO: using viewModel for Caching
    // TODO: using EnvironmentObject for Caching
    var cacheEvents = InMemoryCache()
    var fileCache = JSONFileManagerCache()
    
    // TODO: using Binding State for Events
    var events = [
        Event(id: .init(), title: "🥳 Birthday", date: .init(), textColor: .red), Event(id: .init(), title: "🏝️ Holiday", date: .init(), textColor: .blue)
    ]
    
    // TODO: load events from the JSONFileManagerCache, and store in InMemoryCache

    var body: some Scene {
        WindowGroup {
            ContentView(events: events)
        }
    }
}
