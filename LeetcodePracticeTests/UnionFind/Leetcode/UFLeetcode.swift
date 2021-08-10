//
//  UFLeetcode.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 27/07/21.
//

import XCTest
@testable import LeetcodePractice

class UFLeetcode: XCTestCase {
    func testNumberOfConnectedComponentsInAGraph() {
        let obj = NumberConnectedComponentsUndirectedGraph()
        XCTAssertEqual(obj.countComponents(5, [[0, 1], [1, 2], [3, 4]]), 2)
        XCTAssertEqual(obj.countComponents(5, [[0, 1], [1, 2], [2, 3], [3, 4]]), 1)
    }
    
    func testNumberOfProvinces() {
        let obj = NumberOfProvinces()
        XCTAssertEqual(obj([[1,1,0],[1,1,0],[0,0,1]]), 2)
        XCTAssertEqual(obj([[1,0,0],[0,1,0],[0,0,1]]), 3)
    }
    
    func testRedundantConnection() {
        let obj = RedundantConnection()
        XCTAssertEqual(obj.findRedundantConnection([[1,2],[1,3],[2,3]]), [2,3])
        XCTAssertEqual(obj.findRedundantConnection([[1,2],[2,3],[3,4],[1,4],[1,5]]), [1,4])
    }
    
    func testMinCostConnectPoints() {
        let obj = MinCostConnectPoints()
        XCTAssertEqual(obj([[0,0],[2,2],[3,10],[5,2],[7,0]]), 20)
        XCTAssertEqual(obj([[3,12],[-2,5],[-4,1]]), 18)
        XCTAssertEqual(obj([[0,0],[1,1],[1,0],[-1,1]]), 4)
    }
}
