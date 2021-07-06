//
//  QueueLeetcodeTests.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 20/06/21.
//

import Foundation

import XCTest
@testable import LeetcodePractice

class QueueLeetcodeTests: XCTestCase {
    func testQueueWithStack() {
        let queueWithStack = MyQueue()
        
        queueWithStack.push(1); // queue is: [1]
        XCTAssertEqual(queueWithStack.peek(), 1)
        
        queueWithStack.push(2); // queue is: [1, 2] (leftmost is front of the queue)
        XCTAssertEqual(queueWithStack.peek(), 1)

        XCTAssertEqual(queueWithStack.pop(), 1) // return 1, queue is [2]
        XCTAssertFalse(queueWithStack.empty()) // return false
    }
}
