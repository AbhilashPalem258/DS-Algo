//
//  MaxStack.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 19/06/21.
//

import Foundation

class MaxStack {
    var stack: [Int]
    var maxStack: [Int]

    /** initialize your data structure here. */
    init() {
        stack = [Int]()
        maxStack = [Int]()
    }
    
    func push(_ x: Int) {
        stack.append(x)
        maxStack.append(maxStack.isEmpty ? x : max(x, maxStack.last!))
    }
    
    @discardableResult
    func pop() -> Int {
        maxStack.removeLast()
        return stack.removeLast()
    }
    
    func top() -> Int {
        return stack.last!
    }
    
    func peekMax() -> Int {
        return maxStack.last!
    }
    
    func popMax() -> Int {
        let maxVal = peekMax()
        
        // remove max from stack
        var buffer = [Int]()
        while top() != maxVal {
            buffer.append(pop())
        }
        pop()
        while !buffer.isEmpty {
            push(buffer.removeLast())
        }
        
        return maxVal
    }
}
