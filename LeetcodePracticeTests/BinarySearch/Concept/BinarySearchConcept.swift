//
//  BinarySearchConcept.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 10/07/21.
//

import Foundation

import XCTest
@testable import LeetcodePractice

class BinarySearchConceptTests: XCTestCase {
    func testBinarySearchRecursive() {
        let arr = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]
        XCTAssertEqual(binarySearch(arr, searchKey: 43, range: 0..<arr.count), 13)
    }
    
    func testBinarySearchIterative() {
        let arr = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]
        XCTAssertEqual(binarySearchIterative(arr, key: 43), 13)
    }
    
    func testCountOccurances() {
        let arr = [ 0, 1, 1, 3, 3, 3, 3, 6, 8, 10, 11, 11 ]
        XCTAssertEqual(countOccurances(arr, key: 3), 4)
    }
    
    func testMinimumMaximum() {
        let pair = minimumMaximun([ 8, 3, 9, 4, 6 ])
        XCTAssertEqual(pair?.0, 3)
        XCTAssertEqual(pair?.1, 9)
    }
}
