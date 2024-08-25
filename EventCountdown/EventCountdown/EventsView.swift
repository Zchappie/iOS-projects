//
//  ContentView.swift
//  EventCountdown
//
//  Created by Liu on 15.08.24.
//

import SwiftUI

struct EventsView: View {
    
    @EnvironmentObject var fileCache: JSONFileManagerCache
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
                            EventRow(event: events[idx])
                                .swipeActions {
                                    Button("Delete") {
                                        events.remove(at: idx)
                                        fileCache.save(events: events)
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
    
    private func updateEventsAndSortBaseOnDate(event: Event, events: inout [Event]) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index] = event
            print("Update result \(events[index].title)")
        } else {
            print("New event added to the list")
            events.append(event)
        }
        events.sort{ $0 < $1 }
        fileCache.save(events: events)
    }
}

#Preview {
    EventsView(events: [])
}
