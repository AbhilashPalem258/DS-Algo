//
//  LLLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 22/06/21.
//

import Foundation

//Link: https://leetcode.com/problems/rotate-list/

class RotateLL {
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard head != nil else {
            return nil
        }
        let k = k % getLength(node: head)
        
        var slowPointer = head
        var fastPointer = head
        
        for _ in 1...k {
            fastPointer = fastPointer?.next
        }
        
        while fastPointer?.next != nil {
            slowPointer = slowPointer?.next
            fastPointer = fastPointer?.next
        }
        
        fastPointer?.next = head
        let head = slowPointer?.next
        slowPointer?.next = nil
        
        return head
    }
    
    func getLength(node: ListNode?) -> Int {
        var node = node
        var count = 0
        while node != nil {
            count += 1
            node = node?.next
        }
        return count
    }
}
