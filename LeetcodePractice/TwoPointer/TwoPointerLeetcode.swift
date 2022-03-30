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
 Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can trap after raining.
 
 Testcases:
 Input: height = [0,1,0,2,1,0,1,3,2,1,2,1]
 Output: 6
 Explanation: The above elevation map (black section) is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped.
 
 Input: height = [4,2,0,3,2,5]
 Output: 9
 
 Constraints:
 n == height.length
 1 <= n <= 2 * 104
 0 <= height[i] <= 105
 
 link: https://leetcode.com/problems/trapping-rain-water/
 explanation: https://www.youtube.com/watch?v=ZI2z5pq0TqA&t=213s (Only check explanation part, coding part is wrong in video)
 primary idea:
 - Two pointer, l is left pointer starts at start of arr and r is right pointer, starts at end of arr.
 Time Complexity: O(n)
 Space Complexity: O(1)
 */

class TrappingRainWater {
    func callAsFunction(_ height: [Int]) -> Int {
        var l = 0, r = height.count - 1
        var maxLeft = height[0], maxRight = height[height.count - 1]
        
        var result = 0
        
        while l < r {
            if maxLeft <= maxRight {
                l += 1
                result += max(0, maxLeft - height[l])
                maxLeft = max(maxLeft, height[l])
            } else {
                r -= 1
                result += max(0, maxRight - height[r])
                maxRight = max(maxRight, height[r])
            }
        }
        
        return result
    }
}

/*
 link: https://leetcode.com/problems/container-with-most-water/
 explanation: https://www.youtube.com/watch?v=UuiTKBwPgAo
 Primary Idea:
     - Two Pointer
     - --> L , R <--
 */
struct ContainerWithMaxWater {
    func callAsFunction(_ height: [Int]) -> Int {
        var l = 0, r = height.count - 1
        var maxArea = 0
        
        while l < r {
            let h = min(height[l], height[r])
            let w = r - l
            maxArea = max(h * w, maxArea)
            if height[l] < height[r] {
                l += 1
            } else if height[l] == height[r] {
                if height[l+1] < height[r-1] {
                    l += 1
                } else {
                    r -= 1
                }
            } else {
                r -= 1
            }
        }
        
        return maxArea
    }
}

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
 You are given an array people where people[i] is the weight of the ith person, and an infinite number of boats where each boat can carry a maximum weight of limit. Each boat carries at most two people at the same time, provided the sum of the weight of those people is at most limit.

 Return the minimum number of boats to carry every given person.
 
 Testcases:
 Input: people = [1,2], limit = 3
 Output: 1
 Explanation: 1 boat (1, 2)

 Input: people = [3,2,2,1], limit = 3
 Output: 3
 Explanation: 3 boats (1, 2), (2) and (3)

 Input: people = [3,5,3,4], limit = 5
 Output: 4
 Explanation: 4 boats (3), (3), (4), (5)
 
 Constraints:
 1 <= people.length <= 5 * 104
 1 <= people[i] <= limit <= 3 * 104
 
 link: https://leetcode.com/problems/boats-to-save-people/
 explanation: https://www.youtube.com/watch?v=XbaxWuHIWUs
 primary idea:
 - Two sum variation
 - Sort the people arr
 - if we find the sum of weight more than limit, the person with higher weight should go alone in a boat
 - If sum is <= limit, then both can travel along eachother in single boat
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class BoatsToSavePeople {
    func callAsFunction(_ people: [Int], _ limit: Int) -> Int {
        let people = people.sorted()
        
        var res = 0
        var i = 0, j = people.count - 1
        while i <= j {
            let sumOfWeights = people[i] + people[j]
            if sumOfWeights > limit {
                j -= 1
            } else {
                i += 1
                j -= 1
            }
            res += 1
        }
        return res
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
