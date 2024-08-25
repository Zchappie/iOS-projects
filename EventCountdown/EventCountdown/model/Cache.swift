//
//  Cache.swift
//  EventCountdown
//
//  Created by Liu on 16.08.24.
//

import Foundation

protocol Cache {
    func save(events: [Event])
    func load() -> [Event]?
}

// TODO: Change to additive update
/// `FileSystemCache`: This implementation should utilize the file system to persist and retrieve the list of events. Utilize Swift's `FileManager` to handle file operations.
final class JSONFileManagerCache: Cache, ObservableObject {
    
    private let filePath: String
    private let fileManager: FileManager
    private let currentDirectory: String
    private let logURL: URL
    
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    init(){
        self.filePath = "log.json"
        self.fileManager = FileManager.default
        self.currentDirectory = fileManager.currentDirectoryPath
        self.logURL = URL(fileURLWithPath: "\(self.currentDirectory)/\(filePath)")
        self.encoder = JSONEncoder()
        self.decoder = JSONDecoder()
    }
    
    func save(events: [Event]) {
        
        do {
            let jsonData = try self.encoder.encode(events)
            try jsonData.write(to: self.logURL)
            print("Data saved in \(self.logURL.absoluteString)")
        } catch {
            print("Fail to save the events a local file")
        }
    }
    
    func load() -> [Event]? {
        do {
            let contents = try Data(contentsOf: self.logURL)
            let decodedEvents = try self.decoder.decode([Event].self, from: contents)
            print("Decoded Todo: \(decodedEvents)")
            return decodedEvents
        } catch {
            print("Error encoding or decoding: \(error)")
            return nil
        }
    }
}

/// `InMemoryCache`: : Keeps events in an array or similar structure during the session. This won't retain events across different app launches, but serves as a quick in-session cache.
final class InMemoryCache: Cache, ObservableObject {
    private var eventCache: [Event] = []
    
    func save(events: [Event]) {
        self.eventCache = events
    }
    func load() -> [Event]? {
        return self.eventCache.isEmpty ? nil : self.eventCache
    }
}
