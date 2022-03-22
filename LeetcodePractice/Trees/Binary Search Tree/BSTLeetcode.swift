//
//  BSTLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 08/03/22.
//

import Foundation

// MARK: - Search


/*
 problem:
 You are given the root of a binary search tree (BST) and an integer val.

 Find the node in the BST that the node's value equals val and return the subtree rooted with that node. If such a node does not exist, return null.
 
 Testcases:
 Input: root = [4,2,7,1,3], val = 2
 Output: [2,1,3]
 
 Input: root = [4,2,7,1,3], val = 5
 Output: []
 
 Constraints:
 The number of nodes in the tree is in the range [1, 5000].
 1 <= Node.val <= 107
 root is a binary search tree.
 1 <= val <= 107
 
 
 link: https://leetcode.com/problems/search-in-a-binary-search-tree/
 explanation:
 primary idea:
 - Search left, if val is less than current
 - Search right, if val is greater than current
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class SearchBST {
    typealias TreeNode = TreeLeetcode.TreeNode
    func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        if root == nil {
            return nil
        }
        
        if root!.val == val {
            return root
        }
        
        if val < root!.val {
            return searchBST(root?.left, val)
        } else {
            return searchBST(root?.right, val)
        }
    }
}

/*
 problem:
 Given the root of a Binary Search Tree (BST), return the minimum absolute difference between the values of any two different nodes in the tree.
 
 Testcases:
 Input: root = [4,2,6,1,3]
 Output: 1
 
 Input: root = [1,0,48,null,null,12,49]
 Output: 1
 
 
 Constraints:
 The number of nodes in the tree is in the range [2, 104].
 0 <= Node.val <= 105
 
 link: https://leetcode.com/problems/minimum-absolute-difference-in-bst/
 explanation:
 primary idea:
 - Inorder traversal. keeping track of prev node
 Time Complexity: O(n)
 Space Complexity: O(n)
 */

class MinAbsoluteDiffInBST {
    typealias TreeNode = TreeLeetcode.TreeNode
    func recursion(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        var minDiff = Int.max
        var prev: TreeNode? = nil
        
        func evaluate(_ node: TreeNode?, prev: inout TreeNode?) {
            if node == nil {
                return
            }
            
            evaluate(node?.left, prev: &prev)
            if let prev = prev {
                minDiff = min(minDiff, abs(node!.val - prev.val))
            }
            prev = node!
            evaluate(node!.right, prev: &prev)
        }
        evaluate(root, prev: &prev)
        return minDiff
    }
    
    func iterative(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        var minDiff = Int.max
        var stack = [TreeNode](), current: TreeNode? = root, prev: TreeNode? = nil
        while !stack.isEmpty || current != nil {
            if current != nil {
                stack.append(current!)
                current = current!.left
            } else {
                current = stack.popLast()
                if prev != nil {
                    minDiff = min(minDiff, abs(prev!.val - current!.val))
                }
                prev = current
                current = current!.right
            }
        }
        return minDiff
    }
}


/*
 problem:
 Given the root node of a binary search tree and two integers low and high, return the sum of values of all nodes with a value in the inclusive range [low, high].
 
 Testcases:
 Input: root = [10,5,15,3,7,null,18], low = 7, high = 15
 Output: 32
 Explanation: Nodes 7, 10, and 15 are in the range [7, 15]. 7 + 10 + 15 = 32.
 
 Input: root = [10,5,15,3,7,13,18,1,null,6], low = 6, high = 10
 Output: 23
 Explanation: Nodes 6, 7, and 10 are in the range [6, 10]. 6 + 7 + 10 = 23.
 
 
 Constraints:
 The number of nodes in the tree is in the range [1, 2 * 104].
 1 <= Node.val <= 105
 1 <= low <= high <= 105
 All Node.val are unique.
 
 
 link: https://leetcode.com/problems/range-sum-of-bst/
 explanation:
 primary idea:
 -
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class RangeSumBST {
    typealias TreeNode = TreeLeetcode.TreeNode
    func rangeSumBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> Int {
        var sum = 0
        let range = low...high
        
        func evaluate(_ node: TreeNode?) {
            if node == nil {
                return
            }
            
            if range.contains(node!.val) {
                sum += node!.val
            }
            if node!.val > low {
                evaluate(node!.left)
            }
            
            if node!.val < high {
                evaluate(node!.right)
            }
        }
        evaluate(root)
        return sum
    }
}


class DeleteNodeInBST {
    typealias TreeNode = TreeLeetcode.TreeNode
    func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? {
        
        func findSuccessor(_ node: TreeNode?) -> TreeNode? {
            var current = node
            
            while current?.left != nil {
                current = current?.left!
            }
            
            return current
        }
        
        func deleteNodeHelper(_ node: TreeNode?) -> TreeNode? {
            if node == nil {
                return nil
            }
            
            var node = node
            if node!.val == key {
                if node!.left?.val != nil && node!.right?.val != nil {
                    if let successor = findSuccessor(node!.right) {
                        (node!.val, successor.val) = (successor.val, node!.val)
                    }
                    node?.right = deleteNodeHelper(node?.right)
                } else if node!.left != nil {
                    node = node!.left
                } else {
                    node = node!.right
                }
                return node
            } else if node!.val > key {
                node?.left = deleteNodeHelper(node!.left)
            } else {
                node?.right = deleteNodeHelper(node!.right)
            }
            return node
        }
        return deleteNodeHelper(root)
    }
}

class InsertInToBST {
    typealias TreeNode = TreeLeetcode.TreeNode
    func callAsFunction(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        func insertHelper(_ node: TreeNode?) -> TreeNode? {
            if node == nil {
                return TreeNode(val)
            }
            
            if val < node!.val {
                node?.left = insertHelper(node!.left)
            } else {
                node?.right = insertHelper(node!.right)
            }
            return node
        }
        return insertHelper(root)
    }
}

/*
 problem:
 Given two binary search trees root1 and root2, return a list containing all the integers from both trees sorted in ascending order.
 
 Testcases:
 Input: root1 = [2,1,4], root2 = [1,0,3]
 Output: [0,1,1,2,3,4]
 
 Input: root1 = [1,null,8], root2 = [8,1]
 Output: [1,1,8,8]
 
 Constraints:
 The number of nodes in each tree is in the range [0, 5000].
 -105 <= Node.val <= 105
 
 
 link: https://leetcode.com/problems/all-elements-in-two-binary-search-trees/
 explanation:
 primary idea:
 - inorder traversal for both trees and come up with both BST arr
 - Sort both arr
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class AllElementsInTwoBSTs {
    typealias TreeNode = TreeLeetcode.TreeNode
    func getAllElements(_ root1: TreeNode?, _ root2: TreeNode?) -> [Int] {
        var firstTreeArr = [Int](), secondTreeArr = [Int]()
        
        func inorderTraversal(_ node: TreeNode?, _ arr: inout [Int]) {
            if node == nil {
                return
            }
            inorderTraversal(node?.left, &arr)
            arr.append(node!.val)
            inorderTraversal(node?.right, &arr)
        }
        
        inorderTraversal(root1, &firstTreeArr)
        inorderTraversal(root2, &secondTreeArr)
        
        var l1 = 0, l2 = 0, res = [Int]()
        while l1 < firstTreeArr.count && l2 < secondTreeArr.count {
            let first = firstTreeArr[l1], second = secondTreeArr[l2]
            if first < second {
                res.append(first)
                l1 += 1
            } else {
                res.append(second)
                l2 += 1
            }
        }
        
        while l1 < firstTreeArr.count {
            res.append(firstTreeArr[l1])
            l1 += 1
        }
        
        while l2 < secondTreeArr.count {
            res.append(secondTreeArr[l2])
            l2 += 1
        }
        
        return res
    }
}

/*
 problem:
 Given an array of integers preorder, which represents the preorder traversal of a BST (i.e., binary search tree), construct the tree and return its root.

 It is guaranteed that there is always possible to find a binary search tree with the given requirements for the given test cases.

 A binary search tree is a binary tree where for every node, any descendant of Node.left has a value strictly less than Node.val, and any descendant of Node.right has a value strictly greater than Node.val.

 A preorder traversal of a binary tree displays the value of the node first, then traverses Node.left, then traverses Node.right.
 
 Testcases:
 Input: preorder = [8,5,1,7,10,12]
 Output: [8,5,10,1,7,null,12]

 Input: preorder = [1,3]
 Output: [1,null,3]
 
 
 Constraints:
 1 <= preorder.length <= 100
 1 <= preorder[i] <= 1000
 All the values of preorder are unique.
 
 
 link: https://leetcode.com/problems/construct-binary-search-tree-from-preorder-traversal/
 explanation:
 primary idea:
 - Divide and conquer
 - In preorder traversal, root comes first.
 - In preordeer arr, first we need to differentiate which part comes under left subtree and right subtree
 - The values greater that left most element are in right subtree and values less tha root comes under left subtree
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class BSTFromPreOrderArray {
    typealias TreeNode = TreeLeetcode.TreeNode
    func callAsFunction(_ preorder: [Int]) -> TreeNode? {
        
        func buildSubTree(left: Int, right: Int) -> TreeNode? {
            if left > right {
                return nil
            }
            if left == right {
                return TreeNode(preorder[left])
            }
            
            let root = TreeNode(preorder[left])
            var rightIndex = left
            for i in left...right {
                if preorder[i] > preorder[left] {
                    rightIndex = i
                    break
                }
            }
            
            if rightIndex == left {
                rightIndex = right + 1
            }
            
            root.left = buildSubTree(left: left + 1, right: rightIndex - 1)
            root.right = buildSubTree(left: rightIndex, right: right)
            return root
        }
        return buildSubTree(left: 0, right: preorder.count - 1)
    }
}
