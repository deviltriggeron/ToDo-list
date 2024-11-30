//
//  ToDoListUITests.swift
//  ToDoListUITests
//
//  Created by Иван Бурцев on 27.11.2024.
//

import XCTest

final class ToDoListUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {

    }
    
    func emptyStart() throws -> XCUIApplication  {
        let app = XCUIApplication()
        app.launch()
        app.wait(for: .runningForeground, timeout: 10)
        return app
    }

    func testWelcomeView() throws {
        let app = try emptyStart()
        let task = app.staticTexts["Задачи"]
        
        XCTAssert(task.exists)
    }
    
    func testButtonView() throws {
        let app = try emptyStart()
        let button = app.buttons["square.and.pencil"]
        
        XCTAssert(button.exists)
    }
    
    func testAddTask1() throws {
        let app = try emptyStart()
        app.buttons["square.and.pencil"].tap()
        let mainText = app.textFields["Название задачи"]
        
        XCTAssert(mainText.exists)
    }
        
    func testAddTask2() throws {
        let app = try emptyStart()
        app.buttons["square.and.pencil"].tap()
        let button = app.buttons["Сохранить"]
        
        XCTAssert(button.exists)
    }
    
    func testAddTask3() throws {
        let app = try emptyStart()
        app.buttons["square.and.pencil"].tap()
        
        let button = app.buttons["Задачи"]
        
        XCTAssert(button.exists)
    }
    
    func testSearch1() throws {
        let app = try emptyStart()
        let searchBar = app.searchFields["Search"]
        XCTAssert(searchBar.exists)
    }
    
    func testSearch2() throws {
        let app = try emptyStart()
        let searchBar = app.searchFields["Search"]
        searchBar.tap()
        searchBar.typeText("11")
        let value = searchBar.value as? String
            XCTAssertEqual(value, "11", "Search bar should contain typed text")
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
