//
//  JulyLeetcodeChallenge.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 03/07/21.
//

import XCTest
@testable import LeetcodePractice

class JulyLeetcodeChallenge: XCTestCase {

    func testFindClosestElements() {
        let obj = FindClosestElements()
        XCTAssertEqual(obj([1,2,3,4,5], 4, 3), [1,2,3,4])
        
        XCTAssertEqual(obj.binarySearchWindow([1,2,3,4,5], 4, 3), [1,2,3,4])
        XCTAssertEqual(obj.binarySearchWindow([1,2,3,4,5], 4, -1), [1,2,3,4])
    }
    
    func testMaxSumofRectangleNoLargerThanK() {
        let obj = MaxSumofRectangleNoLargerThanK()
        XCTAssertEqual(obj([[1,0,1],[0,-2,3]], 2), 2)
    }
   
}
