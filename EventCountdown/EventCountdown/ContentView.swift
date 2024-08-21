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
                if events.isEmpty {
                    VStack {
                        VStack{
                            Image(systemName: "flag.checkered.2.crossed")
                                .font(.system(size: 60, weight: .ultraLight))
                                .foregroundStyle(Color.gray.opacity(0.3))
                            Text("No coming events")
                                .foregroundStyle(Color.gray.opacity(0.3))
                        }
                       .padding()
                        NavigationLink {
                            eventEditorView(formType: .add, onSave: { newEvent in events.append(newEvent)})
                        } label: {
                            Text("Create first event")
                        }
                        .navigationTitle("Event")
                    }
                } else {
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
                    
                    .navigationDestination(for: Event.self) { event in
                        eventEditorView(formType: .edit(event), onSave: {event in replaceEvent(event: event, events: &events)})
                    }
                    .toolbar {
                        ToolbarItem(placement: .primaryAction){
                            NavigationLink {
                                let newEvent = Event(id: .init(), title: "", date: Date.now, textColor: .black)
                                eventEditorView(formType: .add, onSave: {newEvent in events.append(newEvent)})
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(events: [
//        Event(id: .init(), title: "🥳 Birthday", date: .init(), textColor: .red), Event(id: .init(), title: "🏝️ Holiday", date: .init(), textColor: .blue)
    ])
}

func replaceEvent(event: Event, events: inout [Event]) {
    if let index = events.firstIndex(where: { $0.id == event.id }) {
        events[index] = event
    }
}
