//
//  EventSummaryView.swift
//  EventCountdown
//
//  Created by Liu on 18.08.24.
//

import SwiftUI

struct EventSummaryView: View {
    
    let event: Event
    
    var body: some View {
        
        VStack {
            Text("\(event.title)")
                .bold()
                .foregroundStyle(event.textColor)
            Text("\(RelativeDateTimeFormatter().localizedString(for: event.date, relativeTo: Date.now))")
        }
    }
}

#Preview {
    EventSummaryView(event: Event(id: .init(), title: "🥳 Birthday", date: .init(), textColor: .red))
}
