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
            Text("Events")
            NavigationStack {
                List(events, id: \.self) { event in
                    NavigationLink(value: event){
                        EventSummaryView(event: event)
                    }
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
