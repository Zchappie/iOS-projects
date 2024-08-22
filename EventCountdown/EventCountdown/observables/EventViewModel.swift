//
//  EventViewModel.swift
//  EventCountdown
//
//  Created by Liu on 22.08.24.
//

import Foundation

class EventViewModel: ObservableObject{
    @Published var event: Event
    
    init(event: Event) {
        self.event = event
    }
}
