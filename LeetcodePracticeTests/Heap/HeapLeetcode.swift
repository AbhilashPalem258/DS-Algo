//
//  HeapLeetcode.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 24/02/22.
//

import XCTest
@testable import LeetcodePractice

class HeapLeetcode: XCTestCase {
    func testLongestHappyString() {
        let obj = LongestHappyString()
        XCTAssertEqual(obj(1, 1, 7), "ccaccbcc")
        XCTAssertEqual(obj(7, 1, 0),"aabaa")
    }
    
    func testMedianFinder() {
        let obj = MedianFinder()
        obj.addNum(1)
        obj.addNum(2)
        XCTAssertEqual(obj.findMedian(), 1.5)
        obj.addNum(3)
        XCTAssertEqual(obj.findMedian(), 2.0)
    }
    
    func testKthLargestElementInAStream() {
        let obj = KthLargestElementInAStream(3, [4, 5, 8, 2])
        XCTAssertEqual(obj.add(3), 4)
        XCTAssertEqual(obj.add(5), 5)
        XCTAssertEqual(obj.add(10), 5)
        XCTAssertEqual(obj.add(9), 8)
        XCTAssertEqual(obj.add(4), 8)
    }
    
    func testSortCharactersByFrequency() {
        let obj = SortCharactersByFrequency()
        XCTAssertEqual(obj("tree"), "eert")
    }
    
    func testKclosestPointsToOrigin() {
        let obj = KclosestPointsToOrigin()
        XCTAssertEqual(obj([[1,3],[-2,2]], 1), [[-2,2]])
        XCTAssertEqual(obj([[3,3],[5,-1],[-2,4]], 2), [[-2,4],[3,3]])
    }
    
    func testReorganizeString() {
        let obj = ReorganizeString()
        XCTAssertEqual(obj("aab"), "aba")
        XCTAssertEqual(obj("aaab"), "")
    }
    
    func testDesignTwitter() {
        let twitter = DesignTwitter()
        twitter.postTweet(1, 5)
        XCTAssertEqual(twitter.getNewsFeed(1), [5])
        twitter.follow(1, 2)
        twitter.postTweet(2, 6)
        XCTAssertEqual(twitter.getNewsFeed(1), [6, 5])
        twitter.unfollow(1, 2)
        XCTAssertEqual(twitter.getNewsFeed(1), [5])
    }
    
    func testMinimumNumberOfRefuelingStops() {
        let obj = MinimumNumberOfRefuelingStops()
        XCTAssertEqual(obj(1, 1, []), 0)
        XCTAssertEqual(obj(100, 1, [[10, 100]]), -1)
        XCTAssertEqual(obj(100, 10, [[10,60],[20,30],[30,30],[60,40]]), 2)
    }
    
    func testFindKSmallestPairs() {
        let obj = FindKSmallestPairs()
        XCTAssertEqual(obj([1,7,11], [2,4,6], 3), [[1,2],[1,4],[1,6]])
    }
}
