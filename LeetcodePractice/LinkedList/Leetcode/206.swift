//
//  206.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 17/06/21.
//

//link: https://leetcode.com/problems/reverse-linked-list/

import Foundation

public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init() { self.val = 0; self.next = nil; }
     public init(_ val: Int) { self.val = val; self.next = nil; }
     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}
extension ListNode: Equatable {
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        lhs.val == rhs.val
    }
}

class LL206 {
   func reverseList(_ head: ListNode?) -> ListNode? {
        var prev: ListNode?
        var current = head
        while !current.isNil {
            let next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        return prev
    }
    
    func reverseListRecursive(_ head: ListNode?) -> ListNode? {
        guard let current = head, let next = current.next else {
            return head
        }
        let node = reverseListRecursive(next)
        next.next = current
        current.next = nil
        return node
    }
}
