//
//  main.swift
//  todo-app.swiftpm
//
//  Created by Liu on 05.08.24.
//

import Foundation

// * Create the `Todo` struct.
// * Ensure it has properties: id (UUID), title (String), and isCompleted (Bool).
struct Todo: CustomStringConvertible, Codable{
    
    var id: UUID
    var title: String?
    var isCompleted: Bool
    
    // conforming to CustomStringConvertible
    var description: String {
        return "\(isCompleted ? "✅" : "❌") \(title!)"
    }

}

// Create the `Cache` protocol that defines the following method signatures:
//  `func save(todos: [Todo])`: Persists the given todos.
//  `func load() -> [Todo]?`: Retrieves and returns the saved todos, or nil if none exist.
protocol Cache {
    func save(todos: [Todo])
    func load() -> [Todo]?
}

// `FileSystemCache`: This implementation should utilize the file system
// to persist and retrieve the list of todos.
// Utilize Swift's `FileManager` to handle file operations.
final class JSONFileManagerCache: Cache {
    
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
    
    func save(todos: [Todo]) {
        
        do {
            let jsonData = try self.encoder.encode(todos)
            try jsonData.write(to: self.logURL)
        } catch {
            print("Fail to save the todos a local file")
        }
    }
    
    func load() -> [Todo]? {
        do {
            let contents = try Data(contentsOf: self.logURL)
            let decodedTodos = try self.decoder.decode([Todo].self, from: contents)
            print("Decoded Todo: \(decodedTodos)")
            return decodedTodos
        } catch {
            print("Error encoding or decoding: \(error)")
            return nil
        }
    }
}

// `InMemoryCache`: : Keeps todos in an array or similar structure during the session.
// This won't retain todos across different app launches,
// but serves as a quick in-session cache.
final class InMemoryCache: Cache {
    private var todoCache: [Todo] = []
    
    func save(todos: [Todo]) {
        self.todoCache = todos
    }
    func load() -> [Todo]? {
        return self.todoCache.isEmpty ? nil : self.todoCache
    }
}

// The `TodosManager` class should have:
// * A function `func listTodos()` to display all todos.
// * A function named `func addTodo(with title: String)` to insert a new todo.
// * A function named `func toggleCompletion(forTodoAtIndex index: Int)`
//   to alter the completion status of a specific todo using its index.
// * A function named `func deleteTodo(atIndex index: Int)` to remove a todo using its index.
final class TodoManager {
    
    var todoList: [Todo] = []
    private var cache: Cache
    
    init(cache: Cache) {
        self.cache = cache
        if let todoList = cache.load() {
            self.todoList = todoList
        }
    }
    
    func listTodos() {
        print("📝 Your todos: \n")
        for (index, todo) in self.todoList.enumerated() {
            print("\(index + 1). \(todo)")
        }
    }
    
    func addToDo(with title: String) {
        self.todoList.append(Todo(id: .init(), title: title, isCompleted: false))
        self.cache.save(todos: self.todoList)
        print("\n📌 Todo added!\n")
    }
    
    func toggleCompletion(forTodoAtIndex index: Int) {
        self.todoList[index - 1].isCompleted = true
        self.cache.save(todos: self.todoList)
        print("\n🔃 Todo completion status toggled!\n")
    }
    
    func deleteToDo(atIndex index: Int) {
        self.todoList.remove(at: index - 1)
        self.cache.save(todos: self.todoList)
        print("\n🗑️ Todo deleted!\n")
    }

}


// * The `App` class should have a `func run()` method, this method should perpetually
//   await user input and execute commands.
//  * Implement a `Command` enum to specify user commands. Include cases
//    such as `add`, `list`, `toggle`, `delete`, and `exit`.
//  * The enum should be nested inside the definition of the `App` class
final class App {
    
    private var jsonCache = JSONFileManagerCache()
    private var todoManager = TodoManager(cache: InMemoryCache())
    
    init() {
        guard let loadedTodoList = self.jsonCache.load() else {
            return
        }
        self.todoManager.todoList = loadedTodoList
    }
    
    enum Command: String {
        case add
        case list
        case toggle
        case delete
        case exit
    }
    
    func run() {
        print("🌟 Welcome to Todo CLI 🌟")
        
        while true {
            print("What would you like to do? (add, list, toggle, delete, exit): ", terminator: "")
            if let command = Command(rawValue: readLine()!) {
                switch command {
                case .add:
                    print("\nEnter todo title: ", terminator: "")
                    if let todoString = readLine() {
                        todoManager.addToDo(with: todoString)
                    }
                    jsonCache.save(todos: todoManager.todoList)
                    continue
                case .list:
                    todoManager.listTodos()
                    continue
                case .toggle:
                    todoManager.listTodos()
                    print("\nEnter the number of the todo to toggle: ", terminator: "")
                    if let index = Int(readLine()!){
                        todoManager.toggleCompletion(forTodoAtIndex: index)
                    }
                    jsonCache.save(todos: todoManager.todoList)
                    continue
                case .delete:
                    todoManager.listTodos()
                    print("\nEnter the number of the todo to delete: ", terminator: "")
                    if let index = Int(readLine()!){
                        todoManager.deleteToDo(atIndex: index)
                    }
                    jsonCache.save(todos: todoManager.todoList)
                    continue
                case .exit:
                    exit(0)
                }
            }
        }
    }
}


// TODO: Write code to set up and run the app.
var app = App()
app.run()
