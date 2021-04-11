//
//  loginViewModel.swift
//  ToDoListTests
//
//  Created by Aaron Levy on 4/8/21.
//

import XCTest

@testable import ToDoList

var vm: LoginViewModel?
var tdvm: ToDoList?

class loginViewModelTests: XCTestCase {
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vm = LoginViewModel.init()
        tdvm = ToDoList.init()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vm = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testEditPassword(){
        vm?.editPassword(changeTo: "hello")
        XCTAssertNotNil(vm?.loginStuff.password, "Your password was not initialized")
    }
    
    func testEditUsername(){
        vm?.editUsername(changeTo: "hello")
        XCTAssertNotNil(vm?.loginStuff.username, "Your username was not initialized")
    }
    
    func testIsGreaterThanLimit(){
        let word1 = "1234567890123456"
        let word2 = "123456"
        let word1Test = vm?.isGreaterThanLimit(string: word1)
        let word2Test = vm?.isGreaterThanLimit(string: word2)
        XCTAssertFalse(word1Test!)
        XCTAssertTrue(word2Test!)
    }
    
    
    
    //ToDoListViewModelTesting
    
    func testNumThingsToDo(){
        let numThings = tdvm?.numThingsToDo()
        XCTAssertNotNil(numThings, "Your return is nil")
        XCTAssertEqual(numThings, tdvm?.toDoArray.count, "function does not report proper num of elements in arr")
    }
    
    
    func testGetTask(){
        tdvm?.addToDo(title: "hi", description: "hi", deadline: "hi")
        tdvm?.addToDo(title: "hello", description: "hhelloi", deadline: "hihello")
        let task = tdvm?.getTask(index: 1)
        XCTAssertEqual(task, "hello")
    }
    
    func testGetDescription(){
        tdvm?.addToDo(title: "hi", description: "hi", deadline: "hi")
        tdvm?.addToDo(title: "hello", description: "hhelloi", deadline: "hihello")
        let descrip = tdvm?.getDescription(index: 1)
        XCTAssertEqual(descrip, "hhelloi")
    }
    
    func testGetDeadline(){
        tdvm?.addToDo(title: "hi", description: "hi", deadline: "hi")
        tdvm?.addToDo(title: "hello", description: "hhelloi", deadline: "hihello")
        let deadline = tdvm?.getDeadline(index: 1)
        XCTAssertEqual(deadline, "hihello")
    }
    
    
    func testIsComplete(){
        tdvm?.addToDo(title: "hi", description: "hi", deadline: "hi")
        tdvm?.addToDo(title: "hello", description: "hhelloi", deadline: "hihello")
        let complete = tdvm?.isComplete(index: 1)
        XCTAssertNotNil(complete, "Your function's output is nil")
    }
    
    func testGetToDo(){
        tdvm?.addToDo(title: "hi", description: "hi", deadline: "hi")
        tdvm?.addToDo(title: "hello", description: "hhelloi", deadline: "hihello")
        let secondTodo = tdvm?.getToDo(index: 1)
        XCTAssertNotNil(secondTodo)
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
