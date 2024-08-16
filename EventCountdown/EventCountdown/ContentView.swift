//
//  ContentView.swift
//  EventCountdown
//
//  Created by Liu on 15.08.24.
//

import SwiftUI

struct ContentView: View {
    let events: [Event]
    
    var body: some View {
        NavigationStack {
            List(events, id: \.self) {
                event in
                NavigationLink(value: event) {
                    EventSummary (event: event)
                }
            }
            .navigationDestination(for: Event.self) {
//                event in EventDetail(event: event)
            }
        }
    }
}

#Preview {
    ContentView(events: [
        Event(id: UUID(), title: "birthday", date: Date(), textColor: Color.red)])
}
