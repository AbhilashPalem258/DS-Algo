//
//  TreesLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 21/06/21.
//

import Foundation

enum TreeLeetcode {
    class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init() { self.val = 0; self.left = nil; self.right = nil; }
        public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
        public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
            self.val = val
            self.left = left
            self.right = right
         }
    }
}
extension TreeLeetcode.TreeNode: Equatable {
    static func == (lhs: TreeLeetcode.TreeNode, rhs: TreeLeetcode.TreeNode) -> Bool {
        lhs.val == rhs.val
    }
}
extension TreeLeetcode.TreeNode: CustomStringConvertible {
    var description: String {
        diagram(for: self)
    }
    
    private func diagram(for node: TreeLeetcode.TreeNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        if node.left == nil && node.right == nil {
            return root + "\(node.val)\n"
        }
        return diagram(for: node.right, top + " ", top + "--", top + "| ")
    }
}


class TreePreorderTraversal {
    func callAsFunction(_ root: TreeLeetcode.TreeNode?) -> [Int] {
       var storage = [Int]()
        
        helper(root, storage: &storage)
        
        return storage
   }
    
    func helper(_ node: TreeLeetcode.TreeNode?, storage: inout [Int]) {
        guard let nodeVal = node?.val else {
            return
        }
        storage.append(nodeVal)
        helper(node?.left, storage: &storage)
        helper(node?.right, storage: &storage)
    }
    
    func iterativeSolution(_ root: TreeLeetcode.TreeNode?) -> [Int] {
        var current = root, stack = [TreeLeetcode.TreeNode]()
        var result = [Int]()
        
        while !stack.isEmpty || current != nil {
            if let cur = current {
                result.append(cur.val)
                if let right = cur.right {
                    stack.append(right)
                }
                current = cur.left
            } else {
                current = stack.removeLast()
            }
        }
        return result
    }
}

class TreeInorderTraversal {
    func callAsFunction(_ root: TreeLeetcode.TreeNode?) -> [Int] {
       var storage = [Int]()
        
        helper(root, storage: &storage)
        
        return storage
   }
    
    func helper(_ node: TreeLeetcode.TreeNode?, storage: inout [Int]) {
        guard let nodeVal = node?.val else {
            return
        }
        helper(node?.left, storage: &storage)
        storage.append(nodeVal)
        helper(node?.right, storage: &storage)
    }
    
    func iterativeSolution(_ root: TreeLeetcode.TreeNode?) -> [Int] {
        var current = root, stack = [TreeLeetcode.TreeNode]()
        var result = [Int]()
        
        while !stack.isEmpty || current != nil {
            if let cur = current {
                stack.append(cur)
                current = cur.left
            } else {
                let node = stack.removeLast()
                result.append(node.val)
                current = node.right
            }
        }
        return result
    }
}

class TreePostOrderTraversal {
    func callAsFunction(_ root: TreeLeetcode.TreeNode?) -> [Int] {
        var result = [Int]()
        
        func helper(node: TreeLeetcode.TreeNode?) {
            if node == nil {
                return
            }
            helper(node: node?.left)
            helper(node: node?.right)
            result.append(node!.val)
        }
        helper(node: root)
        return result
    }
    
    //https://www.youtube.com/watch?v=QhszUQhGGlA&list=PLQpVsaqBj4RIJdYW6Y-iAswxCZeocfoRW&index=4
    // Post Order Iterative is slightly different from Inorder and Preorder iterative. Better watch video
    func iterativeSolution(root: TreeLeetcode.TreeNode?) -> [Int] {
        var stack: [(TreeLeetcode.TreeNode?, Bool)] = [(root, false)]
        var result = [Int]()
        
        while !stack.isEmpty {
            let (current, isVisited) = stack.removeLast()
            if let cur = current {
                if isVisited {
                    result.append(cur.val)
                } else {
                    stack.append((cur, true))
                    stack.append((cur.right, false))
                    stack.append((cur.left, false))
                }
            }
        }
        return result
    }
}

//link: https://leetcode.com/problems/balanced-binary-tree/
class BalancedBinaryTree {
    typealias TreeNode = TreeLeetcode.TreeNode
    var isBalanced = true
    func callAsFunction(_ root: TreeNode?) -> Bool {
        guard let node = root else {
            return true
        }
        isBalancedHelper(node)
        return isBalanced
    }
    
    @discardableResult
    func isBalancedHelper(_ node: TreeNode?) -> Int {
        guard let node = node, isBalanced else {
            return 0
        }

        let left = isBalancedHelper(node.left), right = isBalancedHelper(node.right)
        if abs(left - right) > 1 {
            self.isBalanced = false
        }
        return max(left, right) + 1
    }
}

//Link: https://leetcode.com/problems/sum-of-left-leaves/
class BTreeSumOfLeftLeaves {
    func callAsFunction(_ root: TreeLeetcode.TreeNode?) -> Int {
        var sum = 0
        
        func helper(_ node: TreeLeetcode.TreeNode?, isLeft: Bool) {
            guard let node = node else {
                return
            }
            if node.left == nil && node.right == nil && isLeft {
                sum += node.val
            }
            helper(node.left, isLeft: true)
            helper(node.right, isLeft: false)
        }
        helper(root, isLeft: false)
        return sum
    }
}

//Link: https://leetcode.com/problems/flatten-binary-tree-to-linked-list/
class BinaryTreeToLinkedList {
    var last:TreeLeetcode.TreeNode? = nil

    func flatten(_ root: TreeLeetcode.TreeNode?) {
        if let root = root {
            if let last = last {
                last.right = root
            }
            last = root
            let temp = root.right
            flatten(root.left)
            root.left = nil
            flatten(temp)
        }
    }
}

//Link: https://leetcode.com/problems/binary-tree-level-order-traversal/
class BinaryLevelOrderTraversal {
    func callAsFunction(_ root: TreeLeetcode.TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }
        var result = [[Int]]()
        var stack = [root]
        
        while !stack.isEmpty {
            result.append(stack.map { $0.val })
            let levelNodes = stack
            stack.removeAll()
            
            for node in levelNodes {
                if let left = node.left {
                    stack.append(left)
                }
                if let right = node.right {
                    stack.append(right)
                }
            }
        }
        return result
    }
}

//link: https://leetcode.com/problems/binary-tree-level-order-traversal-ii/
class BinaryLevelOrderTraversalII {
    func callAsFunction(_ root: TreeLeetcode.TreeNode?) -> [[Int]] {
        guard let node = root else {
            return []
        }
        var result = [[Int]]()
        var queue = [node]
        
        while !queue.isEmpty {
            result.insert(queue.map {$0.val}, at: 0)
            let levelNodes = queue
            queue.removeAll()
            
            for node in levelNodes {
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
        }
        return result
    }
}

//link: https://leetcode.com/problems/merge-two-binary-trees/
class MergeTwoBinaryTrees {
    func mergeTrees(_ root1: TreeLeetcode.TreeNode?, _ root2: TreeLeetcode.TreeNode?) -> TreeLeetcode.TreeNode? {
        guard let root1 = root1, let root2 = root2 else {
            return root1 == nil ? root2 : root1
        }
        let t = TreeLeetcode.TreeNode(root1.val + root2.val)
        t.left = mergeTrees(root1.left, root2.left)
        t.right = mergeTrees(root1.right, root2.right)
        
        return t
    }
}

//link: https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/
class BinaryZigZag {
    func callAsFunction(_ root: TreeLeetcode.TreeNode?) -> [[Int]] {
        guard let node = root else {
            return []
        }
        var result = [[Int]]()
        var queue = [node]
        var isLeftToRight = true
        
        while !queue.isEmpty {
            let levelNodes = queue
            queue.removeAll()
            
            var rowResult = [Int]()
            for node in levelNodes {
                isLeftToRight ? rowResult.append(node.val) : rowResult.insert(node.val, at: 0)
                
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            result.append(rowResult)
            isLeftToRight.toggle()
        }
        return result
    }
}

//link: https://leetcode.com/problems/binary-tree-right-side-view/
class BinaryTreeRightSideView {
    var maxValue = 0
    func callAsFunction(_ root: TreeLeetcode.TreeNode?) -> [Int] {
        guard let node = root else {
            return []
        }
        var res = [Int]()
        rightSideView(node, level: 1, res: &res)
        return res
    }
    
    func rightSideView(_ node: TreeLeetcode.TreeNode?, level: Int, res: inout [Int]) {
        guard let node = node else {
            return
        }
        if maxValue < level {
            res.append(node.val)
            maxValue = level
        }
        rightSideView(node.right, level: level+1, res: &res)
        rightSideView(node.left, level: level+1, res: &res)
    }
}

class BinaryTreeVerticalOrderTraversal {
    func callAsFunction(_ root: TreeLeetcode.TreeNode?) -> [[Int]] {
        guard let node = root else {
            return []
        }
        var orderTovals = [0: [node.val]], queue = [(node, 0)]
        
        while !queue.isEmpty {
            let size = queue.count
            for _ in 0..<size {
                let (node, order) = queue.removeFirst()
                
                if let left = node.left {
                    orderTovals[order - 1, default:[]].append(left.val)
                    queue.append((left, order - 1))
                }
                if let right = node.right {
                    orderTovals[order + 1, default:[]].append(right.val)
                    queue.append((right, order + 1))
                }
            }
        }
        return orderTovals.sorted{ $0.key < $1.key }.map{ $0.value }
    }
}

class KthSmallestInBST {
    typealias TreeNode = TreeLeetcode.TreeNode
    func callAsFunction(_ root: TreeNode?, _ k: Int) -> Int {
        var stack = [TreeNode](), currentNode = root, k = k
        while !stack.isEmpty || currentNode != nil {
            if currentNode != nil {
                stack.append(currentNode!)
                currentNode = currentNode?.left
            } else {
                let node = stack.removeLast()
                k -= 1
                if k == 0 {
                    return node.val
                }
                currentNode = node.right
            }
        }
        return -1
    }
}


class ConstructBinaryTreeInorderPostorder {
    func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeLeetcode.TreeNode? {
        var iMap = [Int: Int](), pIndex = postorder.count - 1
        for (i, element) in inorder.enumerated() {
            iMap[element] = i
        }
        
        func buildNode(low: Int, high: Int) -> TreeLeetcode.TreeNode? {
            guard low <= high else {
                return nil
            }
            let node = TreeLeetcode.TreeNode(postorder[pIndex])
            let mId = iMap[node.val]!
            pIndex -= 1
            node.right = buildNode(low: mId + 1, high: high)
            node.left = buildNode(low: low, high: mId - 1)
            return node
        }
        return buildNode(low: 0, high: inorder.count - 1)
    }
    
    func buildTree1(_ inorder: [Int], _ postorder: [Int]) -> TreeLeetcode.TreeNode? {
        guard postorder.count == inorder.count else {
            return nil
        }
        
        func buildNode(inStart: Int, inEnd: Int, postStart: Int, postEnd: Int) -> TreeLeetcode.TreeNode? {
            guard inStart <= postStart, postStart <= postEnd else {
                return nil
            }
            
            let root = TreeLeetcode.TreeNode(postorder[postEnd])
            let mId = inorder.firstIndex(of: root.val)!
            
            root.right = buildNode(inStart: mId + 1, inEnd: inEnd, postStart: postStart, postEnd: postEnd - 1)
            root.left = buildNode(inStart: inStart, inEnd: mId - 1, postStart: postStart, postEnd: postEnd - 1)
            
            return root
        }
        
        return buildNode(inStart: 0, inEnd: inorder.count - 1, postStart: 0, postEnd: postorder.count - 1)
    }
}

class ConstructBinaryTreePreorderInorder {
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeLeetcode.TreeNode? {
        guard preorder.count == inorder.count else {
            return nil
        }
        var iMap = [Int: Int](), pIndex = 0
        for (i, element) in inorder.enumerated() { iMap[element] = i }
        
        func buildNode(low: Int, high: Int) -> TreeLeetcode.TreeNode? {
            guard low <= high else { return nil }
            let node = TreeLeetcode.TreeNode(preorder[pIndex])
            let mId = iMap[node.val]!
            pIndex += 1
            node.left = buildNode(low: low, high: mId - 1)
            node.right = buildNode(low: mId + 1, high: high)
            return node
        }
        
        return buildNode(low: 0, high: inorder.count - 1)
    }
}

struct PathSum {
    func hasPathSum(_ root: TreeLeetcode.TreeNode?, _ targetSum: Int) -> Bool {
        guard let node = root else {
            return false
        }
        if node.val == targetSum && node.left == nil && node.right == nil {
            return true
        }
        return hasPathSum(node.left, targetSum - node.val) || hasPathSum(node.right, targetSum - node.val)
    }
}

struct PathSumII {
    func pathSum(_ root: TreeLeetcode.TreeNode?, _ targetSum: Int) -> [[Int]] {
        guard let node = root else {
            return []
        }
        
        func getpathSum(_ node: TreeLeetcode.TreeNode?, targetAmount: Int, earlierSteps: [Int]) -> [[Int]] {
            guard let node = node else {
                return []
            }
            let reducedAmount = targetAmount - node.val
            let appendedArr = earlierSteps + [node.val]
            let left = getpathSum(node.left, targetAmount: reducedAmount, earlierSteps: appendedArr)
            let right = getpathSum(node.right, targetAmount: reducedAmount, earlierSteps: appendedArr)
            
            if node.left == nil && node.right == nil {
                if reducedAmount == 0 {
                    return [appendedArr]
                } else {
                    return []
                }
            }
            return left + right
        }
        
        return getpathSum(node, targetAmount: targetSum, earlierSteps: [])
    }
}

class PathSumIII {
    typealias TreeNode = TreeLeetcode.TreeNode
    func pathSum(_ root: TreeNode?, _ targetSum: Int) -> Int {
        if root == nil {
            return 0
        }
        
        func findNumOfPathsSumHelper(_ node: TreeNode?, target: Int) -> Int {
            if node == nil {
                return 0
            }
            
            var res = 0
            if node?.val == target {
                res += 1
            }
            res += findNumOfPathsSumHelper(node?.left, target: target - node!.val)
            res += findNumOfPathsSumHelper(node?.right, target: target - node!.val)
            
            return res
        }
        
        var pathsCount = findNumOfPathsSumHelper(root, target: targetSum)
        pathsCount += pathSum(root?.left, targetSum)
        pathsCount += pathSum(root?.right, targetSum)
        
        return pathsCount
    }
}

//explanation link: https://www.youtube.com/watch?v=nHR8ytpzz7c
//leetcode link:
class HouseRobberyIII {
    func rob(_ root: TreeLeetcode.TreeNode?) -> Int {
        func dfs(_ node: TreeLeetcode.TreeNode?) -> (withRoot: Int, withoutRoot: Int) {
            guard let node = node else {
                return (0, 0)
            }
            
            let leftPair = dfs(node.left)
            let rightPair = dfs(node.right)
            
            let withRoot = leftPair.withoutRoot + node.val + rightPair.withoutRoot
            let withoutRoot = max(leftPair.withRoot, leftPair.withoutRoot) + max(rightPair.withRoot, rightPair.withoutRoot)
            
            return (withRoot, withoutRoot)
        }
        let result = dfs(root)
        return max(result.withRoot, result.withoutRoot)
    }
}

class SerializeAndDeserializeBTree {
    //Solution 1
    func serialize(_ root: TreeLeetcode.TreeNode?) -> String {
        var nodes = [String]()
        func helper(_ node: TreeLeetcode.TreeNode?) {
            guard let node = node else {
                nodes.append("nil")
                return
            }
            nodes.append(String(node.val))
            helper(node.left)
            helper(node.right)
        }
        helper(root)
        return nodes.joined(separator: ",")
    }
    
    func deserialize(_ data: String) -> TreeLeetcode.TreeNode? {
        let nodes = data.split(separator: ",").map { Int(String($0)) }
        var index = 0
        
        func helper() -> TreeLeetcode.TreeNode? {
            guard let val = nodes[index] else {
                index += 1
                return nil
            }
            
            index += 1
            let node = TreeLeetcode.TreeNode(val)
            node.left = helper()
            node.right = helper()
            
            return node
        }
        return helper()
    }
}
/*
 In an N-ary tree, there are no designated left and right children. An N-ary tree is represented by storing an array or list of child pointers with every node.
 */
class SerializeAndDeserializeNaryTree {
    func serialize(_ root: TreeNode<Int>?) -> String {
         guard let root = root else {
             return ""
         }
         
         return String(root.value) + "#" + String(root.children.count) + "#" + root.children.map { serialize($0) }.joined()
    }
    
    func deserialize(_ vals: String) -> TreeNode<Int>? {
        var components = vals
        
        func helper(_ components: inout String) -> TreeNode<Int>? {
            guard let rootVal =  Int(String(getNextComponent(&components))) else {
                return nil
            }
            let root = TreeNode(value: rootVal), size = Int(String(getNextComponent(&components)))
            for _ in (0..<size!) {
                if let child = helper(&components) {
                    root.add(child: child)
                }
            }
            return root
        }
        
        return helper(&components)
    }
    
    private func getNextComponent(_ collection: inout String) -> Character {
        var next = collection.removeFirst()
        if next == "#" {
            next = collection.removeFirst()
        }
        return next
    }
}

//
class BinaryTreeMaximumPathSum {
        
    func maxPathSum(_ root: TreeLeetcode.TreeNode?) -> Int {
        
        var max_sum_path = Int.min
        
        @discardableResult
        func dfs(_ node:  TreeLeetcode.TreeNode?) -> Int {
            guard let node = node else {
                return 0
            }
            
            let left = max(dfs(node.left), 0)
            let right = max(dfs(node.right), 0)
            
            max_sum_path = max(left + right + node.val, max_sum_path)
            
            return max(left, right) + node.val
        }
        
        dfs(root)
        
        return max_sum_path
    }
    
}

//link: https://leetcode.com/problems/binary-tree-paths/
class BinaryTreePaths {
    func callAsFunction(_ root: TreeLeetcode.TreeNode?) -> [String] {
        
        var answer: [String] = []
        
        func dfs(_ node: TreeLeetcode.TreeNode?, path: String) {
            guard let node = node else {
                return
            }
            var modifiedPath = path
            if node.left == nil && node.right == nil {
                modifiedPath += "\(node.val)"
                answer.append(modifiedPath)
            } else {
                modifiedPath += "\(node.val)->"
                dfs(node.left, path: modifiedPath)
                dfs(node.right, path: modifiedPath)
            }
        }
        
        dfs(root, path: "")
        return answer
    }
    
}
/*
 link: https://leetcode.com/problems/count-good-nodes-in-binary-tree/
 */
struct CountGoodNodes {
    typealias TreeNode = TreeLeetcode.TreeNode
    func callAsFunction(_ root: TreeNode?) -> Int {
        var result = 0
        func isGoodNode(node: TreeNode?, maxVal: Int) {
            if node == nil {
                return
            }
            if node!.val >= maxVal {
                result += 1
            }
            let maxVal = max(maxVal, node!.val)
            isGoodNode(node: node?.left, maxVal: maxVal)
            isGoodNode(node: node?.right, maxVal: maxVal)
        }
        isGoodNode(node: root, maxVal: Int.min)
        return result
    }
}

/*
 problem:
 You are given a perfect binary tree where all leaves are on the same level, and every parent has two children. The binary tree has the following definition:

 struct Node {
   int val;
   Node *left;
   Node *right;
   Node *next;
 }
 Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to NULL.

 Initially, all next pointers are set to NULL.
 
 Testcases:
 Input: root = [1,2,3,4,5,6,7]
 Output: [1,#,2,3,#,4,5,6,7,#]
 Explanation: Given the above perfect binary tree (Figure A), your function should populate each next pointer to point to its next right node, just like in Figure B. The serialized output is in level order as connected by the next pointers, with '#' signifying the end of each level.
 
 Input: root = []
 Output: []
 
 
 Constraints:
 The number of nodes in the tree is in the range [0, 212 - 1].
 -1000 <= Node.val <= 1000
 
 
 link: https://leetcode.com/problems/populating-next-right-pointers-in-each-node/
 explanation: https://www.youtube.com/watch?v=o-SxW_0E-o8
 primary idea:
 - Self Explanatory.
 Time Complexity: O(n)
 Space Complexity: O(1)
 */
class PopulatingNextRightPointers {
    
     public class Node {
         public var val: Int
         public var left: Node?
         public var right: Node?
         public var next: Node?
         public init(_ val: Int) {
             self.val = val
             self.left = nil
             self.right = nil
             self.next = nil
         }
     }
    
    func connect(_ root: Node?) -> Node? {
        if root == nil || root?.left == nil || root?.right == nil { return root }
        root?.left?.next = root?.right
        if root?.next != nil {
            root?.right?.next = root?.next?.left
        }
        _ = connect(root?.left)
        _ = connect(root?.right)
        
        return root
    }
}

//https://www.youtube.com/watch?v=yl-fdkyQD8A&list=PLJtzaiEpVo2xgzgEn2K0v_XryX3_VThjh&index=3
class PopulatingNextRightPointersII {
    public class Node {
        public var val: Int
        public var left: Node?
        public var right: Node?
        public var next: Node?
        public init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
            self.next = nil
        }
    }
    
    func connect(_ root: Node?) -> Node? {
        if root == nil {
            return root
        }
        var stack = [root]
        while !stack.isEmpty {
            let level = stack
            stack.removeAll()
            
            var prev: Node = Node(-1)
            for node in level {
                prev.next = node
                prev = prev.next!
                
                if node?.left != nil {
                    stack.append(node?.left)
                }
                
                if node?.right != nil {
                    stack.append(node?.right)
                }
            }
        }
        return root
    }
    
    func connectConstantSpace(_ root: Node?) -> Node? {
        if root == nil {
            return root
        }
        
        var head = root
        
        while head != nil {
            let dummy = Node(-1)
            var temp = dummy
            
            while head != nil {
                if head?.left != nil {
                    temp.next = head?.left
                    temp = temp.next!
                }
                if head?.right != nil {
                    temp.next = head?.right
                    temp = temp.next!
                }
                head = head?.next
            }
            head = dummy.next
        }
        return root
    }
}
/*
 problem:
 Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.

 According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”
 
 Testcases:
 Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
 Output: 3
 Explanation: The LCA of nodes 5 and 1 is 3.
 
 Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
 Output: 5
 Explanation: The LCA of nodes 5 and 4 is 5, since a node can be a descendant of itself according to the LCA definition.
 
 Input: root = [1,2], p = 1, q = 2
 Output: 1
 
 Constraints:
 The number of nodes in the tree is in the range [2, 105].
 -109 <= Node.val <= 109
 All Node.val are unique.
 p != q
 p and q will exist in the tree.
 
 
 link: https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/
 explanation: https://www.youtube.com/watch?v=13m9ZCB8gjw
 primary idea:
 - DFS. As soon as we find a matching node we return that or else we continue with traversing. If we find atleast a left or right matching node, we return that. If we find both then that means it is the LCA and return it.
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class LowestCommonAncestor {
    
    public class TreeNode {
         public var val: Int
         public var left: TreeNode?
         public var right: TreeNode?
         public init(_ val: Int) {
             self.val = val
             self.left = nil
             self.right = nil
         }
    }
    
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil { return nil }
        if root?.val == p?.val || root?.val == q?.val { return root }
        
        let left = lowestCommonAncestor(root?.left, p, q)
        let right = lowestCommonAncestor(root?.right, p, q)
        
        if left != nil && right != nil { return root }
        return left != nil ? left : right
    }
}

class LowestCommonAncestorBST {
    typealias TreeNode = TreeLeetcode.TreeNode
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil || p == nil || q == nil {
            return nil
        }
        
        if p!.val > root!.val && q!.val > root!.val {
            return lowestCommonAncestor(root?.right, p, q)
        } else if p!.val < root!.val && q!.val < root!.val {
            return lowestCommonAncestor(root?.left, p, q)
        } else {
            return root
        }
    }
}

class ConstructBSTFromSortedArr {
    typealias TreeNode = TreeLeetcode.TreeNode
    
    func callAsFunction(_ nums: [Int]) -> TreeNode? {
        if nums.isEmpty {
            return nil
        }
        
        func sortedArrNode(leftIndex: Int, rightIndex: Int) -> TreeNode? {
            if leftIndex > rightIndex {
                return nil
            }
            
            let midid = (leftIndex + rightIndex) / 2
            let root = TreeNode(nums[midid])
            root.left = sortedArrNode(leftIndex: leftIndex, rightIndex: midid - 1)
            root.right = sortedArrNode(leftIndex: midid + 1, rightIndex: rightIndex)
            return root
        }
        
        return sortedArrNode(leftIndex: 0, rightIndex: nums.count - 1)
    }
}

/*
 problem:
 Given an integer n, return the number of structurally unique BST's (binary search trees) which has exactly n nodes of unique values from 1 to n.
 
 Testcases:
 Input: n = 3
 Output: 5
 
 Input: n = 1
 Output: 1
 
 Constraints:
 1 <= n <= 19
 
 link: https://leetcode.com/problems/unique-binary-search-trees/
 explanation: https://www.youtube.com/watch?v=Ox0TenN3Zpg
 primary idea:
 - Dynamic programming
 - Better watch video
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class UniqueBST {
    func numTrees(_ n: Int) -> Int {
        /*
         numTrees[4] = numTrees[0] * numTrees[3]
                     + numTrees[1] * numTrees[2]
                     + numTrees[2] * numTrees[1]
                     + numTrees[3] * numTrees[0]
         */
        var dp = [Int](repeating: 1, count: n+1)
        dp[0] = 1
        dp[1] = 1
        
        for nodes in 2..<n+1 {
            var total = 0
            for root in 1..<nodes+1 {
                total += dp[root - 1] * dp[nodes - root]
            }
            dp[nodes] = total
        }
        return dp[n]
    }
}

class UniqueBSTII {
    typealias TreeNode = TreeLeetcode.TreeNode
    func generateTrees(_ n: Int) -> [TreeNode?] {
        
        func buildTree(start: Int, end: Int) -> [TreeNode?] {
            if end < start {
                return [nil]
            }
            if start == end {
                return [TreeNode(start)]
            }
            var result = [TreeNode]()
            for root in start..<end+1 {
                let ltrees = buildTree(start: start, end: root - 1)
                let rtrees = buildTree(start: root + 1, end: end)
                
                for ltree in ltrees {
                    for rtree in rtrees {
                        result.append(TreeNode(root, ltree, rtree))
                    }
                }
            }
            return result
        }
        
        return buildTree(start: 1, end: n)
    }
}

class Triangle {
    //TLE
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        let n = triangle.count
        
        func minPathSum(row: Int, col: Int, pathSum: Int) -> Int {
            if row == n {
                return pathSum
            }
            
            let leftSum = minPathSum(row: row + 1, col: col, pathSum: pathSum + triangle[row][col])
            let rightSum = minPathSum(row: row + 1, col: col + 1, pathSum: pathSum + triangle[row][col])
            return min(leftSum, rightSum)
        }
        return minPathSum(row: 0, col: 0, pathSum: 0)
    }
    
    func dp(_ triangle: [[Int]]) -> Int {
        var dp = [Int](repeating: 0, count: triangle.last!.count + 1)
        
        for row in triangle.reversed() {
            for colIndex in 0..<row.count {
                dp[colIndex] = min(row[colIndex] + dp[colIndex], row[colIndex] + dp[colIndex + 1])
            }
        }
        
        return dp[0]
    }
}

/*
 problem:
 Given the root of a binary tree, find the maximum value v for which there exist different nodes a and b where v = |a.val - b.val| and a is an ancestor of b.

 A node a is an ancestor of b if either: any child of a is equal to b or any child of a is an ancestor of b.
 
 Testcases:
 Input: root = [8,3,10,1,6,null,14,null,null,4,7,13]
 Output: 7
 Explanation: We have various ancestor-node differences, some of which are given below :
 |8 - 3| = 5
 |3 - 7| = 4
 |8 - 1| = 7
 |10 - 13| = 3
 Among all possible differences, the maximum value of 7 is obtained by |8 - 1| = 7.
 
 Input: root = [1,null,2,null,0,3]
 Output: 3
 
 Constraints:
 The number of nodes in the tree is in the range [2, 5000].
 0 <= Node.val <= 105
 
 
 link: https://leetcode.com/problems/maximum-difference-between-node-and-ancestor/
 explanation:
 primary idea:
 - Tree inorder traversal
 - As we are finding difference, first encountered node can be min and second can be max or vice versa. So we will keep track of max and min val till each node
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class MaxDiffBtwAncestorAndNode {
    typealias TreeNode = TreeLeetcode.TreeNode
    func maxAncestorDiff(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        var maxDiff = Int.min
        func evaluate(_ node: TreeNode?, maxVal: Int, minVal: Int) {
            if node == nil {
                return
            }
            let minVal = min(minVal, node!.val)
            let maxVal = max(maxVal, node!.val)
            let currentDiff = max(abs(node!.val - maxVal), abs(node!.val - minVal))
            if currentDiff > maxDiff {
                maxDiff = currentDiff
            }
            evaluate(node!.left, maxVal: maxVal, minVal: minVal)
            evaluate(node!.right, maxVal: maxVal, minVal: minVal)
        }
        evaluate(root, maxVal: root!.val, minVal: root!.val)
        return maxDiff
    }
}

class SumRootToLeafNumbers {
    typealias TreeNode = TreeLeetcode.TreeNode
    func callAsFunction(_ root: TreeNode?) -> Int {
        var result = [Int]()
        func dfs(_ node: TreeNode?, path: String) {
            if node == nil {
                return
            }
            let node = node!
            let path = path + "\(node.val)"
            if node.left == nil && node.right == nil {
                result.append(Int(path) ?? 0)
            }
            
            dfs(node.left, path: path)
            dfs(node.right, path: path)
        }
        dfs(root, path: "")
        return result.reduce(0, +)
    }
}

/*
 problem:
 Given the root of a complete binary tree, return the number of the nodes in the tree.

 According to Wikipedia, every level, except possibly the last, is completely filled in a complete binary tree, and all nodes in the last level are as far left as possible. It can have between 1 and 2h nodes inclusive at the last level h.

 Design an algorithm that runs in less than O(n) time complexity.
 
 Testcases:
 Input: root = [1,2,3,4,5,6]
 Output: 6

 Input: root = []
 Output: 0

 Input: root = [1]
 Output: 1
 
 Constraints:
 The number of nodes in the tree is in the range [0, 5 * 104].
 0 <= Node.val <= 5 * 104
 The tree is guaranteed to be complete.
 
 link: https://leetcode.com/problems/count-complete-tree-nodes/
 explanation:
 primary idea:
 - If we know depth (d) of a complete binary tree, Number of nodes = 2^d - 1. Here we subtract 1 only because in level 1 we have only one node root
 - Divide and conquer
 - Divide it untill we find complete tree and return number of nodes. If we dont find complete binary tree, we divide it further till either we find complete Binary tree or nil
 - If not complete binary tree, number of nodes = left tree nodes + right tree nodes + 1
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class CountCompleteTreeNodes {
    typealias TreeNode = TreeLeetcode.TreeNode
    func countNodes(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        if isPerfectBST(root) {
            let depth = depth(root, goLeft: true)
            return power(2, depth) - 1
        } else {
            let left = countNodes(root?.left)
            let right = countNodes(root?.right)
            return left + 1 + right
        }
    }
    
    func power(_ base: Int, _ exp: Int) -> Int {
        return Int(pow(Double(base), Double(exp)))
    }
    
    func depth(_ node: TreeNode?, goLeft: Bool) -> Int {
        if node == nil {
            return 0
        }
        
        let next = goLeft ? node?.left : node?.right
        return 1 + depth(next, goLeft: goLeft)
    }
    
    func isPerfectBST(_ root: TreeNode?) -> Bool {
        let leftDepth = depth(root, goLeft: true)
        let rightDepth = depth(root, goLeft: false)
        
        return leftDepth == rightDepth
    }
}

class TrimBST {
    typealias TreeNode = TreeLeetcode.TreeNode
    func trimBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> TreeNode? {
        func trimBSTNode(_ node: TreeNode?) -> TreeNode? {
            if node == nil {
                return nil
            }
            let val = node!.val
            if val > high {
                return trimBSTNode(node?.left)
            } else if val < low {
                return trimBSTNode(node?.right)
            }
            
            node?.left = trimBSTNode(node?.left)
            node?.right = trimBSTNode(node?.right)
            return node
        }
        return trimBSTNode(root)
    }
}

class SubTreeOfAnotherTree {
    typealias TreeNode = TreeLeetcode.TreeNode
    func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        if subRoot == nil {
            return true
        }
        if root == nil {
            return false
        }
        
        func evaluateSubTree(_ sNode: TreeNode?, tNode: TreeNode?) -> Bool {
            if sNode == nil && tNode == nil  {
                return true
            }
            
            if sNode?.val != tNode?.val {
                return false
            }
            let isLeftSame = evaluateSubTree(sNode?.left, tNode: tNode?.left)
            let isRightSame = evaluateSubTree(sNode?.right, tNode: tNode?.right)
            return isLeftSame && isRightSame
        }
        
        if evaluateSubTree(root, tNode: subRoot) {
            return true
        }
        return isSubtree(root?.left, subRoot) || isSubtree(root?.right, subRoot)
    }
}

class FindBottomLeftValue {
    typealias TreeNode = TreeLeetcode.TreeNode
    func callAsfunction(_ root: TreeNode?) -> Int {
        var stack = [root], res: TreeNode? = nil
        while !stack.isEmpty {
            let level = stack
            res = level.first!
            stack.removeAll()
            
            for node in level {
                if node?.left != nil {
                    stack.append(node?.left)
                }
                
                if node?.right != nil {
                    stack.append(node?.right)
                }
            }
        }
        return res != nil ? res!.val : -1
    }
}

class FlipEquivalentBinaryTrees {
    typealias TreeNode = TreeLeetcode.TreeNode
    func flipEquiv(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
        if root1 == nil || root2 == nil {
            return root2 == nil && root1 == nil
        }
        
        if root1?.val != root2?.val {
            return false
        }
        
        let a = flipEquiv(root1?.left, root2?.left) && flipEquiv(root1?.right, root2?.right)
        return a || flipEquiv(root1?.left, root2?.right) && flipEquiv(root1?.right, root2?.left)
    }
}

/*
 problem:
 Given an integer n, return a list of all possible full binary trees with n nodes. Each node of each tree in the answer must have Node.val == 0.

 Each element of the answer is the root node of one possible tree. You may return the final list of trees in any order.

 A full binary tree is a binary tree where each node has exactly 0 or 2 children.
 
 Testcases:
 Input: n = 7
 Output: [[0,0,0,null,null,0,0,null,null,0,0],[0,0,0,null,null,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,null,null,null,null,0,0],[0,0,0,0,0,null,null,0,0]]

 Input: n = 3
 Output: [[0,0,0]]
 
 Constraints:
 1 <= n <= 20
 
 link: https://leetcode.com/problems/all-possible-full-binary-trees/
 explanation:
 primary idea:
 - Dynamic programming memoization
 - As we need to build n FBT, let's start from having 0 to n-1 left trees, then right trees will be n - 1 - lefttrees, we have -1 here as we exclude root node.
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class AllPossibleFullBinaryTrees {
    typealias TreeNode = TreeLeetcode.TreeNode
    func callAsfunction(_ n: Int) -> [TreeNode?] {
        var dp = [
            0: [],
            1: [TreeNode(0)]
        ]
        
        func allPossibleFBT(n: Int) -> [TreeNode] {
            if let trees = dp[n] {
                return trees
            }
            
            var result = [TreeNode]()
            for l in 0..<n {
                let r = n - 1 - l
                let leftTrees = allPossibleFBT(n: l)
                let rightTrees = allPossibleFBT(n: r)
                
                for leftTree in leftTrees {
                    for rightTree in rightTrees {
                        result.append(TreeNode(0, leftTree, rightTree))
                    }
                }
            }
            dp[n] = result
            return result
        }
        return allPossibleFBT(n: n)
    }
}


class LockingTree {
    
    struct Node {
        var parent: Int
        var children: [Int]
        var lockedBy: Int
    }
    
    private var nodes: [Node]
    
    init(_ parent: [Int]) {
        let n = parent.count
        nodes = [Node](repeating: .init(parent: -1, children: [], lockedBy: -1), count: n)
        for i in 0..<parent.count where parent[i] >= 0 {
            nodes[i].parent = parent[i]
            nodes[parent[i]].children.append(i)
        }
    }
    
    func lock(_ num: Int, _ user: Int) -> Bool {
        if nodes[num].lockedBy >= 0 {
            return false
        }
        nodes[num].lockedBy = user
        return true
    }
    
    func unlock(_ num: Int, _ user: Int) -> Bool {
        if nodes[num].lockedBy != user {
            return false
        }
        nodes[num].lockedBy = -1
        return true
    }
    
    func upgrade(_ num: Int, _ user: Int) -> Bool {
        var current = num
        while current != -1 {
            if nodes[current].lockedBy >= 0 {
                return false
            }
            current = nodes[current].parent
        }
        
        var stack = [num], lockedDescendants = [Int]()
        while !stack.isEmpty {
            let level = stack
            stack = []
            
            for node in level {
                for childNode in nodes[node].children {
                    stack.append(childNode)
                    if nodes[childNode].lockedBy >= 0 {
                        lockedDescendants.append(childNode)
                    }
                }
            }
        }
        
        if lockedDescendants.count == 0 {
            return false
        }
        
        for node in lockedDescendants {
            nodes[node].lockedBy = -1
        }
        nodes[num].lockedBy = user
        return true
    }
}

/*
 problem:
 Given the root of a binary tree, return the sum of every tree node's tilt.

 The tilt of a tree node is the absolute difference between the sum of all left subtree node values and all right subtree node values. If a node does not have a left child, then the sum of the left subtree node values is treated as 0. The rule is similar if the node does not have a right child.
 
 Testcases:
 Input: root = [1,2,3]
 Output: 1
 Explanation:
 Tilt of node 2 : |0-0| = 0 (no children)
 Tilt of node 3 : |0-0| = 0 (no children)
 Tilt of node 1 : |2-3| = 1 (left subtree is just left child, so sum is 2; right subtree is just right child, so sum is 3)
 Sum of every tilt : 0 + 0 + 1 = 1
 
 Input: root = [4,2,9,3,5,null,7]
 Output: 15
 Explanation:
 Tilt of node 3 : |0-0| = 0 (no children)
 Tilt of node 5 : |0-0| = 0 (no children)
 Tilt of node 7 : |0-0| = 0 (no children)
 Tilt of node 2 : |3-5| = 2 (left subtree is just left child, so sum is 3; right subtree is just right child, so sum is 5)
 Tilt of node 9 : |0-7| = 7 (no left child, so sum is 0; right subtree is just right child, so sum is 7)
 Tilt of node 4 : |(3+5+2)-(9+7)| = |10-16| = 6 (left subtree values are 3, 5, and 2, which sums to 10; right subtree values are 9 and 7, which sums to 16)
 Sum of every tilt : 0 + 0 + 0 + 2 + 7 + 6 = 15
 
 Input: root = [21,7,14,1,1,2,2,3,3]
 Output: 9
 
 Constraints:
 The number of nodes in the tree is in the range [0, 104].
 -1000 <= Node.val <= 1000
 
 
 link: https://leetcode.com/problems/binary-tree-tilt/
 explanation:
 primary idea:
 - postordertraversal and return sum, tiltSum
 Time Complexity: O(n)
 Space Complexity: O(logn)
 */
class BinaryTreeTilt {
    typealias TreeNode = TreeLeetcode.TreeNode
    func findTilt(_ root: TreeNode?) -> Int {
        
        func findSumOfTilt(_ root: TreeNode?) -> (sum: Int, tiltSum: Int) {
            if root == nil {
                return (0, 0)
            }
            
            let left = findSumOfTilt(root?.left)
            let right = findSumOfTilt(root?.right)
            let sum = left.sum + right.sum + root!.val
            
            let tiltSum = left.tiltSum + right.tiltSum  + abs(left.sum - right.sum)
            return (sum, tiltSum)
        }
        
        return findSumOfTilt(root).tiltSum
    }
}
