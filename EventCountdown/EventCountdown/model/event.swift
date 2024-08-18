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
    
    
    // conform to Comparable: only comparing date
    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.date < rhs.date
    }
    
    // conform to Equatable in Comparable: only comparing date
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.date == rhs.date
    }
}

