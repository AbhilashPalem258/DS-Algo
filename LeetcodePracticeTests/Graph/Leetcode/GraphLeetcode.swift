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
    
    func testAlienDictionary() {
        let obj = AlienDictionary()
        XCTAssertEqual(obj(["wrt","wrf","er","ett","rftt"]), "wertf")
        XCTAssertEqual(obj(["z","x"]), "zx")
    }
    
    func testGraphValidTree() {
        let obj = GraphValidTree()
        XCTAssertEqual(obj(n: 5, edges: [[0, 1], [0, 2], [0, 3], [1, 4]]), true)
        XCTAssertEqual(obj(n: 5, edges: [[0, 1], [1, 2], [2, 3], [1, 3], [1, 4]]), false)
    }
    
    func testMinReorder() {
        let obj = MinReorder()
        XCTAssertEqual(obj(6, [[0,1],[1,3],[2,3],[4,0],[4,5]]), 3)
        XCTAssertEqual(obj(5, [[1,0],[1,2],[3,2],[3,4]]), 2)
        XCTAssertEqual(obj(3, [[1,0],[2,0]]), 0)
    }
}
