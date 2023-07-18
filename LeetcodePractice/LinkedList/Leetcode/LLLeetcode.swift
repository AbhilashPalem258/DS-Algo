//
//  LLLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 22/06/21.
//

import Foundation

//Link: https://leetcode.com/problems/rotate-list/

/*
 NOTE:
 use this when we slow pointer to stop exactly after middle
 
 var slow = head
 var fast = head
 
 while fast != nil {
     slow = slow?.next
     fast = fast?.next?.next
 }
 */

/*
 NOTE:
 use this when we slow pointer to stop exactly before middle
 
 https://www.youtube.com/watch?v=S5bfdUTrKLM
 
 var slow = head
 var fast = head.next
 
 while fast != nil && fast.next != nil {
     slow = slow?.next
     fast = fast?.next?.next
 }
 */

/*
 problem:
 You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

 You may assume the two numbers do not contain any leading zero, except the number 0 itself.
 
 Testcases:
 Input: l1 = [2,4,3], l2 = [5,6,4]
 Output: [7,0,8]
 Explanation: 342 + 465 = 807.
 
 Input: l1 = [0], l2 = [0]
 Output: [0]
 
 Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
 Output: [8,9,9,9,0,0,0,1]
 
 Constraints:
 The number of nodes in each linked list is in the range [1, 100].
 0 <= Node.val <= 9
 It is guaranteed that the list represents a number that does not have leading zeros.
 
 link: https://leetcode.com/problems/plus-one/
 explanation: https://www.youtube.com/watch?v=wgFPrzTjm7s
 primary idea:
 - create a dummy node, update the carry and addd the result node to dummy linked list
 Time Complexity: O(MAX(N, M)) where N and M are the lengths of l1 and l2
 Space Complexity: O(MAX(N, M)) for the length of the new list
 */

class AddTwoNumbers {
    func callAsFunction(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let dummy = ListNode(0)
        var current = dummy
        var firstLNode = l1, secondLNode = l2, carry = 0
        
        while firstLNode != nil || secondLNode != nil {
            
            let firstVal = firstLNode?.val ?? 0, secondVal = secondLNode?.val ?? 0
            let sum = firstVal + secondVal + carry

            current.next = ListNode(sum%10)
            current = current.next!
            carry = sum/10
            
            firstLNode = firstLNode?.next
            secondLNode = secondLNode?.next
        }
        if carry > 0 {
            current.next = ListNode(carry)
        }
        return dummy.next
    }
}

class ReverseLinkedList {
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

/*
 problem:
 Given the head of a singly linked list, return true if it is a palindrome.
 
 Testcases:
 Input: head = [1,2,2,1]
 Output: true
 
 Input: head = [1,2]
 Output: false
 
 Constraints:
 The number of nodes in the list is in the range [1, 105].
 0 <= Node.val <= 9
 
 link: https://leetcode.com/problems/palindrome-linked-list/
 explanation: Neetcode
 primary idea:
 - Divide linkedlist in to two parts
 - Reverse second linkedlist
 - Check if all elements in first and second list are same
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class PalindromeLinkedList {
    func callAsFunction(_ head: ListNode?) -> Bool {
        var slow = head
        var fast = head?.next
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        func reverse(_ head: ListNode?) -> ListNode? {
            var prev: ListNode? = nil, current = head
            while let cur = current {
                let next = cur.next
                cur.next = prev
                prev = cur
                current = next
            }
            return prev
        }
        
        var right = reverse(slow?.next), left = head
        slow?.next = nil
        while right != nil {
            if left?.val != right?.val {
                return false
            }
            right = right?.next
            left = left?.next
        }
        
        return true
    }
}


/*
 problem:
 Given a linked list, swap every two adjacent nodes and return its head. You must solve the problem without modifying the values in the list's nodes (i.e., only nodes themselves may be changed.)
 
 Testcases:
 Input: head = [1,2,3,4]
 Output: [2,1,4,3]

 Input: head = []
 Output: []

 Input: head = [1]
 Output: [1]
 
 Constraints:
 The number of nodes in the list is in the range [0, 100].
 0 <= Node.val <= 100
 

 link: https://leetcode.com/problems/swap-nodes-in-pairs/
 explanation:
 primary idea:
 - We need prev, current, next and post node to swap adjacent nodes at each level
 - We can only swap if we have current and next nodes.
 Time Complexity: O(n)
 Space Complexity: O(1)
 */
class SwapNodesInPairs {
    func callAsFunction(_ head: ListNode?) -> ListNode? {
        let dummy: ListNode? = ListNode(-1)
        dummy?.next = head
        
        var prev = dummy, current = dummy?.next
        while current != nil && current?.next != nil {
            let next = current?.next
            let post = next?.next
            
            prev?.next = next
            next?.next = current
            current?.next = post
            
            prev = current
            current = post
        }
        return dummy?.next
    }
}

/*
 problem:
 Given the head of a linked list and an integer val, remove all the nodes of the linked list that has Node.val == val, and return the new head.
 
 Testcases:
 Input: head = [1,2,6,3,4,5,6], val = 6
 Output: [1,2,3,4,5]

 Input: head = [], val = 1
 Output: []

 Input: head = [7,7,7,7], val = 7
 Output: []
 
 Constraints:
 The number of nodes in the list is in the range [0, 104].
 1 <= Node.val <= 50
 0 <= val <= 50
 
 link: https://leetcode.com/problems/remove-linked-list-elements/
 explanation: https://www.youtube.com/watch?v=zx5Sw9130L0&list=PLot-Xpze53letfIu9dMzIIO7na_sqvl0w&index=5
 primary idea:
 - Use stack and as soon as the current height is lower than earlier, pop all last height's in stack which are higher than current one. calculate area and modify maxArea if needed. After Iteration, check if stack is empty. if not calculate maxArea with all stack elementss
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class RemoveLinkedListElements {
    func callAsFunction(_ head: ListNode?, _ val: Int) -> ListNode? {
        let dummy = ListNode(-1)
        dummy.next = head
        
        var prev = dummy, current = head
        while let cur = current {
            let next = cur.next
            
            if cur.val == val {
                prev.next = next
            } else {
                prev = cur
            }
            current = next
        }
        
        return dummy.next
    }
}


class RemoveDuplicatesFromSortedLinkedList {
    func callAsFunction(_ head: ListNode?) -> ListNode? {
        var prev: ListNode? = nil
        var current = head
        
        while let cur = current {
            let next = cur.next
            if cur.val == prev?.val {
                prev?.next = next
            } else {
                prev = current
            }
            current = next
        }
        return head
    }
}


class RemoveDuplicatesFromSortedLinkedListII {
    func callAsFunction(_ head: ListNode?) -> ListNode? {
        let dummy = head
        dummy?.next = head
        
        var prev = dummy, current = head
        while let cur = current {
            let next = cur.next
            let post = next?.next
            
            if current?.val == next?.val {
                prev?.next = post
                current = post
            } else {
                prev = current
                current = next
            }
        }
        return dummy?.next
    }
}

class RemoveNthNodeFromEndOfList {
    func callAsFunction(_ head: ListNode?, _ n: Int) -> ListNode? {
        let dummy: ListNode? = ListNode(-1)
        dummy?.next = head
        
        var slow = dummy, fast = dummy
        for _ in 1...n {
            fast = fast?.next
        }
        
        while fast?.next != nil {
            slow = slow?.next
            fast = fast?.next
        }
        
        slow?.next = slow?.next?.next
        return dummy?.next
    }
}

/*
 problem:
 Given an array of integers heights representing the histogram's bar height where the width of each bar is 1, return the area of the largest rectangle in the histogram.
 
 Testcases:
 Input: heights = [2,1,5,6,2,3]
 Output: 10
 Explanation: The above is a histogram where width of each bar is 1.
 The largest rectangle is shown in the red area, which has an area = 10 units.
 
 Input: heights = [2,4]
 Output: 4
 
 
 Constraints:
 1 <= heights.length <= 105
 0 <= heights[i] <= 104
 
 
 link: https://leetcode.com/problems/largest-rectangle-in-histogram/
 explanation: https://www.youtube.com/watch?v=zx5Sw9130L0&list=PLot-Xpze53letfIu9dMzIIO7na_sqvl0w&index=5
 primary idea:
 - Use stack and as soon as the current height is lower than earlier, pop all last height's in stack which are higher than current one. calculate area and modify maxArea if needed. After Iteration, check if stack is empty. if not calculate maxArea with all stack elementss
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class OddEvenLinkedList {
    func callAsFunction(_ head: ListNode?) -> ListNode? {
        var odd = head
        var even = head?.next
        let evenHead = even
        
        while even != nil && even?.next != nil {
            odd?.next = even?.next
            odd = odd?.next
            even?.next = odd?.next
            even = even?.next
        }
        odd?.next = evenHead
        
        return head
    }
}

class RotateLinkedList {
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

/*
 problem:
 You are given the head of a singly linked-list. The list can be represented as:

 L0 → L1 → … → Ln - 1 → Ln
 Reorder the list to be on the following form:

 L0 → Ln → L1 → Ln - 1 → L2 → Ln - 2 → …
 You may not modify the values in the list's nodes. Only nodes themselves may be changed.
 
 Testcases:
 Input: head = [1,2,3,4]
 Output: [1,4,2,3]

 Input: head = [1,2,3,4,5]
 Output: [1,5,2,4,3]
 
 Constraints:
 The number of nodes in the list is in the range [1, 5 * 104].
 1 <= Node.val <= 1000
 
 link: https://leetcode.com/problems/reorder-list/
 explanation: https://www.youtube.com/watch?v=S5bfdUTrKLM
 primary idea:
 - Divide LinkedList in to two
 - Reverse second list
 - Merge two list based on ordering
 Time Complexity: O(n)
 Space Complexity: O(1)
 */
class ReorderLinkedList {
    func callAsFunction(_ head: ListNode?) {
        func reverse(head: ListNode?) -> ListNode? {
            var prev: ListNode? = nil
            var current = head
            while let cur = current {
                let next = cur.next
                cur.next = prev
                prev = current
                current = next
            }
            return prev
        }
        
        func mergeLists(list1: ListNode?, list2: ListNode?) {
            var l1Node = list1, l2Node = list2
            while l2Node != nil {
                let nextL1 = l1Node?.next
                let nextL2 = l2Node?.next
                l1Node?.next = l2Node
                l2Node?.next = nextL1
                l1Node = nextL1
                l2Node = nextL2
            }
        }
        
        var slow = head, fast = head?.next
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        let tmp = slow?.next
        slow?.next = nil
        let left = head, right = reverse(head: tmp)
        mergeLists(list1: left, list2: right)
    }
}


class MergeTwoSortedLists {
    func callAsFunction(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        let dummy: ListNode? = ListNode(-1)
        var current = dummy
        
        var l1Node = list1, l2Node = list2
        
        while l1Node != nil && l2Node != nil {
            if l1Node!.val < l2Node!.val {
                current?.next = l1Node
                l1Node = l1Node?.next
            } else {
                current?.next = l2Node
                l2Node = l2Node?.next
            }
            current = current?.next
        }
        
        current?.next = l1Node ?? l2Node
        
        return dummy?.next
    }
}

/*
 problem:
 You are given an array of k linked-lists lists, each linked-list is sorted in ascending order.

 Merge all the linked-lists into one sorted linked-list and return it.
 
 Testcases:
 Input: lists = [[1,4,5],[1,3,4],[2,6]]
 Output: [1,1,2,3,4,4,5,6]
 Explanation: The linked-lists are:
 [
   1->4->5,
   1->3->4,
   2->6
 ]
 merging them into one sorted list:
 1->1->2->3->4->4->5->6

 Input: lists = []
 Output: []

 Input: lists = [[]]
 Output: []
 
 
 Constraints:
 k == lists.length
 0 <= k <= 104
 0 <= lists[i].length <= 500
 -104 <= lists[i][j] <= 104
 lists[i] is sorted in ascending order.
 The sum of lists[i].length will not exceed 104
 
 
 link: https://leetcode.com/problems/merge-k-sorted-lists/
 explanation:
 primary idea:
 - Two pointer, left starts at 0 and right starts at last. We merge those lists an place it in left position in array until left < right. Recursion, again start from left = 0, right is at place earlier.
 - merge sort
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class MergeKSortedLists {
    func callAsFunction(_ lists: [ListNode?]) -> ListNode? {
        if lists.isEmpty {
            return nil
        }
        var left = 0, right = lists.count - 1, lists = lists
        
        while right > 0 {
            left = 0
            while left < right {
                lists[left] = mergeTwoSortedLists(lists[left], lists[right])
                left += 1
                right -= 1
            }
        }
        
        return lists[0]
    }
    
    func mergeTwoSortedLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        let dummy: ListNode? = ListNode(-1)
        var current = dummy
        var l1Node = list1, l2Node = list2
        while l1Node != nil && l2Node != nil {
            if l1Node!.val < l2Node!.val {
                current?.next = l1Node
                l1Node = l1Node?.next
            } else {
                current?.next = l2Node
                l2Node = l2Node?.next
            }
            current = current?.next
        }
        current?.next = l1Node ?? l2Node
        return dummy?.next
    }
}

/*
 problem:
 Given the head of a linked list and a value x, partition it such that all nodes less than x come before nodes greater than or equal to x.

 You should preserve the original relative order of the nodes in each of the two partitions.
 
 Testcases:
 Input: head = [1,4,3,2,5,2], x = 3
 Output: [1,2,2,4,3,5]

 Input: head = [2,1], x = 2
 Output: [1,2]
 
 Constraints:
 The number of nodes in the list is in the range [0, 200].
 -100 <= Node.val <= 100
 -200 <= x <= 200
 
 link: https://leetcode.com/problems/partition-list/
 explanation:
 primary idea:
 - create two linked lists. one for values less than x and one for values >= x.
 - Use dummy node to keep track of starting point of list's
 - Merge it.
 Time Complexity: O(n)
 Space Complexity: O(1)
 */
class PartitionList {
    func callAsFunction(_ head: ListNode?, _ x: Int) -> ListNode? {
        let leftDummy: ListNode? = ListNode(-1), rightDummy: ListNode? = ListNode(-1)
        var left = leftDummy, right = rightDummy
        
        var current = head
        while let cur = current {
            if cur.val < x {
                left?.next = cur
                left = left?.next
            } else {
                right?.next = cur
                right = right?.next
            }
            current = cur.next
        }
        right?.next = nil
        left?.next = rightDummy?.next
        return leftDummy?.next
    }
}


/*
 problem:
 Design a data structure that follows the constraints of a Least Recently Used (LRU) cache.

 Implement the LRUCache class:

 LRUCache(int capacity) Initialize the LRU cache with positive size capacity.
 int get(int key) Return the value of the key if the key exists, otherwise return -1.
 void put(int key, int value) Update the value of the key if the key exists. Otherwise, add the key-value pair to the cache. If the number of keys exceeds the capacity from this operation, evict the least recently used key.
 The functions get and put must each run in O(1) average time complexity.
 
 Testcases:
 Input
 ["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
 [[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
 Output
 [null, null, null, 1, null, -1, null, -1, 3, 4]

 Explanation
 LRUCache lRUCache = new LRUCache(2);
 lRUCache.put(1, 1); // cache is {1=1}
 lRUCache.put(2, 2); // cache is {1=1, 2=2}
 lRUCache.get(1);    // return 1
 lRUCache.put(3, 3); // LRU key was 2, evicts key 2, cache is {1=1, 3=3}
 lRUCache.get(2);    // returns -1 (not found)
 lRUCache.put(4, 4); // LRU key was 1, evicts key 1, cache is {4=4, 3=3}
 lRUCache.get(1);    // return -1 (not found)
 lRUCache.get(3);    // return 3
 lRUCache.get(4);    // return 4
 
 
 Constraints:
 1 <= capacity <= 3000
 0 <= key <= 104
 0 <= value <= 105
 At most 2 * 105 calls will be made to get and put
 
 
 link: https://leetcode.com/problems/lru-cache/
 explanation:
 primary idea:
 - Use a hashmap to access elements and insert in O(1)
 - Use a linkedlist and the node after head will be the LRU Node
 - we also keep track of tail node, just in case if we need to minimize elements if sized more than capacity
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class LRUCache {
    
    class LRUNode {
        let key: Int
        var val: Int
        
        var prev: LRUNode?
        var next: LRUNode?
        
        init(key: Int, value: Int) {
            self.key = key
            self.val = value
        }
    }
    
    let capacity: Int
    let head = LRUNode(key: 0, value: 0)
    let tail = LRUNode(key: 0, value: 0)
    private var cache: [Int: LRUNode]

    init(_ capacity: Int) {
        self.capacity = capacity
        self.head.next = tail
        self.tail.prev = self.head
        cache = [:]
    }
    
    func get(_ key: Int) -> Int {
        if let node = cache[key] {
            remove(key: key)
            insert(node)
            
            return node.val
        }
        return -1
    }
    
    func put(_ key: Int, _ value: Int) {
        if let existingNode = cache[key] {
            existingNode.val = value
            remove(key: key)
            insert(existingNode)
            return
        }
        let new = LRUNode(key: key, value: value)
        insert(new)
        if cache.count > capacity, let tailPrevKey = tail.prev?.key {
            remove(key: tailPrevKey)
        }
    }
    
    private func remove(key: Int) {
        if let node = cache.removeValue(forKey: key) {
            node.prev?.next = node.next
            node.next?.prev = node.prev
            node.prev = nil
            node.next = nil
        }
    }
    
    private func insert(_ node: LRUNode) {
        cache[node.key] = node
        node.next = head.next
        node.prev = head
        head.next?.prev = node
        head.next = node
    }
}


/*
 problem:
 A linked list of length n is given such that each node contains an additional random pointer, which could point to any node in the list, or null.

 Construct a deep copy of the list. The deep copy should consist of exactly n brand new nodes, where each new node has its value set to the value of its corresponding original node. Both the next and random pointer of the new nodes should point to new nodes in the copied list such that the pointers in the original list and copied list represent the same list state. None of the pointers in the new list should point to nodes in the original list.

 For example, if there are two nodes X and Y in the original list, where X.random --> Y, then for the corresponding two nodes x and y in the copied list, x.random --> y.

 Return the head of the copied linked list.

 The linked list is represented in the input/output as a list of n nodes. Each node is represented as a pair of [val, random_index] where:

 val: an integer representing Node.val
 random_index: the index of the node (range from 0 to n-1) that the random pointer points to, or null if it does not point to any node.
 Your code will only be given the head of the original linked list.
 
 Testcases:
 Input: head = [[7,null],[13,0],[11,4],[10,2],[1,0]]
 Output: [[7,null],[13,0],[11,4],[10,2],[1,0]]
 
 Input: head = [[1,1],[2,1]]
 Output: [[1,1],[2,1]]
 
 Input: head = [[3,null],[3,0],[3,null]]
 Output: [[3,null],[3,0],[3,null]]
 
 Constraints:
 0 <= n <= 1000
 -104 <= Node.val <= 104
 Node.random is null or is pointing to some node in the linked list.
 
 link: https://leetcode.com/problems/copy-list-with-random-pointer/
 explanation: https://www.youtube.com/watch?v=5Y2EiZST97Y&list=PLot-Xpze53leU0Ec0VkBhnf4npMRFiNcB&index=13
 primary idea:
 - Two pass solution
 - Create a new node for each node and store it in hashmap. mapped from existing to new.
 - In second pass, create all next, prev and random connections
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
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
        
        var slow = head, fast = head?.next
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        let right = slow?.next
        slow?.next = nil
        
        let leftSortList = sortList(head)
        let rightSortList = sortList(right)
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
        current?.next = currentleft ?? currentRight
        return dummy?.next
    }
}


/*
 problem:
 Given the head of a linked list, reverse the nodes of the list k at a time, and return the modified list.

 k is a positive integer and is less than or equal to the length of the linked list. If the number of nodes is not a multiple of k then left-out nodes, in the end, should remain as it is.

 You may not alter the values in the list's nodes, only nodes themselves may be changed.
 
 Testcases:
 Input: head = [1,2,3,4,5], k = 2
 Output: [2,1,4,3,5]

 Input: head = [1,2,3,4,5], k = 3
 Output: [3,2,1,4,5]
 
 Constraints:
 The number of nodes in the list is n.
 1 <= k <= n <= 5000
 0 <= Node.val <= 1000
 
 link: https://leetcode.com/problems/reverse-nodes-in-k-group/
 explanation: https://www.youtube.com/watch?v=1UOPsfP85V4&list=PLot-Xpze53leU0Ec0VkBhnf4npMRFiNcB&index=10
 primary idea:
 -
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
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

/*
 problem:
 Given an array of integers nums containing n + 1 integers where each integer is in the range [1, n] inclusive.

 There is only one repeated number in nums, return this repeated number.

 You must solve the problem without modifying the array nums and uses only constant extra space.
 
 Testcases:
 Input: nums = [1,3,4,2,2]
 Output: 2

 Input: nums = [3,1,3,4,2]
 Output: 3
 
 Constraints:
 1 <= n <= 105
 nums.length == n + 1
 1 <= nums[i] <= n
 All the integers in nums appear only once except for precisely one integer which appears two or more times.
 
 link: https://leetcode.com/problems/find-the-duplicate-number/
 explanation: https://www.youtube.com/watch?v=wjYnzkAhcNk&list=PLot-Xpze53leU0Ec0VkBhnf4npMRFiNcB&index=15
 primary idea:
 - Floyd's cycle detection algorithm.
 - This is a linked list problem
 - Asssume all the elements are pointer, ex for [1,3,4,2,2]
    0 -> 3 -> 2 -> 4
                \/
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
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
 Given head, the head of a linked list, determine if the linked list has a cycle in it.

 There is a cycle in a linked list if there is some node in the list that can be reached again by continuously following the next pointer. Internally, pos is used to denote the index of the node that tail's next pointer is connected to. Note that pos is not passed as a parameter.

 Return true if there is a cycle in the linked list. Otherwise, return false.
 
 Testcases:
 Input: head = [3,2,0,-4], pos = 1
 Output: true
 Explanation: There is a cycle in the linked list, where the tail connects to the 1st node (0-indexed).

 Input: head = [1,2], pos = 0
 Output: true
 Explanation: There is a cycle in the linked list, where the tail connects to the 0th node.

 Input: head = [1], pos = -1
 Output: false
 Explanation: There is no cycle in the linked list.
 
 Constraints:
 The number of the nodes in the list is in the range [0, 104].
 -105 <= Node.val <= 105
 pos is -1 or a valid index in the linked-list.
 
 link: https://leetcode.com/problems/linked-list-cycle/
 explanation: https://www.youtube.com/watch?v=wjYnzkAhcNk&list=PLot-Xpze53leU0Ec0VkBhnf4npMRFiNcB&index=15
 primary idea:
 - Floyd's cycle detection
 Time Complexity: O(2n)
 Space Complexity: O(1)
 */
class LinkedListCycle {
    func callAsFunction(_ head: ListNode?) -> Bool {
        if head == nil {
            return false
        }
        var slow = head, fast = head?.next
        while slow !== fast {
            slow = slow?.next
            fast = fast?.next?.next
            if fast == nil {
                return false
            }
        }
        return true
    }
}

class LinkedListCycleII {
    func callAsFunction(_ head: ListNode?) -> ListNode? {
        var slow = head, fast = head
        
        while true {
            if fast == nil {
                return nil
            }
            slow = slow?.next
            fast = fast?.next?.next
            if slow === fast {
                break
            }
        }
        
        var slow2 = head
        while slow !== slow2 {
            slow = slow?.next
            slow2 = slow2?.next
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


/*
 problem:
 Given the head of a singly linked list, sort the list using insertion sort, and return the sorted list's head.

 The steps of the insertion sort algorithm:

 Insertion sort iterates, consuming one input element each repetition and growing a sorted output list.
 At each iteration, insertion sort removes one element from the input data, finds the location it belongs within the sorted list and inserts it there.
 It repeats until no input elements remain.
 The following is a graphical example of the insertion sort algorithm. The partially sorted list (black) initially contains only the first element in the list. One element (red) is removed from the input data and inserted in-place into the sorted list with each iteration.
 
 Testcases:
 Input: head = [4,2,1,3]
 Output: [1,2,3,4]

 Input: head = [-1,5,3,4,0]
 Output: [-1,0,3,4,5]
 
 Constraints:
 The number of nodes in the list is in the range [1, 5000].
 -5000 <= Node.val <= 5000
 
 link: https://leetcode.com/problems/insertion-sort-list/
 explanation: https://www.youtube.com/watch?v=Kk6mXAzqX3Y&list=PLot-Xpze53leU0Ec0VkBhnf4npMRFiNcB&index=21
 primary idea:
 - Insertion sort
 - Traverse through linkedlist and as soon as we find a value less than prev, we start from head again and find the correct place for it and insert it there.
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
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

/*
 problem:
 Given the head of a singly linked list and two integers left and right where left <= right, reverse the nodes of the list from position left to position right, and return the reversed list.
 
 Testcases:
 Input: head = [1,2,3,4,5], left = 2, right = 4
 Output: [1,4,3,2,5]

 Input: head = [5], left = 1, right = 1
 Output: [5]
 
 Constraints:
 The number of nodes in the list is n.
 1 <= n <= 500
 -500 <= Node.val <= 500
 1 <= left <= right <= n
 
 link: https://leetcode.com/problems/reverse-linked-list-ii/
 explanation: https://www.youtube.com/watch?v=RF_M9tX4Eag&list=PLot-Xpze53leU0Ec0VkBhnf4npMRFiNcB&index=17
 primary idea:
 - Traverse till we find leftPrev and current(start of reversal node)
 - Reverse from current till right
 Time Complexity: O(n)
 Space Complexity: O(1)
 */
class ReverseLinkedlistII {
    func callAsFunction(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        let dummy = ListNode(-1)
        dummy.next = head
        
        var leftPrev: ListNode? = dummy, current = head
        for _ in 0..<left - 1 {
            (leftPrev, current) = (current, current?.next)
        }
        
        var prev: ListNode? = nil
        for _ in left..<right+1 {
            let next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        
        leftPrev?.next?.next = current
        leftPrev?.next = prev
        return dummy.next
    }
}

/*
 problem:
 Given an array of integers heights representing the histogram's bar height where the width of each bar is 1, return the area of the largest rectangle in the histogram.
 
 Testcases:
 Input: heights = [2,1,5,6,2,3]
 Output: 10
 Explanation: The above is a histogram where width of each bar is 1.
 The largest rectangle is shown in the red area, which has an area = 10 units.
 
 Input: heights = [2,4]
 Output: 4
 
 
 Constraints:
 1 <= heights.length <= 105
 0 <= heights[i] <= 104
 
 
 link: https://leetcode.com/problems/largest-rectangle-in-histogram/
 explanation: https://www.youtube.com/watch?v=zx5Sw9130L0&list=PLot-Xpze53letfIu9dMzIIO7na_sqvl0w&index=5
 primary idea:
 - Use stack and as soon as the current height is lower than earlier, pop all last height's in stack which are higher than current one. calculate area and modify maxArea if needed. After Iteration, check if stack is empty. if not calculate maxArea with all stack elementss
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class MyCircularQueue {
    
    class DoubleLinkedlistNode {
        let val: Int
        var prev: DoubleLinkedlistNode?
        var next: DoubleLinkedlistNode?
        
        init(_ val: Int, prev: DoubleLinkedlistNode? = nil, next: DoubleLinkedlistNode? = nil) {
            self.val = val
            self.prev = prev
            self.next = next
        }
    }

    var space: Int
    private let left = DoubleLinkedlistNode(-1)
    private let right = DoubleLinkedlistNode(-1)
    
    init(_ k: Int) {
        space = k
        left.next = right
        right.prev = left
    }
    
    func enQueue(_ value: Int) -> Bool {
        if isFull() {
            return false
        }
        
        let prev = self.right.prev
        let new = DoubleLinkedlistNode(value, prev: prev, next: right)
        
        prev?.next = new
        right.prev = new
        
        space -= 1
        return true
    }
    
    func deQueue() -> Bool {
        if isEmpty() {
            return false
        }
        var res = self.left.next
        self.left.next = res?.next
        res?.next?.prev = left
        
        res = nil
        space += 1
        return true
    }
    
    func Front() -> Int {
        self.left.next?.val ?? -1
    }
    
    func Rear() -> Int {
        self.right.prev?.val ?? -1
    }
    
    func isEmpty() -> Bool {
        self.left.next === self.right
    }
    
    func isFull() -> Bool {
        space == 0
    }
}
