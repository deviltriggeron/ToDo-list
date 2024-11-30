//
//  ToDoListTests.swift
//  ToDoListTests
//
//  Created by Иван Бурцев on 27.11.2024.
//

import XCTest
@testable import ToDoList

final class testAlamofire: XCTestCase {
    var service: AlamofireService = AlamofireService()
    
    func testFetchData_success() async throws {
        let expectation = XCTestExpectation(description: "Fetch data completed")
        service.fetchData {
            XCTAssertEqual(
        }
    }
}


