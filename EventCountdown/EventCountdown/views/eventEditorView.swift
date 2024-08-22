//
//  eventEditorView.swift
//  EventCountdown
//
//  Created by Liu on 16.08.24.
//

import Foundation
import SwiftUI

struct eventEditorView: View {
    @State private var id: UUID = UUID()
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var textColor: Color = .black
    var onSave: (Event) -> Void
    var formType: FormType
    
    // using key path to point to a provided environment values by SwiftUI, without caring the detailed implementation. e.g., what to dismiss.
    @Environment(\.dismiss) var dismiss
    
    init(formType: FormType, onSave: @escaping (Event) -> Void) {
        self.formType = formType
        self.onSave = onSave
        
        
        // re-initialize the state properties through `_` based on the mode, through this we have the full access to state property
        switch formType {
        case .add:
            _id = State(initialValue: UUID())
            _title = State(initialValue: "")
            _date = State(initialValue: Date())
            _textColor = State(initialValue: .black)
        case .edit(let event):
            _id = State(initialValue: event.id)
            _title = State(initialValue: event.title)
            _date = State(initialValue: event.date)
            _textColor = State(initialValue: event.textColor)
        }
    }
    
    var body: some View {
        VStack {
            Form {
                Section("Edit Options") {
                    TextField("Name", text: $title)
                        .foregroundColor(textColor)
                    DatePicker(
                        "Date",
                        selection: $date,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    ColorPicker("Text color", selection: $textColor)
                }
            }
            .navigationTitle("Edit \(title)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let updatedEvent = Event(id: id, title: title.trimmingCharacters(in: .whitespaces), date: date, textColor: textColor)
                        onSave(updatedEvent)
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {
    eventEditorView(formType: .add, onSave: {event in
        var events = [
                Event(id: .init(), title: "🥳 Birthday", date: .init(), textColor: .red), Event(id: .init(), title: "🏝️ Holiday", date: .init(), textColor: .blue)
            ]
        events.append(event)})
}

// Add enum to enter different views
enum FormType {
    case add
    case edit(Event)
}

