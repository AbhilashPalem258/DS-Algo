//
//  RecursionLeetcode.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 02/03/22.
//

import XCTest
@testable import LeetcodePractice

class RecursionLeetcode: XCTestCase {
    
    func testKthSymbolOfGrammer() {
        let obj = KthSymbolOfGrammer()
        XCTAssertEqual(obj.recursion(1, 1), 0)
        XCTAssertEqual(obj.recursion(2, 1), 0)
        XCTAssertEqual(obj.recursion(2, 2), 1)
    }

}
