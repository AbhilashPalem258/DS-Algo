//
//  SlidingWindowLeetcode.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 22/02/22.
//

import XCTest
@testable import LeetcodePractice

class SlidingWindowLeetcode: XCTestCase {

    func testFindAllAnagramsInString() {
        let obj = FindAllAnagramsInString()
        XCTAssertEqual(obj("cbaebabacd", "abc"), [0, 6])
        XCTAssertEqual(obj("abab", "ab"), [0, 1, 2])
    }
    
    func testLengthOfLongestSubstring() {
        let obj = LengthOfLongestSubstringWithOutRepeatingChar()
        XCTAssertEqual(obj("abba"), 2)
        XCTAssertEqual(obj("abcabcbb"), 3)
        XCTAssertEqual(obj("bbbbb"), 1)
        XCTAssertEqual(obj("pwwkew"), 3)
    }
    
    func testSlidingWindowMaximum() {
        let obj = MaxSlidingWindow()
        XCTAssertEqual(obj([1,3,-1,-3,5,3,6,7], 3), [3,3,5,5,6,7])
        XCTAssertEqual(obj([1], 1), [1])
        XCTAssertEqual(obj([1,-1], 1), [1,-1])
        XCTAssertEqual(obj([7,2,4], 2), [7,4])
    }
    
    func testLongestSubstringWithAtmost2DistinctChar() {
        let obj = LongestSubstringWithAtmost2DistinctChar()
        XCTAssertEqual(obj(s: "eceba"), 3)
        XCTAssertEqual(obj(s: "aaa"), 3)
    }
    
    func testLongestSubstringWithAtmostKDistinctChar() {
        let obj = LongestSubstringWithAtmostKDistinctChar()
        XCTAssertEqual(obj(s: "eceba", k: 3), 4)
        XCTAssertEqual(obj(s: "WORLD", k: 4), 4)
    }
    
    func testFrequencyOfTheMostFrequentElement() {
        let obj = FrequencyOfTheMostFrequentElement()
        XCTAssertEqual(obj([1,2,4], 5), 3)
        XCTAssertEqual(obj([1,4,8,13], 5), 2)
        XCTAssertEqual(obj([3,9,6], 2), 1)
    }
    
    func testPermutationInString() {
        let obj = PermutationInString()
        XCTAssertEqual(obj("ab", "eidbaooo"), true)
        XCTAssertEqual(obj("ab", "eidboaoo"), false)
    }
    
    func testMinFlipsToMakeBinaryStringAlternating() {
        let obj = MinFlipsToMakeBinaryStringAlternating()
        XCTAssertEqual(obj("111000"), 2)
        XCTAssertEqual(obj("010"), 0)
        XCTAssertEqual(obj("1110"), 1)
    }
    
    func testMInSizeSubarraySum() {
        let obj = MInSizeSubarraySum()
        XCTAssertEqual(obj(7, [2,3,1,2,4,3]), 2)
        XCTAssertEqual(obj(11, [1,1,1,1,1,1,1,1]), 0)
        XCTAssertEqual(obj(11, [1,2,3,4,5]), 3)
    }
}
