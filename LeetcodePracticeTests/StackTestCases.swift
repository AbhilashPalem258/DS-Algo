//
//  StackTestCases.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 19/06/21.
//

import XCTest
@testable import LeetcodePractice

class StackTestCases: XCTestCase {

    func testSimplifyPath() {
        let simplifyPath = SimplifyPath()
        XCTAssertEqual(simplifyPath.simplifyPath("/home/"), "/home")
        XCTAssertEqual(simplifyPath.simplifyPath("/../"), "/")
        XCTAssertEqual(simplifyPath.simplifyPath("/home//foo/"), "/home/foo")
        XCTAssertEqual(simplifyPath.simplifyPath("/a/./b/../../c/"), "/c")
    }
    
    func testRemoveKDigits() {
        let removeKDigits = RemoveKDigits()
        XCTAssertEqual(removeKDigits("1432219", 3), "1219")
        XCTAssertEqual(removeKDigits("10200", 1), "200")
        XCTAssertEqual(removeKDigits("10", 2), "0")
    }
    
    func testTernaryExpressionParser() {
        let ternaryExpParser = TernaryExpressionParser()
        XCTAssertEqual(ternaryExpParser("T?2:3"), "2")
        XCTAssertEqual(ternaryExpParser("F?1:T?4:5"), "4")
        XCTAssertEqual(ternaryExpParser("T?T?F:5:3"), "F")
    }
    
    func testDecodeString() {
        let decodeString = DecodeString()
        XCTAssertEqual(decodeString("3[a]2[bc]"), "aaabcbc")
        XCTAssertEqual(decodeString("3[a2[c]]"), "accaccacc")
        XCTAssertEqual(decodeString("2[abc]3[cd]ef"), "abcabccdcdcdef")
        XCTAssertEqual(decodeString("abc3[cd]xyz"), "abccdcdcdxyz")
    }
    
    func testBasicCalculator() {
        let basicCalculator = BasicCalculator()
        XCTAssertEqual(basicCalculator("1 + 1"), 2)
        XCTAssertEqual(basicCalculator(" 2-1 + 2 "), 3)
        XCTAssertEqual(basicCalculator("(1+(4+5+2)-3)+(6+8)"), 23)
        XCTAssertEqual(basicCalculator("+48 + -48"), 0)
    }
    
    func testValidParentheses() {
        let validParentheses = ValidParentheses()
        XCTAssertEqual(validParentheses("()[]{}"), true)
        XCTAssertEqual(validParentheses("()"), true)
        XCTAssertEqual(validParentheses("(]"), false)
        XCTAssertEqual(validParentheses("([)]"), false)
        XCTAssertEqual(validParentheses("{[]}"), true)
    }
    
    func testEvaluateReversePolishNotation() {
        let obj = EvaluateReversePolishNotation()
        XCTAssertEqual(obj(["2","1","+","3","*"]), 9)
        XCTAssertEqual(obj(["4","13","5","/","+"]), 6)
        XCTAssertEqual(obj(["10","6","9","3","+","-11","*","/","*","17","+","5","+"]), 22)
    }
    
    func testCarFleet() {
        let obj = CarFleet()
        XCTAssertEqual(obj(12, [10,8,0,5,3], [2,4,1,1,3]), 3)
        XCTAssertEqual(obj(10, [3], [3]), 1)
    }
}
