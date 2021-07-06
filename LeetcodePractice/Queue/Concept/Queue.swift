//
//  Queue.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 20/06/21.
//

import Foundation

struct Que<T>: QueueProtocol {
    
    private var array: [T] = []
    
    var isEmpty: Bool {
        array.isEmpty
    }
    
    var count: Int {
        array.count
    }
    
    var front: T? {
        array.first
    }
    
    mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
}
