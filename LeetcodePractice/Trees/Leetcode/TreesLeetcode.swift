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
}

//link: https://leetcode.com/problems/balanced-binary-tree/
class BalancedBinaryTree {
    func callAsFunction(_ root: TreeLeetcode.TreeNode?) -> Bool {
        guard let node = root else {
            return true
        }
        var isBalanced = true

        isBalancedHelper(node, isBalanced: &isBalanced)
        return isBalanced
    }
    
    @discardableResult
    func isBalancedHelper(_ node: TreeLeetcode.TreeNode?, isBalanced: inout Bool) -> Int {
        guard let node = node, isBalanced else {
            return -1
        }

        let left = isBalancedHelper(node.left, isBalanced: &isBalanced), right = isBalancedHelper(node.right, isBalanced: &isBalanced)
        if abs(left - right) > 1 {
            isBalanced = false
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
    
    // Prefix sum!
    var map: [Int: Int] = [:]
    var k = 0
    var result = 0
    
    func pathSum(_ root: TreeLeetcode.TreeNode?, _ sum: Int) -> Int {
        k = sum
        // Situation where target sum starts from beginning
        map[0] = 1
        dfs(root, 0)
        return result
    }
    
    func dfs(_ root: TreeLeetcode.TreeNode?, _ currentSum: Int) {
        guard root != nil else {return }
        
        let currentSum = currentSum + root!.val
        
        if let value = map[currentSum-k] {
            result += value
        }
        
        map[currentSum, default:0] += 1
        
        
        // Recurse left & right
        dfs(root?.left, currentSum)
        dfs(root?.right, currentSum)
        
        // Path must go downwards, don't mix prefix sums from left & right subtrees
        // print("NODE: \(root!.val)")
        // print("Before", map)
        map[currentSum, default:0] -= 1
        // print("After", map)
        // print()
    }
    
}

//explanation link: https://www.youtube.com/watch?v=nHR8ytpzz7c
//leetcode link:
class HouseRobberyIII {
    func rob(_ root: TreeLeetcode.TreeNode?) -> Int {
        func dfs(_ node: TreeLeetcode.TreeNode?) -> (Int, Int) {
            guard let node = node else {
                return (0, 0)
            }
            
            let leftPair = dfs(node.left)
            let rightPair = dfs(node.right)
            
            let withRoot = leftPair.1 + node.val + rightPair.1
            let withoutRoot = max(leftPair.0, leftPair.1) + max(rightPair.0, rightPair.1)
            
            return (withRoot, withoutRoot)
        }
        let result = dfs(root)
        return max(result.0, result.1)
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
