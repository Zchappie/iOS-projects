//
//  ContentView.swift
//  EventCountdown
//
//  Created by Liu on 15.08.24.
//

import SwiftUI

struct EventsView: View {
    
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
                            EventForm(formType: .add, onSave: { newEvent in events.append(newEvent)})
                        } label: {
                            Text("Create first event")
                        }
                        .navigationTitle("Event")
                    }
                } else {
                    List(events.indices, id: \.self) { idx in NavigationLink(value: events[idx]) {
                            EventRow(event: $events[idx])
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
                        EventForm(formType: .edit(event), onSave: {event in updateEventsAndSortBaseOnDate(event: event, events: &events)})
                    }
                    .toolbar {
                        ToolbarItem(placement: .primaryAction){
                            NavigationLink {
                                EventForm(formType: .add, onSave: {event in updateEventsAndSortBaseOnDate(event: event, events: &events)})
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
    EventsView(events: [
//        Event(id: .init(), title: "🥳 Birthday", date: .init(), textColor: .red), Event(id: .init(), title: "🏝️ Holiday", date: .init(), textColor: .blue)
    ])
}

func updateEventsAndSortBaseOnDate(event: Event, events: inout [Event]) {
    if let index = events.firstIndex(where: { $0.id == event.id }) {
        events[index] = event
        print("Update result \(events[index].title)")
    } else {
        print("Not finding event in the list")
        events.append(event)
    }
    events.sort{ $0 < $1 }
}
