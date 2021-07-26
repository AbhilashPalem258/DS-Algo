//
//  BFSLeetcode.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 24/07/21.
//

import XCTest
@testable import LeetcodePractice

class BFSLeetcode: XCTestCase {

    func testWordLadder() {
        let obj = WordLadder()
        XCTAssertEqual(obj("hit", "cog",  ["hot","dot","dog","lot","log","cog"]), 5)
        XCTAssertEqual(obj("hit", "cog",  ["hot","dot","dog","lot","log"]), 0)
    }

    func testEvaluateDivision() {
        let obj = EvaluateDivision()
        XCTAssertEqual(obj.calcEquation([["a","b"],["b","c"]], [2.0,3.0], [["a","c"],["b","a"],["a","e"],["a","a"],["x","x"]]), [6.00000,0.50000,-1.00000,1.00000,-1.00000])
        XCTAssertEqual(obj.calcEquation([["a","b"],["c","d"]], [1.0,1.0], [["a","c"],["b","d"],["b","a"],["d","c"]]), [-1.00000,-1.00000,1.00000,1.00000])
    }
    
    func testShortestDistanceAllBuildings() {
        let obj = ShortestDistanceAllBuildings()
        XCTAssertEqual(obj.shortestDistance([[1,0,2,0,1],[0,0,0,0,0],[0,0,1,0,0]]), 7)
    }
}
