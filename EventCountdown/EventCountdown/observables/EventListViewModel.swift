//
//  EventViewModel.swift
//  EventCountdown
//
//  Created by Liu on 21.08.24.
//

import Foundation

class EventListViewModel: ObservableObject {
    @Published var events = [Event]()
    
}
