//
//  ArrayProblemsTests.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 16/06/21.
//

import XCTest
@testable import LeetcodePractice

class ArrayProblemsTests: XCTestCase {
    
    let arrayProblems = ArrayProblems()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
extension ArrayProblemsTests {
    func testArray953() {
        XCTAssertTrue(arrayProblems.isAlienSorted(["hello","leetcode"], "hlabcdefgijkmnopqrstuvwxyz"))
    }
    
    func testArray905() {
        let result = arrayProblems.sortArrayByParity([3,1,2,4])
        print(result)
    }
    
    func testArray485() {
        XCTAssertEqual(arrayProblems.findMaxConsecutiveOnes([1,1,0,1,1,1,1]), 4)
    }
    
    func testArray475() {
        XCTAssertEqual(arrayProblems.findRadius([1,2,3,4], [1,4]), 1)
    }
}
