//
//  IntervalsLeetcodeTests.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 28/09/24.
//

@testable import LeetcodePractice
import XCTest

final class IntervalsLeetcodeTests: XCTestCase {
    func testMinimumNumberOfArrowsToBurstBalloons() {
        let obj = MinimumNumberOfArrowsToBurstBalloons()
        XCTAssertEqual(obj([[10,16],[2,8],[1,6],[7,12]]), 2)
    }
}
