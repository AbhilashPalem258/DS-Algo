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
    
    func testCourseScheduleTopological() {
        let obj = CourseScheduleTopological()
        XCTAssertEqual(obj.canFinish(2, [[1,0]]), true)
        XCTAssertEqual(obj.canFinish(2, [[1,0],[0,1]]), false)
        XCTAssertEqual(obj.canFinish(20, [[5,5]]), false)
        XCTAssertEqual(obj.canFinish(20, [[0,10],[3,18],[5,5],[6,11],[11,14],[13,1],[15,1],[17,4]]), false)
    }
}
