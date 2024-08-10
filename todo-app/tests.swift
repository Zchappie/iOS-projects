import XCTest
@testable import Sources

final class AppTests: XCTestCase {
    var todo1 = Todo( id: .init(), title: "workout", isCompleted: false)
    var todo2 = Todo( id: .init(), title: "eat vegetable", isCompleted: false)
    
    func testToggleCompletion_whenCalled_todoCompletionStatusIsToggled() {
        let todo = Todo(title: "Test Todo")
        todo.toggleCompletion()
        XCTAssertTrue(todo.isCompleted)
    }
    
    func testJSONFileManagerCache() {
        let todoManager = TodoManager(todoList: [todo1, todo2])
        var jsonCache = JSONFileManagerCache()
        jsonCache.save(todos: todoManager.todoList)
        let newTodoList = jsonCache.load()!
        XCTAssertEqual(newTodoList, todoManager.todoList)
    }
    
    func testTodoManager_AddToDo() {
        let todoManager = TodoManager(todoList: [todo1, todo2])
        XCTAssertEqual(todoManager.todoList.count, 2)
        todoManager.addToDo(with: "go to doctor")
        XCTAssertEqual(todoManager.todoList.count, 3)
    }
    
    func testTodoManager_DeleteToDo() {
        let todoManager = TodoManager(todoList: [todo1, todo2])
        XCTAssertEqual(todoManager.todoList.count, 2)
        todoManager.deleteToDo(atIndex: 1)
        XCTAssertEqual(todoManager.todoList.count, 1)
    }
    
    
}
