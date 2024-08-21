//
//  EventEditViewModel.swift
//  EventCountdown
//
//  Created by Liu on 21.08.24.
//

import Foundation

class EventEditViewModel: ObservableObject {
    @Published var event: Event
//    @Published var id: UUID
//    @Published var title: String
    
    init(){
        event = Event(id: .init(), title: "", date: Date.now, textColor: .black)
    }
    
}
