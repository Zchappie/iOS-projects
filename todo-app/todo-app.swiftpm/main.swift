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

}

// `FileSystemCache`: This implementation should utilize the file system
// to persist and retrieve the list of todos.
// Utilize Swift's `FileManager` to handle file operations.
final class JSONFileManagerCache: Cache {

}

// `InMemoryCache`: : Keeps todos in an array or similar structure during the session.
// This won't retain todos across different app launches,
// but serves as a quick in-session cache.
final class InMemoryCache: Cache {

}

// The `TodosManager` class should have:
// * A function `func listTodos()` to display all todos.
// * A function named `func addTodo(with title: String)` to insert a new todo.
// * A function named `func toggleCompletion(forTodoAtIndex index: Int)`
//   to alter the completion status of a specific todo using its index.
// * A function named `func deleteTodo(atIndex index: Int)` to remove a todo using its index.
final class TodoManager {
    
    var todoList: Array<Todo>
    
    init(todoList: Array<Todo>) {
        self.todoList = todoList
    }
    
    func listTodos() {
        print("📝 Your todos: \n")
        for (index, todo) in self.todoList.enumerated() {
            print("\(index + 1). \(todo)")
        }
    }
    
    func addToDo(with title: String) {
        self.todoList.append(Todo(id: .init(), title: title, isCompleted: false))
        print("\n📌 Todo added!\n")
    }
    
    func toggleCompletion(forTodoAtIndex index: Int) {
        self.todoList[index - 1].isCompleted = true
        print("\n🔃 Todo completion status toggled!\n")
    }
    
    func deleteToDo(atIndex index: Int) {
        self.todoList.remove(at: index - 1)
        print("\n🗑️ Todo deleted!\n")
    }

}


// * The `App` class should have a `func run()` method, this method should perpetually
//   await user input and execute commands.
//  * Implement a `Command` enum to specify user commands. Include cases
//    such as `add`, `list`, `toggle`, `delete`, and `exit`.
//  * The enum should be nested inside the definition of the `App` class
final class App {
    
    enum Command: String {
        case add
        case list
        case toggle
        case delete
        case exit
    }
    
    func run() {
        let todoManager = TodoManager(todoList: [])
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
                    continue
                case .delete:
                    todoManager.listTodos()
                    print("\nEnter the number of the todo to delete: ", terminator: "")
                    if let index = Int(readLine()!){
                        todoManager.deleteToDo(atIndex: index)
                    }
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
//var todo1 = Todo( id: .init(), title: "workout", isCompleted: false)
//var todo2 = Todo( id: .init(), title: "eat vegetable", isCompleted: false)
//
//let todoManager = TodoManager(todoList: [todo1, todo2])
//todoManager.listTodos()
//print("Now adding new todo")
//todoManager.addToDo(with: "go to doctor")
//todoManager.listTodos()
//print("Now toggle a finished todo")
//todoManager.toggleCompletion(forTodoAtIndex: 1)
//todoManager.listTodos()
//print("Now delet a finished todo")
//todoManager.deleteToDo(atIndex: 1)
//todoManager.listTodos()
