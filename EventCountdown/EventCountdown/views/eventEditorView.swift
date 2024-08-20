//
//  eventEditorView.swift
//  EventCountdown
//
//  Created by Liu on 16.08.24.
//

import Foundation
import SwiftUI

struct eventEditorView: View {
    @State var event: Event
    let formType: FormType
    
    @Environment(\.dismiss) var dismiss
    
    init(event: Event, formType: FormType) {
        self.event = event
        self.formType = formType
    }
    
    var body: some View {
        VStack {
            Form {
                Section("Edit Options") {
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
        .navigationTitle(formType == .edit ? "Edit \(event.title)" : "Add")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    dismiss()
                }
                .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    eventEditorView(event: Event(id: .init(), title: "🥳 Birthday", date: .init(), textColor: .red), formType: .edit)
}

// Add enum to enter different views
enum FormType {
    case add
    case edit
}
