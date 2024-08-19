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
                List(events.indices, id: \.self) { idx in NavigationLink(value: events[idx]) {
                        EventSummaryView(event: events[idx])
                            .swipeActions {
                                Button("Delete") {
                                    events.remove(at: idx)
                                }
                                .tint(.red)
                            }
                            .onTapGesture {
                            }
                    }
                    .navigationTitle("Event")
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction){
                        NavigationLink {
                            let newEvent = Event(id: .init(), title: "", date: Date.now, textColor: .black)
                            eventEditorView(event: newEvent, formType: .add)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .navigationDestination(for: Event.self) { event in
                    eventEditorView(event: event, formType: .edit)
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
