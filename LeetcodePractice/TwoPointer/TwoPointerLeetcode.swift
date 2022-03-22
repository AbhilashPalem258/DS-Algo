//
//  TwoPointerLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 28/02/22.
//

//https://leetcode.com/list?selectedList=9kasr77m
import Foundation

/*
 problem:
 Given a non-negative integer c, decide whether there're two integers a and b such that a2 + b2 = c.
 
 Testcases:
 
 Example 1:
 Input: c = 5
 Output: true
 Explanation: 1 * 1 + 2 * 2 = 5
 
 Example 2:
 Input: c = 3
 Output: false
 
 
 Constraints:
 0 <= c <= 231 - 1
 
 link: https://leetcode.com/problems/sum-of-square-numbers/
 explanation:
 primary idea:
 - if a is 0 then b is Sqrt(c). But we need to exclude 0.
 - if the sum using formula is more than target then we need to reduce right
 - if the sum is less, then we need to increase left
 Time Complexity: O(N)
 Space Complexity: O(1)
 */
class SumOfSquareNumbers {
    func callAsFunction(_ c: Int) -> Bool {
        var left = 0
        var right = Int(sqrt(Double(c)))
        
        while left <= right {
            let sum = (left * left) + (right * right)
            if sum < c {
                left += 1
            } else if sum > c {
                right -= 1
            } else {
                return true
            }
        }
        return false
    }
}

/*
 problem:
 Given the root of a Binary Search Tree and a target number k, return true if there exist two elements in the BST such that their sum is equal to the given target.
 
 Testcases:
 
 Example 1:
 Input: root = [5,3,6,2,4,null,7], k = 9
 Output: true
 
 Example 2:
 Input: root = [5,3,6,2,4,null,7], k = 28
 Output: false
 
 Constraints:
 The number of nodes in the tree is in the range [1, 104].
 -104 <= Node.val <= 104
 root is guaranteed to be a valid binary search tree.
 -105 <= k <= 105
 
 
 link: https://leetcode.com/problems/two-sum-iv-input-is-a-bst/
 explanation:
 primary idea:
 - Inordertraversal to generate sorted arr and two pointer on sorted arr
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class TwoSumIV {
    typealias TreeNode = TreeLeetcode.TreeNode
    
    func callAsFunction(_ root: TreeNode?, _ k: Int) -> Bool {
        if root == nil || (root?.left == nil && root?.right == nil) {
            return false
        }
        var sortedArr = [Int]()
        func inorderTraversal(_ node: TreeNode?) {
            if node == nil {
                return
            }
            inorderTraversal(node?.left)
            sortedArr.append(node!.val)
            inorderTraversal(node?.right)
        }
        inorderTraversal(root)
        
        var left = 0
        var right = sortedArr.count - 1
        
        while left < right {
            let sum = sortedArr[left] + sortedArr[right]
            if sum < k {
                left += 1
            } else if sum > k {
                right -= 1
            } else {
                return true
            }
        }
        return false
    }
}


/*
 problem:
 Give a binary string s, return the number of non-empty substrings that have the same number of 0's and 1's, and all the 0's and all the 1's in these substrings are grouped consecutively.

 Substrings that occur multiple times are counted the number of times they occur.
 
 Testcases:
 Example 1:
 Input: s = "00110011"
 Output: 6
 Explanation: There are 6 substrings that have equal number of consecutive 1's and 0's: "0011", "01", "1100", "10", "0011", and "01".
 Notice that some of these substrings repeat and are counted the number of times they occur.
 Also, "00110011" is not a valid substring because all the 0's (and 1's) are not grouped together.
 
 Example 2:
 Input: s = "10101"
 Output: 4
 Explanation: There are 4 substrings: "10", "01", "10", "01" that have equal number of consecutive 1's and 0's.
 
 
 Constraints:
 1 <= s.length <= 105
 s[i] is either '0' or '1'.
 
 
 link: https://leetcode.com/problems/count-binary-substrings/
 explanation: https://www.youtube.com/watch?v=MGPHPadxhtQ
 primary idea:
 - "000111" - Grouped, "101010" - ungrouped
 - We need to find substrings only from grouped.
 - "000111". This has a count of 3 substrings "01" "0011" "000111"
 - Sliding window.
 - prev contains count of firstBinary element. current contains count of current binary element
 - whenever we find a char not equal to earlier. we add count of substrings and start sliding window from prev.
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class CountBinarySubstrings {
    func callAsFunction(_ s: String) -> Int {
        let s = Array(s)
        var count = 0, i = 1, prev = 0, current = 1
        
        while i < s.count {
            if s[i - 1] != s[i] {
                count += min(prev, current)
                prev = current
                current = 1
            } else {
                current += 1
            }
            i += 1
        }
        count += min(prev, current)
        return count
    }
}
