//
//  ContentView.swift
//  EventCountdown
//
//  Created by Liu on 15.08.24.
//

import SwiftUI

struct ContentView: View {
    
    @State var events: [Event]
    
    var body: some View {
        VStack{
            NavigationStack {
                List(events.indices, id: \.self) { idx in
                    NavigationLink(value: events[idx]){
                        EventSummaryView(event: events[idx])
                            .swipeActions {
                                Button("Delete") {
                                    events.remove(at: idx)
                                }
                                .tint(.red)
                            }
                    }
                    .navigationTitle("Event")
                }
                .navigationDestination(for: Event.self) { event in
                    eventEditorView(event: event)
                }
            }
        }
    }
}

#Preview {
    ContentView(events: [
        Event(id: .init(), title: "🥳 Birthday", date: .init(), textColor: .red), Event(id: .init(), title: "🏝️ Holiday", date: .init(), textColor: .blue)
    ])
}
