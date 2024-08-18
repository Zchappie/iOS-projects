//
//  eventEditorView.swift
//  EventCountdown
//
//  Created by Liu on 16.08.24.
//

import SwiftUI

struct eventEditorView: View {
    @State var event : Event
    
    init(event: Event) {
        self.event = event
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Edit  \(event.title)")) {
                    TextField("Name", text: $event.title)
                        .foregroundColor(event.textColor)
                    DatePicker(
                        "Date",
                         selection: $event.date,
                         displayedComponents: [.date, .hourAndMinute]
                    )
                    ColorPicker("Text color", selection: $event.textColor)
                }
            }
        }
    }
}

#Preview {
    eventEditorView(event: Event(id: .init(), title: "🥳 Birthday", date: .init(), textColor: .red))
}
