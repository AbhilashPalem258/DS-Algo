//
//  Leetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 20/06/21.
//

import Foundation

class MyQueue {
    
    var popStack: [Int]
    var pushStack: [Int]

    /** Initialize your data structure here. */
    init() {
        popStack = [Int]()
        pushStack = [Int]()
    }
    
    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        pushStack.append(x)
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        if popStack.isEmpty { moveItemsFromPushStackToPop() }
        return popStack.isEmpty ? -1 : popStack.removeLast()
    }
    
    /** Get the front element. */
    func peek() -> Int {
        if popStack.isEmpty { moveItemsFromPushStackToPop() }
        return popStack.isEmpty ? -1 : popStack.last!
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        popStack.isEmpty && pushStack.isEmpty
    }
    
    private func moveItemsFromPushStackToPop() {
        while !pushStack.isEmpty {
            popStack.append(pushStack.removeLast())
        }
    }
}
