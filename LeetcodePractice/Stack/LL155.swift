//
//  LL155.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 18/06/21.
//

import Foundation

class MinStack {

    var minStack: [Int]
    var stack: [Int]
    
    init() {
        self.minStack = []
        self.stack = []
    }
    
    func push(_ val: Int) {
        self.stack.append(val)
        if minStack.isEmpty || val <= minStack.last! {
            self.minStack.append(val)
        }
    }
    
    func pop() {
        guard !stack.isEmpty else {
            return
        }
        let popVal = stack.removeLast()
        if let last = minStack.last, last == popVal {
            minStack.removeLast()
        }
    }
    
    func top() -> Int {
        return stack.isEmpty ? -1 : stack.last!
    }
    
    func getMin() -> Int {
        return minStack.isEmpty ? -1 : minStack.last!
    }
}
