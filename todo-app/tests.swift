import XCTest
@testable import Sources

final class AppTests: XCTestCase {
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
    
    func testToggleCompletion_whenCalled_todoCompletionStatusIsToggled() {
        let todo = Todo(title: "Test Todo")
        todo.toggleCompletion()
        XCTAssertTrue(todo.isCompleted)
    }
}
