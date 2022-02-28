//
//  TwoPointerLeetcode.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 28/02/22.
//

import XCTest
@testable import LeetcodePractice

class TwoPointerLeetcode: XCTestCase {

    func testSumOfSquareNumbers() {
        let obj = SumOfSquareNumbers()
        XCTAssertEqual(obj(5), true)
        XCTAssertEqual(obj(3), false)
    }

    func testTwoSumIV() {
        typealias TreeNode = TreeLeetcode.TreeNode
        let two = TreeNode(2)
        let four = TreeNode(4)
        let seven = TreeNode(7)
        
        let three = TreeNode(3, two, four)
        let six = TreeNode(6, nil, seven)
        
        let five = TreeNode(5, three, six)

        let obj = TwoSumIV()
        XCTAssertEqual(obj(five, 9), true)
    }
    
    func testCountBinarySubstrings() {
        let obj = CountBinarySubstrings()
        XCTAssertEqual(obj("00110011"), 6)
    }
}
