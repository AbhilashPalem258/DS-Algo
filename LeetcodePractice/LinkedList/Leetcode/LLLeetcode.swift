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


class CopyRandomList {
    
    public class Node {
         public var val: Int
         public var next: Node?
         public var random: Node?
         public init(_ val: Int) {
             self.val = val
             self.next = nil
               self.random = nil
         }
     }
    
    func callAsFunction(_ head: CopyRandomList.Node?) -> CopyRandomList.Node? {
        guard let _ = head else {
            return head
        }
        var oldToNew = [CopyRandomList.Node: CopyRandomList.Node]()
        
        var current: CopyRandomList.Node? = head
        while let node = current {
            oldToNew[node] = CopyRandomList.Node(node.val)
            current = node.next
        }
        
        current = head
        while let node = current {
            let clone = oldToNew[node]
            if let next = node.next {
                clone?.next = oldToNew[next]
            }
            if let random = node.random {
                clone?.random = oldToNew[random]
            }
            current = node.next
        }
        
        return oldToNew[head!]
    }
}
extension CopyRandomList.Node: Hashable {
    static func == (lhs: CopyRandomList.Node, rhs: CopyRandomList.Node) -> Bool {
        lhs.val == rhs.val
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(val)
        hasher.combine(next)
        hasher.combine(random)
    }
}
