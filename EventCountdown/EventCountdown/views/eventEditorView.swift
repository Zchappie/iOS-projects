//
//  eventEditorView.swift
//  EventCountdown
//
//  Created by Liu on 16.08.24.
//

import SwiftUI

struct eventEditorView: View {
    @State var event = Event(id: .init(), title: "🥳 Birthday", date: .init(), textColor: .red)
    
    var body: some View {
        VStack {
//            Text("Edit \(event.title)")
//                .padding(.top, 9.5)
//                .padding(.bottom, 8)
//                .frame(minWidth: 0, maxWidth: .infinity)
//                .background(Color(UIColor.secondarySystemGroupedBackground))
//                .font(.title3)
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
    eventEditorView()
}
