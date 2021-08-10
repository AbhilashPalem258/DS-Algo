//
//  TopologicalSortLeetcode.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 28/07/21.
//

import XCTest
@testable import LeetcodePractice

class TopologicalSortLeetcode: XCTestCase {
    func testCourseScheduleII() {
        let obj = CourseScheduleII()
        XCTAssertEqual(obj.findOrder(1, []), [0])
        XCTAssertEqual(obj.findOrder(2, [[1,0]]), [0,1])
        XCTAssertEqual(obj.findOrder(4, [[1,0],[2,0],[3,1],[3,2]]), [0, 1, 2, 3])
        
        XCTAssertEqual(obj.findOrderWithMemoryOptimization(1, []), [0])
        XCTAssertEqual(obj.findOrderWithMemoryOptimization(2, [[1,0]]), [0,1])
        XCTAssertEqual(obj.findOrderWithMemoryOptimization(4, [[1,0],[2,0],[3,1],[3,2]]), [0, 1, 2, 3])
    }
}
