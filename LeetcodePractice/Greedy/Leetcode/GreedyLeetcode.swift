//
//  GreedyLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 05/04/22.
//

//https://leetcode.com/problems/maximum-subarray/
class MaxSubArray {
    func callAsFunction(_ nums: [Int]) -> Int {
        var maximumSub = Int.min, current = 0
        for num in nums {
            if current < 0 {
                current = 0
            }
            current += num
            maximumSub = max(maximumSub, current)
        }
        return maximumSub
    }
}

/*
 problem:
 Given an integer array nums, find a contiguous non-empty subarray within the array that has the largest product, and return the product.

 It is guaranteed that the answer will fit in a 32-bit integer.

 A subarray is a contiguous subsequence of the array.
 
 Testcases:
 Input: nums = [2,3,-2,4]
 Output: 6
 Explanation: [2,3] has the largest product 6.
 
 Input: nums = [-2,0,-1]
 Output: 0
 Explanation: The result cannot be 2, because [-2,-1] is not a subarray.
 
 Constraints:
 1 <= nums.length <= 2 * 104
 -10 <= nums[i] <= 10
 The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.
 
 link: https://leetcode.com/problems/maximum-product-subarray/
 explanation: https://www.youtube.com/watch?v=lXVy6YWFcRM
 primary idea:
 - Keep track of both min and max product
 - If encountered with 0, reset min and max
 Time Complexity: O(n)
 Space Complexity: O(1)
 */
class MaxProductSubArray {
    func callAsFunction(_ nums: [Int]) -> Int {
        var res = nums.max() ?? nums[0], curMin = 1, curMax = 1
        
        for num in nums {
            if num == 0 {
                curMin = 1
                curMax = 1
                continue
            }
            (curMin, curMax) = (min(curMax * num, curMin * num, num), max(curMax * num, curMin * num, num))
            res = max(res, curMax)
        }
        return res
    }
}

/*
 problem:
 You are given an integer array nums. You are initially positioned at the array's first index, and each element in the array represents your maximum jump length at that position.

 Return true if you can reach the last index, or false otherwise.
 
 Testcases:
 Input: nums = [2,3,1,1,4]
 Output: true
 Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.
 
 Input: nums = [3,2,1,0,4]
 Output: false
 Explanation: You will always arrive at index 3 no matter what. Its maximum jump length is 0, which makes it impossible to reach the last index.
 
 Constraints:
 1 <= nums.length <= 104
 0 <= nums[i] <= 105
 
 link: https://leetcode.com/problems/jump-game/
 explanation: https://www.youtube.com/watch?v=Yan0cv2cLy8
 primary idea:
 - Greedy. Traverse from last second to 0 index and check if next is reachable.if yes, update goal position. After Traversing, if the goal is at 0 position then it's reachable to last index
 Time Complexity: O(n)
 Space Complexity: O(1)
 */
class JumpGame {
    /*
     primary idea:
     - DFS With Memoization
     Time Complexity: O(n^2)
     Space Complexity: O(n)
     */
    func dfsWithMemo(_ nums: [Int]) -> Bool {
        var cache = [Int: Bool]()
        func backtrack(_ position: Int) -> Bool {
            if let val = cache[position] {
                return val
            }
            if position == nums.count - 1 {
                return true
            }
            if position >= nums.count {
                return false
            }
            
            var res = false
            for i in position..<position + nums[position] {
                if backtrack(i+1) && !res {
                    res = true
                    break
                }
            }
            cache[position] = res
            return res
        }
        return backtrack(0)
    }
    
    /*
     primary idea:
     - Greedy
     - Traverse from last to first, checking if the goal is reachable
     Time Complexity: O(n)
     Space Complexity: O(1)
     */
    func greedy(_ nums: [Int]) -> Bool {
        var goal = nums.count - 1
        var i = nums.count - 2
        while i >= 0{
            if i + nums[i] >= goal {
                goal = i
            }
            i -= 1
        }
        return goal == 0
    }
}
/*
 problem:
 Given an array of non-negative integers nums, you are initially positioned at the first index of the array.

 Each element in the array represents your maximum jump length at that position.

 Your goal is to reach the last index in the minimum number of jumps.

 You can assume that you can always reach the last index.
 
 Testcases:
 Input: nums = [2,3,1,1,4]
 Output: 2
 Explanation: The minimum number of jumps to reach the last index is 2. Jump 1 step from index 0 to 1, then 3 steps to the last index.
 
 Input: nums = [2,3,0,1,4]
 Output: 2
 
 Constraints:
 1 <= nums.length <= 104
 0 <= nums[i] <= 1000
 
 link: https://leetcode.com/problems/jump-game-ii/
 explanation: https://www.youtube.com/watch?v=dJ7sWiOoK7g&list=PLot-Xpze53lcvx_tjrr_m2lgD2NsRHlNO&index=20
 primary idea:
 - BFS, with l and r pointers
 - Keep track of BFS levels
 Time Complexity: O(n)
 Space Complexity: O(1)
 */
class JumpII {
    func bfs(_ nums: [Int]) -> Int {
        var l = 0, r = 0, res = 0
        while r < nums.count-1 {
            res += 1
            var farthest = 0
            for i in l..<r+1 {
                farthest = max(farthest, i + nums[i])
            }
            l = r+1
            r = farthest
        }
        return res
    }
}

/*
 problem:
 There are n gas stations along a circular route, where the amount of gas at the ith station is gas[i].

 You have a car with an unlimited gas tank and it costs cost[i] of gas to travel from the ith station to its next (i + 1)th station. You begin the journey with an empty tank at one of the gas stations.

 Given two integer arrays gas and cost, return the starting gas station's index if you can travel around the circuit once in the clockwise direction, otherwise return -1. If there exists a solution, it is guaranteed to be unique
 
 Testcases:
 Input: gas = [1,2,3,4,5], cost = [3,4,5,1,2]
 Output: 3
 Explanation:
 Start at station 3 (index 3) and fill up with 4 unit of gas. Your tank = 0 + 4 = 4
 Travel to station 4. Your tank = 4 - 1 + 5 = 8
 Travel to station 0. Your tank = 8 - 2 + 1 = 7
 Travel to station 1. Your tank = 7 - 3 + 2 = 6
 Travel to station 2. Your tank = 6 - 4 + 3 = 5
 Travel to station 3. The cost is 5. Your gas is just enough to travel back to station 3.
 Therefore, return 3 as the starting index.

 Input: gas = [2,3,4], cost = [3,4,3]
 Output: -1
 Explanation:
 You can't start at station 0 or 1, as there is not enough gas to travel to the next station.
 Let's start at station 2 and fill up with 4 unit of gas. Your tank = 0 + 4 = 4
 Travel to station 0. Your tank = 4 - 3 + 2 = 3
 Travel to station 1. Your tank = 3 - 3 + 3 = 3
 You cannot travel back to station 2, as it requires 4 unit of gas but you only have 3.
 Therefore, you can't travel around the circuit once no matter where you start.
 
 
 Constraints:
 n == gas.length == cost.length
 1 <= n <= 105
 0 <= gas[i], cost[i] <= 104
 
 
 link: https://leetcode.com/problems/gas-station/
 explanation:
 primary idea:
 - Base case, if total of gas is > total of cost, then we are guaranteed to have a solution
 - Keep track of sum of remaining gas from each station, if we encounter a negative value then it concludes it cannot be a start position. Not only that but stations till here all cannot be solutions. If we notice all values are positive, so station till prev cannot be solution.
 - As soon we reach a negative value, we reset start and total
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class GasStation {
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        guard gas.reduce(0, +) >= cost.reduce(0, +) else {
            return -1
        }
        
        var total = 0, start = 0
        
        for i in 0..<gas.count {
            total += (gas[i] - cost[i])
            
            if total < 0 {
                total = 0
                start = i + 1
            }
        }
        
        return start
    }
}


/*
 problem:
 You are given a string s. We want to partition the string into as many parts as possible so that each letter appears in at most one part.

 Note that the partition is done so that after concatenating all the parts in order, the resultant string should be s.

 Return a list of integers representing the size of these parts.
 
 Testcases:
 Input: s = "ababcbacadefegdehijhklij"
 Output: [9,7,8]
 Explanation:
 The partition is "ababcbaca", "defegde", "hijhklij".
 This is a partition so that each letter appears in at most one part.
 A partition like "ababcbacadefegde", "hijhklij" is incorrect, because it splits s into less parts.
 
 Input: s = "eccbbbbdec"
 Output: [10]
 
 
 Constraints:
 1 <= s.length <= 500
 s consists of lowercase English letters.
 
 
 link: https://leetcode.com/problems/partition-labels/
 explanation: https://www.youtube.com/watch?v=B7m8UmZE-vw
 primary idea:
 - calculate last index of all chars and store in hashmap
 - iterate through loop again, update end, increase size, if i == end, then we found a partition
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class PartitionLabels {
    func callAsFunction(_ s: String) -> [Int] {
        let s = Array(s)
        var map = [Character: Int]()
        
        for i in 0..<s.count {
            let char = s[i]
            map[char] = max(i, map[char, default: 0])
        }
        
        var size = 0, end = 0, result = [Int]()
        
        for i in 0..<s.count {
            let currentChar = s[i]
            size += 1
            end = max(end, map[currentChar]!)
            if i == end {
                result.append(size)
                size = 0
            }
        }
        return result
    }
}
