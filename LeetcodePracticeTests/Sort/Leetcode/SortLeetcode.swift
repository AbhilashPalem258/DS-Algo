//
//  SortLeetcode.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 13/07/21.
//

import XCTest
@testable import LeetcodePractice

class SortLeetcode: XCTestCase {

    func testMergeSortedArrays(){
        let obj = MergeSortedArrays()
        
        var arr1 = [1,2,3,0,0,0]
        obj.merge(&arr1, 3, [2,5,6], 3)
        XCTAssertEqual(arr1, [1,2,2,3,5,6])
        
        var arr2 = [1]
        obj.merge(&arr2, 1, [], 0)
        XCTAssertEqual(arr2, [1])
    }
    
    func testSortColors() {
        let obj = SortColors()
        
        var arr1 = [2,0,2,1,1,0]
        obj(&arr1)
        XCTAssertEqual(arr1, [0,0,1,1,2,2])
    }
    
    func testWiggleSort() {
        let obj = WiggleSort()
        
        var arr1 = [3, 5, 2, 1, 6, 4]
        obj(&arr1)
        XCTAssertEqual(arr1, [3, 5, 1, 6, 2, 4])
        
        var arr2 = [3, 5, 2, 1, 6, 4]
        obj.oddPositionSort(&arr2)
        XCTAssertEqual(arr2, [3, 5, 1, 6, 2, 4])
        
        var arr3 = [1, 2, 3, 4]
        obj(&arr3)
        XCTAssertEqual(arr3, [1, 3, 2, 4])
        
        var arr4 = [1, 2, 3, 4]
        obj.oddPositionSort(&arr4)
        XCTAssertEqual(arr4, [1, 3, 2, 4])
    }
    
    func testSortedSquaresArr() {
        let obj = SortedSquaresArr()
        XCTAssertEqual(obj([-4,-1,0,3,10]), [0,1,9,16,100])
        XCTAssertEqual(obj([-7,-3,2,3,11]), [4,9,9,49,121])
    }
    
    func testSortTransformedArr() {
        let obj = SortTransformedArr()
        XCTAssertEqual(obj([-4, -2, 2, 4], 1, 3, 5), [3, 9, 15, 33])
        XCTAssertEqual(obj([-4, -2, 2, 4], -1, 3, 5), [-23, -5, 1, 7])
    }
    
    func testMeetingRooms() {
        let obj = MeetingRooms()
        XCTAssertEqual(obj(intervals: [.init(0, 30), .init(5, 10), .init(15, 20)]), false)
        XCTAssertEqual(obj(intervals: [.init(5, 8), .init(9, 15)]), true)
    }

    func testMeetingRoomII() {
        let obj = MeetingRoomII()
        XCTAssertEqual(obj([[1,2],[4,5],[8,10]]), 1)
        XCTAssertEqual(obj([[0,30],[5,10],[15,20]]), 2)
    }
    
    func testMergeIntervals() {
        let obj = MergeIntervals()
        XCTAssertEqual(obj([[1,3],[2,6],[8,10],[15,18]]), [[1,6],[8,10],[15,18]])
        XCTAssertEqual(obj([[1,4],[4,5]]), [[1,5]])
        XCTAssertEqual(obj([[1,4],[2,3]]), [[1,4]])
    }
    
    func testRemoveCoveredIntervals() {
        let obj = RemoveCoveredIntervals()
        XCTAssertEqual(obj([[1,4],[3,6],[2,8]]), 2)
        XCTAssertEqual(obj([[1,4],[2,3]]), 1)
    }
    
    func testFindKthLargest() {
        let obj = FindKthLargest()
//        XCTAssertEqual(obj([3,2,1,5,6,4], 2), 5)
        
        var arr1 = [4,1,2,3,6,5]
        obj.qs(&arr1, l: 0, r: 5)
    }
    
    func testArrayPartitionI() {
        let obj = ArrayPartitionI()
        XCTAssertEqual(obj([1,4,3,2]), 4)
        XCTAssertEqual(obj([6,2,6,5,1,2]), 9)
    }
    
    func testLargestNumber() {
        let obj = LargestNumber()
        XCTAssertEqual(obj([10,2]), "210")
        XCTAssertEqual(obj([1]), "1")
        XCTAssertEqual(obj([10]), "10")
        XCTAssertEqual(obj([3,30,34,5,9]), "9534330")
    }
    
    func testTopKFrequentElements() {
        let obj = TopKFrequentElements()
        XCTAssertEqual(obj([1,1,1,2,2,3], 2), [1,2])
        XCTAssertEqual(obj([1], 1), [1])
    }
    
    func testTopKFrequentWords() {
        let obj = TopKFrequentWords()
        XCTAssertEqual(obj.topKFrequent(["i","love","leetcode","i","love","coding"], 2), ["i","love"])
        XCTAssertEqual(obj.topKFrequent(["i","love","leetcode","i","love","coding"], 3),["i","love","coding"])
    }
}
