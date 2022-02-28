//
//  StackLeetcode.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 13/02/22.
//

import XCTest
@testable import LeetcodePractice

class StackLeetcode: XCTestCase {

    func testStockSpanner() {
        let obj = StockSpanner()
        XCTAssertEqual(obj.next(100), 1)
        XCTAssertEqual(obj.next(80), 1)
        XCTAssertEqual(obj.next(60), 1)
        XCTAssertEqual(obj.next(70), 2)
        XCTAssertEqual(obj.next(60), 1)
        XCTAssertEqual(obj.next(75), 4)
        XCTAssertEqual(obj.next(85), 6)
    }

}
