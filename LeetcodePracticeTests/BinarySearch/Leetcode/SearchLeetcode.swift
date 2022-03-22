//
//  SearchLeetcode.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 11/07/21.
//

import XCTest
@testable import LeetcodePractice

class SearchLeetcodeTests: XCTestCase {

    func testSearchRotatedSortedArr() {
        let obj = SearchRotatedSortedArr()
        XCTAssertEqual(obj([4,5,6,7,0,1,2], 0), 4)
        XCTAssertEqual(obj([4,5,6,7,0,1,2], 3), -1)
        XCTAssertEqual(obj([1], 0), -1)
    }
    
    func testSearchRotatedSortedArrII() {
        let obj = SearchRotatedSortedArrII()
        XCTAssertEqual(obj([1,0,1,1,1], 0), true)
        XCTAssertEqual(obj([4,5,6,7,0,1,2], 3), false)
    }
    
    func testMinimumInRotatedSortedArr() {
        let obj = MinimumInRotatedSortedArr()
        XCTAssertEqual(obj([3,4,5,1,2]), 1)
        XCTAssertEqual(obj([4,5,6,7,0,1,2]), 0)
        XCTAssertEqual(obj([1,3,5]), 1)
    }
    
    func testMinimumInRotatedSortedArrII() {
        let obj = MinimumInRotatedSortedArrII()
        XCTAssertEqual(obj([3,4,5,1,2]), 1)
        XCTAssertEqual(obj([4,5,6,7,0,1,2]), 0)
        XCTAssertEqual(obj([1,3,5]), 1)
        XCTAssertEqual(obj([2,2,2,0,1]), 0)
    }
    
    func testSearchMatrix() {
        let obj = SearchMatrix()
        XCTAssertEqual(obj([[1,1]], 2), false)
        XCTAssertEqual(obj([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 3), true)
        XCTAssertEqual(obj([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 13), false)
    }
    
    func testSearchMatrixII() {
        let obj = SearchMatrixII()
        XCTAssertEqual(obj([[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], 5), true)
        XCTAssertEqual(obj([[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], 20), false)
    }
    
    func testSearchRange() {
        let obj = SearchRange()
        XCTAssertEqual(obj([5,7,7,8,8,10], 8), [3,4])
        XCTAssertEqual(obj([5,7,7,8,8,10], 6), [-1,-1])
        XCTAssertEqual(obj([], 0), [-1,-1])
    }
    
    func testSearchInsert() {
        let obj = SearchInsert()
        XCTAssertEqual(obj([1,3,5,6], 5), 2)
        XCTAssertEqual(obj([1,3,5,6], 2), 1)
        XCTAssertEqual(obj([1,3,5,6], 7), 4)
        XCTAssertEqual(obj([1,3,5,6], 0), 0)
        XCTAssertEqual(obj([1], 0), 0)
    }
    
    func testRndomPickWeight() {
        let obj = RndomPickWeight([1,3,4,5,2])
        obj.pickIndex()
    }
    
    func testFindMedianSortedArrays() {
        let obj = FindMedianSortedArrays()
//        XCTAssertEqual(obj(Array(1...8), Array(1...4)), 3.5)
        XCTAssertEqual(obj([1,3], [2]), 2.00)
//        XCTAssertEqual(obj(Array(1...8), Array(1...4)), 3.5)
    }
    
    func testTimebasedkeyValueStore() {
        let obj = TimebasedkeyValueStore()
        obj.set("foo", "bar", 1)
        XCTAssertEqual(obj.get("foo", 1), "bar")
        XCTAssertEqual(obj.get("foo", 3), "bar")
        obj.set("foo", "bar2", 4)
        XCTAssertEqual(obj.get("foo", 4), "bar2")
        XCTAssertEqual(obj.get("foo", 5), "bar2")
        
        obj.set("love", "high", 10)
        obj.set("love", "low", 20)
        XCTAssertEqual(obj.get("love", 5), "")
    }
    
    func testKokoEatingBananas() {
        let obj = KokoEatingBananas()
        XCTAssertEqual(obj.minEatingSpeed([3,6,7,11], 8), 4)
        XCTAssertEqual(obj.minEatingSpeed([30,11,23,4,20], 5), 30)
        XCTAssertEqual(obj.minEatingSpeed([30,11,23,4,20], 6), 23)
    }
    
    func testPeakIndexMountainArray() {
        let obj = PeakIndexMountainArray()
        XCTAssertEqual(obj( [3,5,3,2,0]), 1)
        XCTAssertEqual(obj([0,1,0]), 1)
        XCTAssertEqual(obj([0,2,1,0]), 1)
        XCTAssertEqual(obj([0,10,5,2]), 1)
        XCTAssertEqual(obj([3,4,5,1]), 2)
    }
    
    func testFindPeakElement() {
        let obj = FindPeakElement()
        XCTAssertEqual(obj([1,2,3,1]), 2)
        XCTAssertEqual(obj([1,2,1,3,5,6,4]), 5)
    }
    
    func testContainerWithMaxWater() {
        let obj = ContainerWithMaxWater()
        XCTAssertEqual(obj([1,8,6,2,5,4,8,3,7]), 49)
        XCTAssertEqual(obj([1,1]), 1)
        XCTAssertEqual(obj([4,3,2,1,4]), 16)
        XCTAssertEqual(obj([1,2,1]), 2)
    }
    
    func testSqrtx() {
        let obj = Sqrtx()
        XCTAssertEqual(obj.mySqrt(8), 2)
        XCTAssertEqual(obj.mySqrt(4), 2)
    }
    
    func testMaximumRemovals() {
        let obj = MaximumRemovals()
        XCTAssertEqual(obj("abcacb", "ab", [3,1,0]), 2)
        XCTAssertEqual(obj("abcbddddd", "abcd", [3,2,1,4,5,6]), 1)
        XCTAssertEqual(obj("qobftgcueho", "obue", [5,3,0,6,4,9,10,7,2,8]), 7)
    }
    
    func testCapacityToShipPackagesWithInDDays() {
        let obj = CapacityToShipPackagesWithInDDays()
        XCTAssertEqual(obj([1,2,3,4,5,6,7,8,9,10], 5), 15)
    }
}

