//
//  QueueConceptTests.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 20/06/21.
//

import XCTest
@testable import LeetcodePractice

class QueueConceptTests: XCTestCase {
    
    func testQue() {
        testQueue(queue: Que<Int>())
    }
    
    func testOptimizedQueue() {
        testQueue(queue: OptimizedQueue<Int>())
    }
    
    private func testQueue<T: QueueProtocol>(queue:  T) where T.Element == Int {
        var queue = queue
        XCTAssertEqual(queue.count, 0)
        
        queue.enqueue(101)
        XCTAssertEqual(queue.front, 101)
        
        queue.enqueue(102)
        queue.enqueue(103)
        queue.enqueue(104)
        
        XCTAssertEqual(queue.count, 4)
        
        XCTAssertEqual(queue.dequeue(), 101)
        XCTAssertEqual(queue.count, 3)
        
        XCTAssertEqual(queue.dequeue(), 102)
        XCTAssertEqual(queue.count, 2)
        
        XCTAssertEqual(queue.dequeue(), 103)
        XCTAssertEqual(queue.count, 1)
        
        XCTAssertEqual(queue.dequeue(), 104)
        XCTAssertEqual(queue.count, 0)
        
        XCTAssertEqual(queue.dequeue(), nil)
        XCTAssertEqual(queue.count, 0)
    }
    
    func testDequeueOptimized() {
        var queue = DequeueOptimized<Int>(capacity: 5)
        XCTAssertEqual(queue.count, 0)
        
        queue.enqueueFront(101)
        XCTAssertEqual(queue.peekFront, 101)
        
        queue.enqueueFront(102)
        queue.enqueueFront(103)
        queue.enqueueFront(104)
        
        XCTAssertEqual(queue.count, 4)
        
        queue.enqueueFront(100)
        XCTAssertEqual(queue.peekFront, 100)
        XCTAssertEqual(queue.count, 5)
        
        queue.enqueueFront(99)
        XCTAssertEqual(queue.peekFront, 99)
        XCTAssertEqual(queue.count, 6)
        
        XCTAssertEqual(queue.dequeue(), 99)
        XCTAssertEqual(queue.count, 5)

        XCTAssertEqual(queue.dequeue(), 100)
        XCTAssertEqual(queue.count, 4)

        XCTAssertEqual(queue.dequeue(), 104)
        XCTAssertEqual(queue.count, 3)

        XCTAssertEqual(queue.dequeue(), 103)
        XCTAssertEqual(queue.count, 2)
        
        XCTAssertEqual(queue.dequeue(), 102)
        XCTAssertEqual(queue.count, 1)

        XCTAssertEqual(queue.dequeue(), 101)
        XCTAssertEqual(queue.count, 0)
        
        XCTAssertEqual(queue.dequeue(), nil)
        XCTAssertEqual(queue.count, 0)
        
        queue.enqueue(101)
        XCTAssertEqual(queue.peekFront, 101)
        
        queue.enqueue(102)
        queue.enqueue(103)
        queue.enqueue(104)
        
        XCTAssertEqual(queue.dequeueBack(), 104)
        XCTAssertEqual(queue.count, 3)
        
        XCTAssertEqual(queue.dequeueBack(), 103)
        XCTAssertEqual(queue.count, 2)
        
        XCTAssertEqual(queue.dequeueBack(), 102)
        XCTAssertEqual(queue.count, 1)
        
        XCTAssertEqual(queue.dequeueBack(), 101)
        XCTAssertEqual(queue.count, 0)
        
        XCTAssertEqual(queue.dequeueBack(), nil)
        XCTAssertEqual(queue.count, 0)
        
    }
}
