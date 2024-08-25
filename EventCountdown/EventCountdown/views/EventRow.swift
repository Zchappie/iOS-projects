//
//  EventSummaryView.swift
//  EventCountdown
//
//  Created by Liu on 18.08.24.
//

import SwiftUI

struct EventRow: View {
    
    // not using @State property, I don't need it. It is blocking the deletion 
    var event: Event

    @State private var countDown = ""

    // Timer that fires every second
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack {
            Text("\(event.title)")
                .bold()
                .foregroundStyle(event.textColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(countDown)
                .foregroundStyle(event.date < Date.now ? .red : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onReceive(timer) { now in countDownString(from: event.date, to: now, update: &countDown) }
        }
    }
}


func countDownString (from date: Date, to now: Date, update countDown: inout String) {
    countDown = RelativeDateTimeFormatter().localizedString(for: date, relativeTo: now)
}

