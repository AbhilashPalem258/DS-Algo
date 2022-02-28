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

/*
 problem:
 Given the head of a linked list, return the list after sorting it in ascending order.
 
 Testcases:
 Input: head = [4,2,1,3]
 Output: [1,2,3,4]
 
 Input: head = [-1,5,3,4,0]
 Output: [-1,0,3,4,5]
 
 Input: head = []
 Output: []
 
 Constraints:
 The number of nodes in the list is in the range [0, 5 * 104].
 -105 <= Node.val <= 105
 
 
 link: https://leetcode.com/problems/sort-list/
 explanation: https://www.youtube.com/watch?v=TGveA1oFhrc
 primary idea:
 - Split Linkedlist into 2 by splitting from mid
 - Merge sort
 Time Complexity:
 Space Complexity: 
 */
class SortList {
    func sortList(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        
        var slow = head, fast = head, prev: ListNode? = ListNode(-1)

        while fast != nil || fast?.next != nil {
            prev = slow
            slow = slow?.next
            fast = fast?.next?.next
        }
        prev?.next = nil
        
        let leftSortList = sortList(head)
        let rightSortList = sortList(slow)
        return merge(left: leftSortList, right: rightSortList)
    }
    
    func merge(left: ListNode?, right: ListNode?) -> ListNode? {
        let dummy: ListNode? = ListNode(0)
        var current = dummy
        var currentleft = left, currentRight = right
        while currentleft != nil && currentRight != nil {
            if currentleft!.val < currentRight!.val {
                current?.next = currentleft
                currentleft = currentleft!.next
            } else {
                current?.next = currentRight
                currentRight = currentRight?.next
            }
            current = current?.next
        }
        if currentleft != nil {
            current?.next = currentleft
        }
        if currentRight != nil {
            current?.next = currentRight
        }
        return dummy?.next
    }
}

class ReverseKGroup {
    func callAsFunction(_ head: ListNode?, _ k: Int) -> ListNode? {
        let dummy: ListNode? = ListNode(-1)
        dummy?.next = head
        var groupPrev = dummy
        
        func getKthNode(node: ListNode?) -> ListNode? {
            var k = k, current = node
            while current != nil && k > 0 {
                current = current?.next
                k -= 1
            }
            return current
        }
        
        while true {
            let kthNode = getKthNode(node: groupPrev)
            if kthNode == nil {
                break
            }
            let groupNext = kthNode?.next
            
            var prev = kthNode?.next, current = groupPrev?.next
            while current !== groupNext {
                let tmp = current?.next
                current?.next = prev
                prev = current
                current = tmp
            }
            
            let tmp = groupPrev?.next
            groupPrev?.next = kthNode
            groupPrev = tmp
        }
        return dummy?.next
    }
}

class FindDuplicateNumber {
    func callAsFunction(_ nums: [Int]) -> Int {
        var slow = 0, fast = 0
        while true {
            slow = nums[slow]
            fast = nums[nums[fast]]
            if slow == fast {
                break
            }
        }
        
        var slow2 = 0
        while true {
            slow = nums[slow]
            slow2 = nums[slow2]
            if slow == slow2 {
                break
            }
        }
        return slow
    }
}

/*
 problem:
 Given the heads of two singly linked-lists headA and headB, return the node at which the two lists intersect. If the two linked lists have no intersection at all, return null.
 
 Testcases:
 Input: intersectVal = 8, listA = [4,1,8,4,5], listB = [5,6,1,8,4,5], skipA = 2, skipB = 3
 Output: Intersected at '8'
 Explanation: The intersected node's value is 8 (note that this must not be 0 if the two lists intersect).
 From the head of A, it reads as [4,1,8,4,5]. From the head of B, it reads as [5,6,1,8,4,5]. There are 2 nodes before the intersected node in A; There are 3 nodes before the intersected node in B.
 
 Input: intersectVal = 2, listA = [1,9,1,2,4], listB = [3,2,4], skipA = 3, skipB = 1
 Output: Intersected at '2'
 Explanation: The intersected node's value is 2 (note that this must not be 0 if the two lists intersect).
 From the head of A, it reads as [1,9,1,2,4]. From the head of B, it reads as [3,2,4]. There are 3 nodes before the intersected node in A; There are 1 node before the intersected node in B.
 
 Input: intersectVal = 0, listA = [2,6,4], listB = [1,5], skipA = 3, skipB = 2
 Output: No intersection
 Explanation: From the head of A, it reads as [2,6,4]. From the head of B, it reads as [1,5]. Since the two lists do not intersect, intersectVal must be 0, while skipA and skipB can be arbitrary values.
 Explanation: The two lists do not intersect, so return null.
 
 
 Constraints:
 The number of nodes of listA is in the m.
 The number of nodes of listB is in the n.
 1 <= m, n <= 3 * 104
 1 <= Node.val <= 105
 0 <= skipA < m
 0 <= skipB < n
 intersectVal is 0 if listA and listB do not intersect.
 intersectVal == listA[skipA] == listB[skipB] if listA and listB intersect.
 
 
 link: https://leetcode.com/problems/intersection-of-two-linked-lists/
 explanation: https://www.youtube.com/watch?v=D0X0BONOQhI
 primary idea:
 - l1 pointer iterating through both linkedlists one after another and l2 pointer iterating through both linkedlists intersects at end of second linkedlist
 - 5 + 6 == 6 + 5
 - Once a pointer completes long linkedlist and starts iterating through small linkedlist will always intersect with other pointer at some point
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */

class IntersectionOfTwoLinkedLists {
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        var l1 = headA, l2 = headB
        while l1 !== l2 {
            l1 = l1 != nil ? l1?.next : headB
            l2 = l2 != nil ? l2?.next : headA
        }
        return l1
    }
}

class InsertionSortList {
    func callAsFunction(_ head: ListNode?) -> ListNode? {
        if head == nil {
            return head
        }
        let dummy = ListNode(-1, head)
        
        var prev = head, current = head!.next
        while let cur = current {
            if cur.val < prev!.val {
                var tmp: ListNode? = dummy
                while tmp!.next!.val < cur.val {
                    tmp = tmp?.next
                }
                
                prev?.next = cur.next
                cur.next = tmp?.next
                tmp?.next = cur
            }
            
            prev = current
            current = cur.next
        }
        
        return dummy.next
    }
}
