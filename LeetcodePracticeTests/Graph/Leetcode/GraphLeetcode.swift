//
//  GraphLeetcode.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 26/07/21.
//

import XCTest
@testable import LeetcodePractice

class GraphLeetcode: XCTestCase {
    func testCourseSchedule() {
        let obj = CourseSchedule()
        XCTAssertEqual(obj.canFinish(2, [[1,0]]), true)
        XCTAssertEqual(obj.canFinish(2, [[1,0],[0,1]]), false)
    }
    
    func testCountSubIslands() {
        let obj = CountSubIslands()
        XCTAssertEqual(obj([[1,1,1,0,0],[0,1,1,1,1],[0,0,0,0,0],[1,0,0,0,0],[1,1,0,1,1]], [[1,1,1,0,0],[0,0,1,1,1],[0,1,0,0,0],[1,0,1,1,0],[0,1,0,1,0]]), 3)
        XCTAssertEqual(obj([[1,0,1,0,1],[1,1,1,1,1],[0,0,0,0,0],[1,1,1,1,1],[1,0,1,0,1]], [[0,0,0,0,0],[1,1,1,1,1],[0,1,0,1,0],[0,1,0,1,0],[1,0,0,0,1]]), 2)
    }
    
    func testCloneGraph() {
 
    }
}
