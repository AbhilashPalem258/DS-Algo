//
//  LinkedListTests.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 17/06/21.
//

import XCTest
@testable import LeetcodePractice

class LinkedListTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
extension LinkedListTests {
    func testLinkedList() {
        let list = LinkedList<Int>()
        list.append(101)
        list.append(102)
        
        list.insert(201, at: 0)
        list.insert(.init(202), at: 1)
        
        XCTAssertEqual(list.node(at: 0)?.value, 201)
        XCTAssertEqual(list.node(at: 1)?.value, 202)
        XCTAssertEqual(list.node(at: 2)?.value, 101)
        XCTAssertEqual(list.node(at: 3)?.value, 102)
        
        list.insert(301, at: 3)
        list.remove(at: 3)
        
        let secList: LinkedList<Int> = [222,333,444,555]
        list.insert(secList, at: 2)
        XCTAssertEqual(secList.last?.value, 102)
        
        let thirdList = LinkedList.init([77, 88, 99, 11])
        XCTAssertEqual(thirdList.count, 4)
        thirdList.reverse()
        
    }
}
