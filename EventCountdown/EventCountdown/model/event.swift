//
//  event.swift
//  EventCountdown
//
//  Created by Liu on 16.08.24.
//

import Foundation
import SwiftUI

struct Event: Comparable, Identifiable, Hashable, Codable {
    var id: UUID
    var title: String
    var date: Date
    var textColor: Color
    
    
    // conform to Comparable: comparing date
    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.date < rhs.date
    }
}
