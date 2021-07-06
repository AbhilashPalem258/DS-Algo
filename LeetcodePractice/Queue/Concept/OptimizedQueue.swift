//
//  OptimizedQueue.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 20/06/21.
//

import Foundation

struct OptimizedQueue<T>: QueueProtocol {
    private var head = 0
    private var array = [T?]()
    
    var isEmpty: Bool {
        count == 0
    }
    
    var count: Int {
        array.count - head
    }
    
    var front: T? {
        array[head]
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
        
        let percentage = Double(head)/Double(array.count)
        if percentage > 0.25 && array.count >= 50 {
            array.removeFirst(head)
            head = 0
        }
        
        return element
    }
}
