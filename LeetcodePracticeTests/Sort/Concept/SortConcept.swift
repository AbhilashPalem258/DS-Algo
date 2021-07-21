//
//  SortConcept.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 13/07/21.
//

import XCTest
@testable import LeetcodePractice

class SortConcept: XCTestCase {
    
    func testInsertionSort() {
        var arr1 = [ 8, 3, 5, 4, 6 ]
        Sort.insertionSort(&arr1)
        XCTAssertEqual(arr1, [ 3, 4, 5, 6, 8])
        
        var arr2 = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
        Sort.insertionSort(&arr2)
        XCTAssertEqual(arr2, [-1, 0, 1, 2, 3, 3, 5, 8, 9, 10, 26, 27])
    }
    
    func testQuickSort(){
        XCTAssertEqual(Sort.quickSort([ 8, 3, 5, 4, 6 ]), [ 3, 4, 5, 6, 8])
        XCTAssertEqual(Sort.quickSort([ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]), [-1, 0, 1, 2, 3, 3, 5, 8, 9, 10, 26, 27])
    }
    
    func testRadixSort() {
        var arr1 = [ 8, 3, 5, 4, 6 ]
        Sort.radixSort(&arr1)
        XCTAssertEqual(arr1, [ 3, 4, 5, 6, 8])
    }
}
