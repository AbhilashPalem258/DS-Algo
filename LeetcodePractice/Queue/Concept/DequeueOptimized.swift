//
//  Dequeue.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 20/06/21.
//

import Foundation
protocol DequeueProtocol {
    
    associatedtype Element
    
    var isEmpty: Bool {get}
    var count: Int {get}
    var peekFront: Element? { get }
    var peekBack: Element? { get }
    
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
    
    mutating func enqueueFront(_ element: Element)
    mutating func dequeueBack() -> Element?
}

struct DequeueOptimized<T>: DequeueProtocol {
    
    private var capacity: Int
    private let originalCapacity: Int
    private var array: [T?]
    private var head: Int
    
    var isEmpty: Bool {
        count == 0
    }
    
    var count: Int {
        array.count - head
    }
    
    var peekFront: T? {
        array[head]
    }
    
    var peekBack: T? {
        isEmpty ? nil : array.last!
    }
    
    init(capacity: Int) {
        self.capacity = capacity
        self.originalCapacity = capacity
        self.array = [T?](repeating: nil, count: capacity)
        self.head = capacity
    }
    
    mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    mutating func dequeue() -> T? {
        guard count > 0 else {
            return nil
        }
        
        let element = array[head]
        array[head] = nil
        head += 1
        
        if self.capacity >= originalCapacity && head >= capacity * 2 {
            let amountToRemove = capacity + capacity/2
            self.array.removeFirst(amountToRemove)
            head -= amountToRemove
            capacity /= 2
        }
        
        return element
    }
    
    mutating func enqueueFront(_ element: T) {
        if head == 0 {
            self.capacity = self.capacity * 2
            let emptySpace = [T?](repeating: nil, count: capacity)
            self.array.insert(contentsOf: emptySpace, at: 0)
            self.head = capacity
        }
        
        head -= 1
        array[head] = element
    }
    
    mutating func dequeueBack() -> T? {
        isEmpty ? nil : array.removeLast()
    }
}
