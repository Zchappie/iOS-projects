//
//  event.swift
//  EventCountdown
//
//  Created by Liu on 16.08.24.
//

import Foundation
import SwiftUI


// Hashable to use it in a List view
// Codable to encode or decode to JSON for caching
struct Event: Comparable, Identifiable, Codable, Hashable {
    var id: UUID
    var title: String
    var date: Date
    var textColor: Color
    
    // default no arg initializer
    init() {
        id = UUID()
        title = ""
        date = Date.now
        textColor = .black
    }
    
    // customized initialization
    init(id: UUID, title: String, date: Date, textColor: Color) {
            self.id = id
            self.title = title
            self.date = date
            self.textColor = textColor
        }
    
    // conform to Comparable: only comparing date
    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.date < rhs.date
    }
}

