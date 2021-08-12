//
//  DPLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 31/07/21.
//

import Foundation

class FibonacciNumbers {
    func callAsFunction(_ n: Int) -> Int {
        if n == 0 { return 0 }
        if n == 1 { return 1 }
        
        var prev = 1, postPrev = 0
        for _ in 2...n {
            (prev, postPrev) = (prev + postPrev, prev)
        }
        return prev
    }
}

class ClimbStairs {
    func callAsFunction(_ n: Int) -> Int {
        if n == 1 {
            return 1
        }
        if n == 2{
            return 2
        }
        //dp2 dp1 dp
        //    dp2 dp1 dp
        var dp2 = 1, dp1 = 2
        for _ in 3..<n+1 {
            (dp2, dp1) = (dp1, dp1 + dp2)
        }
        return dp1
    }
}

class MinCostClimbStairs {
    /*
     Approach: Greedy
     TimeComplexity: O(n)
     SpaceComplexity: O(n)
     */
    func greedy(_ arr: [Int]) -> Int {
        var arr = arr
        for i in 2..<arr.count {
            arr[i] += min(arr[i - 1], arr[i - 2])
        }
        return min(arr[arr.count - 1], arr[arr.count - 2])
    }
    
    /*
     Approach: Dynamic Programming
     TimeComplexity: O(n)
     SpaceComplexity: O(1)
     */
    func dp(_ arr: [Int]) -> Int {
        //dp2 dp1 dp
        //    dp2 dp1 dp
        var dp2 = 0, dp1 = 0
        for i in arr.indices {
            (dp2, dp1) = (dp1, arr[i] + min(dp2, dp1))
        }
        return min(dp2, dp1)
    }
    
}

class HouseRobbery {
    func callAsFunction(_ nums: [Int]) -> Int {
        var rob1 = 0, rob2 = 0
        //[rob1, rob2, n, n+1, n+2...]
        for num in nums {
            (rob1, rob2) = (rob2, max(num + rob1, rob2))
        }
        return rob2
    }
}

class HouseRobberyII {
    func rob(_ nums: [Int]) -> Int {
        func helper(start: Int, end: Int) -> Int {
            var rob1 = 0, rob2 = 0
            for i in start..<end {
                (rob1, rob2) = (rob2 ,max(nums[i] + rob1, rob2))
            }
            return rob2
        }
        return max(nums[0], helper(start: 1, end: nums.count), helper(start: 0, end: nums.count - 1))
    }
}

class DecodeWays {
    /*
     Approach: Iterative + Memoization (Top Bottom Iterative Approach)
     TimeComplexity: O(n)
     SpaceComplexity: O(n)
     */
    func numDecodings(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        let sChars = Array(s)
        var dp = Array(repeating: 0, count: s.count+1)
        dp[0] = 1
        dp[1] = s.prefix(1) == "0" ? 0 : 1
        
        for i in 2..<s.count+1 {
            let integerOneVal = Int(String(sChars[i-1]))
            let integerTwoVal = Int(String(sChars[i-2..<i]))
            
            if integerOneVal! > 0 && integerOneVal! <= 9 {
                dp[i] += dp[i-1]
            }
            if integerTwoVal! >= 10 && integerTwoVal! <= 26 {
                dp[i] += dp[i-2]
            }
        }
        
        return dp[s.count]
    }
    
    /*
     Approach: Iterative + Memoization (Top Bottom Iterative Approach)
     TimeComplexity: O(n)
     SpaceComplexity: O(1)
     */
    func numDecodingsLinearWithConstantSpace(_ s: String) -> Int {
        //dp2 dp1 dp
        //    dp2 dp1 dp
        let sChars = Array(s)
        var dp2 = 1, dp1 = sChars[0] == "0" ? 0 : 1
        
        for i in 2..<s.count+1 {
            let integerOneValue = Int(String(sChars[i-1]))
            let integerTwoValue = Int(String(sChars[i-2..<i]))
            
            var dp = 0
            if integerOneValue! > 0 && integerOneValue! <= 9 {
                dp += dp1
            }
            if integerTwoValue! >= 10 && integerTwoValue! <= 26 {
                dp += dp2
            }
            
            dp2 = dp1
            dp1 = dp
        }
        return dp1
    }
}

class WordBreak {
    var memo = [String: Bool]()
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        if s.isEmpty {
            return true
        }
        if let val = memo[s] {
            return val
        }
        var breakable = false
        for word in wordDict {
            if s.hasPrefix(word) {
                breakable = breakable || wordBreak(String(s.dropFirst(word.count)), wordDict)
            }
        }
        memo[s] = breakable
        return breakable
    }
}

class WordBreakII {
    var memo = [String: Bool]()
    func wordBreak(_ s: String, _ wordDict: [String]) -> [String] {
        if s.isEmpty {
            return []
        }
        var combinations = [String](), memo = [String: Bool]()
        func backtrack(_ s: String, current: String) -> Bool {
            if s.isEmpty {
                combinations.append(current)
                return true
            }
            if let val = memo[s], val == false {
                return false
            }
            
            var breakable = false
            for word in wordDict {
                if s.hasPrefix(word) {
                    let nextCurrent = current == "" ? "\(word)" : "\(current) \(word)"
                    if backtrack(String(s.dropFirst(word.count)), current: nextCurrent) {
                        breakable = true
                    }
                }
            }
            memo[s] = breakable
            return breakable
        }
        
        return backtrack(s, current: "") ? combinations : []
    }
}

class PascalTriangle {
    func generate(_ numRows: Int) -> [[Int]] {
        if numRows == 0 {
            return []
        }
        
        var result = Array(repeating: [Int](), count: numRows)
        result[0].append(1)
        
        for row in 1..<numRows {
            result[row].append(1)
            let prevRow = result[row - 1]
            for col in 1..<row {
                result[row].append(prevRow[col - 1] + prevRow[col])
            }
            result[row].append(1)
        }
        
        return result
    }
}

/*
 problem:
 There is a fence with n posts, each post can be painted with one of the k colors.
 You have to paint all the posts such that no more than two adjacent fence posts have the same color.
 Return the total number of ways you can paint the fence.
 
 n and k are non-negative integers.

 Testcases:
 Input: n=3, k=2
 Output: 6
 
 Input: n=2, k=2
 Output: 4
  
 link: https://www.lintcode.com/problem/514
 explanation: https://www.youtube.com/watch?v=ju8vrEAsa3Q&t=731s
 primary idea:
 - Classic DP Fibonacci Approach
 - Solve subproblems by solving for fence from 2..n
 - Calculate and add no of ways we can paint the fence till nth fence such that no more than two consecutive fence have same color
    - with last two fences having same color
    - with last two fences having different color
 - n - 1 fence's total combination's * (k - 1) give total number of ways with n fences.
 Time Complexity: O(n)
 Space Complexity: O(1)
 */
class PaintFence {
    func numWays(_ n: Int, _ k: Int) -> Int {
        if n == 0 || k == 0 {
            return 0
        }
        if n == 1 {
            return k
        }
        
        var lastSame = k * 1
        var lastDiff = k * (k - 1)
        for _ in 3..<n+1 {
            (lastSame, lastDiff) = (lastDiff, (lastSame + lastDiff) * (k - 1))
        }
        return lastSame + lastDiff
    }
}

struct LongestIncreasingSubsequence {
    func dfsWithMemo(_ arr: [Int]) -> Int {
        var lis = 0, dp = [Int: Int]()
        func backtrack(_ start: Int, lastElement: Int, length: Int) {
            lis = max(lis, length)
            
            for i in start..<arr.count {
                if arr[i] <= lastElement {
                    break
                }
                backtrack(i + 1, lastElement: arr[i], length: length + 1)
            }
        }
        backtrack(0, lastElement: 0, length: 0)
        return lis
    }
    /*
     TimeComplexity: O(n^2)
     */
    func dp(_ nums: [Int]) -> Int {
        var lis = Array(repeating: 1, count: nums.count)
        
        var i = nums.count - 1
        while i >= 0 {
            for j in i+1..<nums.count {
                if nums[i] < nums[j] {
                    lis[i] = max(lis[i], 1+lis[j])
                }
            }
            i -= 1
        }
        return lis.max() ?? -1
    }
}

/*
 problem:
 Given an integer array nums, return the length of the longest strictly increasing subsequence.
 
 Testcases:
 Input: nums = [10,9,2,5,3,7,101,18]
 Output: 4
 
 Input: nums = [0,1,0,3,2,3]
 Output: 4
 
 Input: nums = [7,7,7,7,7,7,7]
 Output: 1
 
 Constraints:
 1 <= nums.length <= 2500
 -104 <= nums[i] <= 104
 
 link: https://leetcode.com/problems/longest-increasing-subsequence/
 primary idea:
 - Create a result arr. As soon as we found a num higher than last num in result arr, we append it into it. If not, binary search for insert position and replace item at that position. The count of result is LIS
 Time Complexity: O(nlogn)
 Space Complexity: O(n)
 */
class LISOptimized {
    func lengthOfLIS(_ nums: [Int]) -> Int {
       var subs = [nums[0]]
        
        func binarySearch(target: Int) -> Int {
            var l = 0, r = subs.count - 1
            while l <= r {
                let midid = (l+r)/2
                if subs[midid] < target {
                    l = midid + 1
                } else if target < subs[midid] {
                    r = midid - 1
                } else {
                    return midid
                }
            }
            return l
        }
        
        for i in 1..<nums.count {
            let num = nums[i]
            if num > subs[subs.count - 1] {
                subs.append(num)
            } else {
                let searchId = binarySearch(target: num)
                subs[searchId] = num
            }
        }
        
        return subs.count
    }
}

/*
 problem:
 A robot is located at the top-left corner of a m x n grid (marked 'Start' in the diagram below).

 The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid (marked 'Finish' in the diagram below).

 How many possible unique paths are there?

 Testcases:
 Input: m = 3, n = 7
 Output: 28
 
 Input: m = 3, n = 2
 Output: 3
 
 Input: m = 7, n = 3
 Output: 28
 
 Input: m = 3, n = 3
 Output: 6
 
 Constraints:
 1 <= m, n <= 100
 It's guaranteed that the answer will be less than or equal to 2 * 109
 
 link: https://leetcode.com/problems/unique-paths/
 explanation: https://www.youtube.com/watch?v=IlEsdxuD4lY
 primary idea:
 - Classic DP Iterative + Memoization (Top Bottom Iterative Approach)
 Time Complexity: O(m*n)
 Space Complexity: O(2n)
 */
class UniquePaths {
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        var memoRow = [Int](repeating: 1, count: n)
        
        for _ in 1..<m {
            var newRow = [Int](repeating: -1, count: n)
            for col in 0..<n {
                if col == 0 {
                    newRow[col] = memoRow[col]
                } else {
                    newRow[col] = newRow[col-1] + memoRow[col]
                }
            }
            memoRow = newRow
        }
        return memoRow[n-1]
    }
}

/*
 problem:
 A robot is located at the top-left corner of a m x n grid (marked 'Start' in the diagram below).

 The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid (marked 'Finish' in the diagram below).

 Now consider if some obstacles are added to the grids. How many unique paths would there be?

 An obstacle and space is marked as 1 and 0 respectively in the grid.
 
 Testcases:
 Input: obstacleGrid = [[0,0,0],[0,1,0],[0,0,0]]
 Output: 2
 
 Input: obstacleGrid = [[0,1],[0,0]]
 Output: 1
 
 Constraints:
 m == obstacleGrid.length
 n == obstacleGrid[i].length
 1 <= m, n <= 100
 obstacleGrid[i][j] is 0 or 1.
 
 link: https://leetcode.com/problems/unique-paths-ii/
 explanation: https://www.youtube.com/watch?v=nZSXWXzn1aM
 primary idea:
 - Classic DP Iterative + Memoization (Top Bottom Iterative Approach)
 - Followup for unique paths
 */
class UniquePathsII {
    /*
     Approach: Only DFS (Bottom Up recursive Approach)
     TimeComplexity: 2^(R*C)
     SpaceComplexity: O(1)
     Result: TLE
     */
    func uniquePathsWithObstaclesOnlyDFS(_ obstacleGrid: [[Int]]) -> Int {
        var paths = 0
        let m = obstacleGrid.count, n = obstacleGrid[0].count
        
        func dfs(_ row: Int, _ col: Int) {
            if row < 0 || row == m || col < 0 || col == n || obstacleGrid[row][col] == 1 {
                return
            }
            if row == m-1 && col == n-1 {
                paths += 1
                return
            }
            dfs(row+1, col)
            dfs(row, col+1)
        }
        
        dfs(0, 0)
        return paths
    }
    
    /*
     Approach: DFS + Memoization (Bottom Up recursive Approach)
     TimeComplexity: O(r*c)
     SpaceComplexity: O(r*c)
     */
    func uniquePathsWithObstaclesDFSWithMemoization(_ obstacleGrid: [[Int]]) -> Int {
        let m = obstacleGrid.count, n = obstacleGrid[0].count
        var dp = [[Int]](repeating: [Int](repeating: -1, count: n), count: m)
        
        func dfs(row: Int, col: Int) -> Int {
            if row < 0 || row == m || col < 0 || col == n {
                return 0
            }
            if obstacleGrid[row][col] == 1 {
                dp[row][col] = 0
                return 0
            }
            if row == m-1 && col == n-1 {
                dp[row][col] = 1
                return 1
            }
            if dp[row][col] > -1 {
                return dp[row][col]
            }
            dp[row][col] = dfs(row: row, col: col+1) + dfs(row: row+1, col: col)
            return dp[row][col]
        }
        return dfs(row: 0, col: 0)
    }
    
    
    /*
     Approach: Iterative + Memoization (Top Bottom Iterative Approach)
     TimeComplexity: O(r*c)
     SpaceComplexity: O(r*c)
     */
    func uniquePathsWithObstaclesIterativeWithMemo(_ obstacleGrid: [[Int]]) -> Int {
        var obstacleGrid = obstacleGrid
        let m = obstacleGrid.count, n = obstacleGrid[0].count
        if obstacleGrid[0][0] == 1 {
            return 0
        }
        
        for row in 0..<m {
            for col in 0..<n {
                //First Row or column
                if row == 0 || col == 0 {
                    //check if its obstacle or if its prev value is a obstacle
                    if obstacleGrid[row][col] == 1 || (col != 0 && obstacleGrid[row][col-1] == 0) || (row != 0 && obstacleGrid[row - 1][col] == 0) {
                        obstacleGrid[row][col] = 0
                    } else {
                        obstacleGrid[row][col] = 1
                    }
                    continue
                }
                
                //If obstacle in other cells
                if obstacleGrid[row][col] == 1 {
                    obstacleGrid[row][col] = 0
                    continue
                }
                
                obstacleGrid[row][col] = obstacleGrid[row][col - 1] + obstacleGrid[row - 1][col]
            }
        }
        
        return obstacleGrid[m-1][n-1]
    }
    
    /*
     Approach: Iterative + Memoization (Top Bottom Iterative Approach)
     TimeComplexity: O(r*c)
     SpaceComplexity: O(r)
     */
    func uniquePathsWithObstaclesIterativeWithMemoII(_ obstacleGrid: [[Int]]) -> Int {
        let m = obstacleGrid.count, n = obstacleGrid[0].count
        var memoRow = [Int](repeating: 0, count: n)
        if obstacleGrid[0][0] == 1 {
            return 0
        } else {
            memoRow[0] = 1
        }
        
        for col in 1..<n {
            if obstacleGrid[0][col] == 1 {
                memoRow[col] = 0
                break
            } else {
                memoRow[col] = 1
            }
        }
        
        for row in 1..<m {
            var newRow = [Int](repeating: -1, count: n)
            for col in 0..<n {
                if obstacleGrid[row][col] == 1 {
                    newRow[col] = 0
                } else {
                    if col == 0 {
                        newRow[col] = 0 + memoRow[col]
                    } else {
                        newRow[col] = newRow[col-1] + memoRow[col]
                    }
                }
            }
            memoRow = newRow
        }
        return memoRow[n-1]
    }
}

/*
 problem:
 Given a m x n grid filled with non-negative numbers, find a path from top left to bottom right, which minimizes the sum of all numbers along its path.

 Note: You can only move either down or right at any point in time.
 
 Testcases:
 Input: grid = [[1,3,1],[1,5,1],[4,2,1]]
 Output: 7
 
 Input: grid = [[1,2,3],[4,5,6]]
 Output: 12
 
 Constraints:
 m == grid.length
 n == grid[i].length
 1 <= m, n <= 200
 0 <= grid[i][j] <= 100
 
 link: https://leetcode.com/problems/minimum-path-sum/
 explanation: https://www.youtube.com/watch?v=pGMsrvt0fpk&t=5s
 primary idea:
 - Classic DP Iterative + Memoization (Top Bottom Iterative Approach)
 - For each cell, calculate min sum from ways where it can be reached
 Time Complexity: O(m*n)
 Space Complexity: O(n)
 */
class MinPathSum {
    func minPathSumTopBottomWithMemo(_ grid: [[Int]]) -> Int {
        let m = grid.count, n = grid[0].count
        var memoRow = Array(repeating: 0, count: n)
        memoRow[0] = grid[0][0]
        
        for col in 1..<n {
            memoRow[col] = memoRow[col - 1] + grid[0][col]
        }
        
        for row in 1..<m {
            var newRow = Array(repeating: 0, count: n)
            for col in 0..<n {
                if col == 0 {
                    newRow[col] = memoRow[col] + grid[row][col]
                } else {
                    newRow[col] = grid[row][col] + min(newRow[col-1], memoRow[col])
                }
            }
            memoRow = newRow
        }
        return memoRow[n-1]
    }
}

/*
 problem:
 The demons had captured the princess and imprisoned her in the bottom-right corner of a dungeon. The dungeon consists of m x n rooms laid out in a 2D grid. Our valiant knight was initially positioned in the top-left room and must fight his way through dungeon to rescue the princess.

 The knight has an initial health point represented by a positive integer. If at any point his health point drops to 0 or below, he dies immediately.

 Some of the rooms are guarded by demons (represented by negative integers), so the knight loses health upon entering these rooms; other rooms are either empty (represented as 0) or contain magic orbs that increase the knight's health (represented by positive integers).

 To reach the princess as quickly as possible, the knight decides to move only rightward or downward in each step.

 Return the knight's minimum initial health so that he can rescue the princess.

 Note that any room can contain threats or power-ups, even the first room the knight enters and the bottom-right room where the princess is imprisoned.
 
 Testcases:
 Input: dungeon = [[-2,-3,3],[-5,-10,1],[10,30,-5]]
 Output: 7
 
 Input: dungeon = [[0]]
 Output: 1
 
 Constraints:
 m == dungeon.length
 n == dungeon[i].length
 1 <= m, n <= 200
 -1000 <= dungeon[i][j] <= 1000
 
 link: https://leetcode.com/problems/dungeon-game/
 explanation: https://www.youtube.com/watch?v=LbC0ejgACkE
 primary idea:
 - Classic DP Bottom up Approach.
 - For each cell, determine the min health with which knight should enter. At the end, the first cell remains with min health with which knight should enter.
 Time Complexity: O(m*n)
 Space Complexity: O(2n)
 */
class DungeonGame {
    func calculateMinimumHP(_ dungeon: [[Int]]) -> Int {
        let m = dungeon.count, n = dungeon[0].count
        
        var memo = Array(repeating: 0, count: n)
        var col = n - 1
        while col >= 0 {
            if col == n - 1 {
                memo[col] = max(1 - dungeon[m - 1][col], 1)
            } else {
                memo[col] = max(memo[col + 1] - dungeon[m - 1][col], 1)
            }
            col -= 1
        }

        var row = m - 2
        while row >= 0 {
            var newRow = Array(repeating: 0, count: n)
            var col = n - 1
            while col >= 0 {
                let currentReward = dungeon[row][col]
                if col == n - 1 {
                    newRow[col] = max(memo[col] - currentReward, 1)
                } else {
                    newRow[col] = max(min(newRow[col + 1] - currentReward, memo[col] - currentReward), 1)
                }
                col -= 1
            }
            memo = newRow
            row -= 1
        }
        
        return memo[0]
    }
}

/*
 problem:
 Given an m x n binary matrix filled with 0's and 1's, find the largest square containing only 1's and return its area.

 Testcases:
 Input: matrix = [["1","0","1","0","0"],["1","0","1","1","1"],["1","1","1","1","1"],["1","0","0","1","0"]]
 Output: 4
 
 Input: matrix = [["0","1"],["1","0"]]
 Output: 1
 
 Input: matrix = [["0"]]
 Output: 0
 
 Constraints:
 m == matrix.length
 n == matrix[i].length
 1 <= m, n <= 300
 matrix[i][j] is '0' or '1'.
 
 link: https://leetcode.com/problems/maximal-square/
 explanation: https://www.youtube.com/watch?v=6X7Ha2PrDmM&list=PLot-Xpze53lcvx_tjrr_m2lgD2NsRHlNO&index=15
 primary idea:
 - If cell value is 1, then add it with min of corresponding cell to get result of sub problem
 - Maintain track of max val while traversing
 Time Complexity: O(m * n)
 Space Complexity: O(2n)
 */
class MaximalSquare {
    func callAsFunction(_ matrix: [[Character]]) -> Int {
        let m = matrix.count, n = matrix[0].count
        var maxValue = 0
        var memo = Array(repeating: 0, count: n)
                
        for row in 0..<m {
            var newRow = Array(repeating: 0, count: n)
            for col in 0..<n {
                if col == 0 || row == 0 {
                    newRow[col] = matrix[row][col].wholeNumberValue!
                } else {
                    if matrix[row][col] == "1" {
                        newRow[col] = 1 + min(memo[col], memo[col - 1], newRow[col - 1])
                    }
                }
                maxValue = max(maxValue, newRow[col])
            }
            memo = newRow
        }
        return maxValue * maxValue
    }
}


/*
 problem:
 You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.
 Return the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.
 You may assume that you have an infinite number of each kind of coin.
 
 Testcases:
 Input: coins = [1,2,5], amount = 11
 Output: 3
 Explanation: 11 = 5 + 5 + 1
 
 Input: coins = [2], amount = 3
 Output: -1
 
 Input: coins = [1], amount = 0
 Output: 0
 
 Input: coins = [1], amount = 1
 Output: 1
 
 Input: coins = [1], amount = 2
 Output: 2
 
 Constraints:
 1 <= coins.length <= 12
 1 <= coins[i] <= 231 - 1
 0 <= amount <= 104
 
 link: https://leetcode.com/problems/coin-change/
 explanation: https://www.youtube.com/watch?v=J2eoCvk59Rc&t=1067s
 primary idea:
 - Evaluate only if a coin is less than amount, if not however memo already has above row values
 - Subproblems should be from that specific coin to target, no point in solving for subproblem target less than coin
 - Current sub problem result is a min of min number of coins possible when current coin is excluded and included
 Time Complexity: O(n^2)
 Space Complexity: O(n)
 */
class MinCoinChange {
    func callAsFunction(_ coins: [Int], _ amount: Int) -> Int {
        if amount < 0 {
            return amount
        }
        
        var memo = Array(repeating: Int.max, count: amount + 1)
        //Min of coins need to sum up to zero is 0
        memo[0] = 0
        
        for coin in coins where coin <= amount {
            for target in coin..<amount+1 where memo[target - coin] < Int.max {
                memo[target] = min(memo[target], 1 + memo[target - coin])
            }
        }
        
        return memo[amount] == Int.max ? -1 : memo[amount]
    }
}

/*
 problem:
 Given an integer n, return the least number of perfect square numbers that sum to n.

 A perfect square is an integer that is the square of an integer; in other words, it is the product of some integer with itself. For example, 1, 4, 9, and 16 are perfect squares while 3 and 11 are not.
 
 Testcases:
 Input: n = 12
 Output: 3
 Explanation: 12 = 4 + 4 + 4.
 
 Input: n = 13
 Output: 2
 Explanation: 13 = 4 + 9.
 
 Constraints:
 1 <= n <= 104
 
 link: https://leetcode.com/problems/perfect-squares/
 primary idea:
 - Mostly identical problem to Coin change. The square root of a num will alwyas be in range 1...(n/2 + 1)
 Time Complexity: O(n/2 + n^2)
 Space Complexity: O(n)
 */
class PerfectSquares {
    func numSquares(_ n: Int) -> Int {
        var squares = [Int]()
        for num in 0..<n/2+2 {
            let val = num * num
            if val > n {
                break
            }
            squares.append(val)
        }
        
        var memo = Array(repeating: Int.max, count: n+1)
        //Min of squares need to sum up to zero is 0
        memo[0] = 0
        
        for square in squares where square <= n {
            for target in square..<n+1 where memo[target - square] < Int.max {
                memo[target] = min(memo[target], 1 + memo[target - square])
            }
        }
        return memo[n] == Int.max ? -1 : memo[n]
    }
}

/*
 problem:
 You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.
 Return the number of combinations that make up that amount. If that amount of money cannot be made up by any combination of the coins, return 0.
 You may assume that you have an infinite number of each kind of coin.
 The answer is guaranteed to fit into a signed 32-bit integer.
 
 Testcases:
 Input: amount = 5, coins = [1,2,5]
 Output: 4
 
 Input: amount = 3, coins = [2]
 Output: 0
 
 Input: amount = 10, coins = [10]
 Output: 1
 
 Constraints:
 1 <= coins.length <= 300
 1 <= coins[i] <= 5000
 All the values of coins are unique.
 0 <= amount <= 5000
 
 link: https://leetcode.com/problems/coin-change-2/
 primary idea:
 - Evaluate only if a coin is less than amount, if not however memo already has above row values
 - Subproblems should be from that specific coin to target, no point in solving for subproblem target less than coin
 - Current sub problem result is a addition of min number of ways when current coin is excluded and included
 - The num of ways does contains duplicate combinations like 1+2+1 == 1+1+2 == 4, either of one is considered. This is where Combination Sum IV and this problem differentiates
 Time Complexity: O(coins*amount)
 Space Complexity: O(amount)
 */
class CoinChange2 {
    func change(_ amount: Int, _ coins: [Int]) -> Int {
        if amount < 0{
            return amount
        }
        
        var memo = Array(repeating: 0, count: amount+1)
        memo[0] = 1
        
        for coin in coins where coin <= amount {
            for target in coin..<amount+1 where memo[target - coin] > 0 {
                memo[target] += memo[target - coin]
            }
        }
        return memo[amount]
    }
}

/*
 problem:
 Given an array of distinct integers nums and a target integer target, return the number of possible combinations that add up to target.
 The answer is guaranteed to fit in a 32-bit integer.
 
 Testcases:
 Input: nums = [1,2,3], target = 4
 Output: 7
 
 Input: nums = [9], target = 3
 Output: 0
 
 Constraints:
 1 <= nums.length <= 200
 1 <= nums[i] <= 1000
 All the elements of nums are unique.
 1 <= target <= 1000
 
 link: https://leetcode.com/problems/combination-sum-iv/
 primary idea:
 - DFS with Memoization, dfs function returns number of combinations(including duplicates) possible.
 Time Complexity:
 Space Complexity:
 */
class CombinationSum4 {
    func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
        var cache = [Int: Int]()
        
        func dfs(_ target: Int) -> Int {
            if let val = cache[target] {
                return val
            }
            if target == 0 {
                return 1
            }
            
            var res = 0
            for num in nums {
                if num > target {
                    continue
                }
                res += dfs(target - num)
            }
            cache[target] = res
            return res
        }
        return dfs(target)
    }
}

/*
 problem:
 There are a row of n houses, each house can be painted with one of the three colors: red, blue or green. The cost of painting each house with a certain color is different. You have to paint all the houses such that no two adjacent houses have the same color, and you need to cost the least. Return the minimum cost.

 The cost of painting each house with a certain color is represented by a n x 3 cost matrix. For example, costs[0][0] is the cost of painting house 0 with color red; costs[1][2] is the cost of painting house 1 with color green, and so on... Find the minimum cost to paint all houses.
 
 Testcases:
 Input: [[14,2,11],[11,14,5],[14,3,10]]
 Output: 10
 
 Input: [[1,2,3],[1,4,6]]
 Output: 3
  
 link: https://www.lintcode.com/problem/515/
 explanation: https://www.youtube.com/watch?v=-w67-4tnH5U&t=442s
 primary idea:
 - Classic DP Memoization Approach
 Time Complexity: O(m*n)
 Space Complexity: O(n)
 */
struct PaintHouse {
    func callAsFunction(_ costs: [[Int]]) -> Int {
        var memo = (0,0,0)
        for house in 0..<costs.count {
            memo = (
                costs[house][0] + min(memo.1, memo.2),
                costs[house][1] + min(memo.0, memo.2),
                costs[house][2] + min(memo.0, memo.1)
            )
        }
        return min(memo.0, memo.1, memo.2)
    }
}

/*
 problem:
 There are a row of n houses, each house can be painted with one of the k colors. The cost of painting each house with a certain color is different. You have to paint all the houses such that no two adjacent houses have the same color.

 The cost of painting each house with a certain color is represented by a n x k cost matrix. For example, costs[0][0] is the cost of painting house 0 with color 0; costs[1][2] is the cost of painting house 1 with color 2, and so on... Find the minimum cost to paint all houses.
 
 Challenge: Could you solve it in O(nk)
 
 Testcases:
 costs = [[14,2,11],[11,14,5],[14,3,10]]
 Output: 10
 
 costs = [[5]]
 Output: 5
  
 link: https://www.lintcode.com/problem/516/
 primary idea:
 - Keep track of three things like prev color, prev Min and prev second min and traverse through data and store intermediate results
 Time Complexity: O(n*k)
 Space Complexity: O(1)
 */
struct PaintHouseII {
    func callAsFunction(_ costs: [[Int]]) -> Int {
        var prevColor = -1, prevMin = 0, prevSecMin = 0
        
        for house in 0..<costs.count {
            var currentColor = -1, currentMin = Int.max, currentSecMin = Int.max
            
            for color in 0..<costs[house].count {
                let sum = costs[house][color] + (prevColor != color ? prevMin : prevSecMin)
                if sum < currentMin {
                    currentSecMin = currentMin
                    currentMin = sum
                    currentColor = color
                } else if sum < currentSecMin {
                    currentSecMin = sum
                }
            }
            prevColor = currentColor
            prevMin = currentMin
            prevSecMin = currentSecMin
        }
        return prevMin
    }
}

/*
 problem:
 Given two strings text1 and text2, return the length of their longest common subsequence. If there is no common subsequence, return 0.

 A subsequence of a string is a new string generated from the original string with some characters (can be none) deleted without changing the relative order of the remaining characters.

 For example, "ace" is a subsequence of "abcde".
 A common subsequence of two strings is a subsequence that is common to both strings.
 
 Testcases:
 Input: text1 = "abcde", text2 = "ace"
 Output: 3
 Explanation: The longest common subsequence is "ace" and its length is 3.
 
 Input: text1 = "abc", text2 = "abc"
 Output: 3
 Explanation: The longest common subsequence is "abc" and its length is 3.
 
 Input: text1 = "abc", text2 = "def"
 Output: 0
 Explanation: There is no such common subsequence, so the result is 0.
 
 Constraints:
 1 <= text1.length, text2.length <= 1000
 text1 and text2 consist of only lowercase English characters.
 
 link: https://leetcode.com/problems/longest-common-subsequence/
 explanation: https://www.youtube.com/watch?v=Ua0GhsJSlWM&t=363s
 primary idea:
 - Top Down Approach + Memoization
 - if characters at i and j match, then the result will be 1 + LCS of rest of characters ( + one step in negative diagonal)
    adb
    acb, here b at index 2 match then result will be 1 + LCS of ad and ac.
 - if characters at i and j does not match, then the result of max of removing i or j characters
    adb
    ade, here b and e at index 2 does not match, then result will be max of [removing b from adb and ade] or [adb and removing e character from ade]
    adb OR ad
    ad     ade
    value = max([row -1, col], [row][col - 1])
 Time Complexity: O(m * n) where m is length of longerText and n is length of shorter text
 Space Complexity: O(m * n) where m is length of longerText and n is length of shorter text
 */
class LCS {
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
       var longerText = Array(text1), shorterText = Array(text2)
        if shorterText.count > longerText.count {
            (longerText, shorterText) = (shorterText, longerText)
        }
        
        var prev = Array(repeating: 0, count: shorterText.count+1)
        for row in 1..<longerText.count+1 {
            var current = Array(repeating: 0, count: shorterText.count+1)
            
            for col in 1..<shorterText.count+1 {
                if shorterText[col - 1] == longerText[row - 1] {
                    current[col] = 1 + prev[col - 1]
                } else {
                    current[col] = max(current[col - 1], prev[col])
                }
            }
            
            prev = current
        }
        return prev.last!
    }
}

/*
 problem:
 Given two strings word1 and word2, return the minimum number of operations required to convert word1 to word2.

 You have the following three operations permitted on a word:

 Insert a character
 Delete a character
 Replace a character
 
 Testcases:
 Input: word1 = "horse", word2 = "ros"
 Output: 3
 
 Input: word1 = "intention", word2 = "execution"
 Output: 5
 
 Constraints:
 0 <= word1.length, word2.length <= 500
 word1 and word2 consist of lowercase English letters.
 
 link: https://leetcode.com/problems/edit-distance/
 explanation: https://www.youtube.com/watch?v=EgI5nU9etnU
 primary idea:
 - Iterative Bottom Up approach with Tabulation
 - Tabulation row characters are from word1 and col characters are from word2
 - If character at row and col both match, then no additional operation need. we just need to check for min operations for rest of characters
    abd
    acd, a and a  match. no additional operation needed. we just need to know the min operations excluding a leaving ab, ac
 - if character at row and col does not match, we brute force through all 3 operations like replace, insert and delete which will lead us to min operations
 Time Complexity:  O(m * n)
 Space Complexity: O(2n)
 */
class EditDistance {
    func minDistance(_ word1: String, _ word2: String) -> Int {
        let m = word1.count + 1, n = word2.count + 1
        let word1 = Array(word1), word2 = Array(word2)
        var memo = Array(repeating: -1, count: n)
        
        var col = n - 1
        while col >= 0 {
            memo[col] = n - 1 - col
            col -= 1
        }
        
        var row = m - 2
        while row >= 0 {
            
            var newRow = Array(repeating: -1, count: n)
            var col = n - 1
            while col >= 0 {
                if col == (n-1) {
                    newRow[col] = m - 1 - row
                } else {
                    if word1[row] == word2[col] {
                        newRow[col] = memo[col + 1]
                    } else {
                        // 1 + min(operationWhenInserted, operationWhenDeleted, operationWhenReplaced)
                        newRow[col] = 1 + min(newRow[col + 1], memo[col], memo[col + 1])
                    }
                }
                col -= 1
            }
            memo = newRow
            
            row -= 1
        }
        return memo[0]
    }
}

/*
 problem:
 Given an input string (s) and a pattern (p), implement wildcard pattern matching with support for '?' and '*' where:

 '?' Matches any single character.
 '*' Matches any sequence of characters (including the empty sequence).
 The matching should cover the entire input string (not partial).
 
 Testcases:
 Input: s = "aa", p = "a"
 Output: false
 Explanation: "a" does not match the entire string "aa".
 
 Input: s = "aa", p = "*"
 Output: true
 Explanation: '*' matches any sequence.
 
 Input: s = "cb", p = "?a"
 Output: false
 Explanation: '?' matches 'c', but the second letter is 'a', which does not match 'b'.
 
 Input: s = "adceb", p = "*a*b"
 Output: true
 Explanation: The first '*' matches the empty sequence, while the second '*' matches the substring "dce".
 
 Input: s = "acdcb", p = "a*c?b"
 Output: false
 
 Constraints:
 0 <= s.length, p.length <= 2000
 s contains only lowercase English letters.
 p contains only lowercase English letters, '?' or '*'
 
 link: https://leetcode.com/problems/wildcard-matching/
 explanation: https://www.youtube.com/watch?v=7SHV_QfVROE
 primary idea:
 - Iterative with memoization
 - DP first row and first column mean empty string and empty pattern respectively (Base case)
 - if row and col values match then check one step negative diagonal. It means current values are matched, check rest string and pattern and update result
 - if col value is a *, then check for below two cases. Any one of them should be true
    - Empty occurence case (DP[row][col - 1]). we need to check one value before for empty occurence case. OR
    - One or more occurence case. Check with result from DP[row - 1][col]
 Time Complexity:  O(n + n*m)
 Space Complexity:  O(2n)
 */
class WildcardMatching {
    func isMatch(_ s: String, _ p: String) -> Bool {
        let s = Array(s)
        var p = Array(p)
        if p.count > 1 {
            var res = [Character]()
            for i in 0..<p.count {
                if i == 0 && p[i] == "*" {
                    continue
                }
                if i > 0 && p[i] == "*" && p[i - 1] == "*" {
                    continue
                }
                res.append(p[i])
            }
            p = res
        }
        let m = s.count + 1, n = p.count + 1
        var memo = Array(repeating: false, count: n)
        memo[0] = true
        
        for col in 1..<n {
            memo[col] = p[col - 1] == "*" ? memo[col - 1] : false
        }
        
        for row in 1..<m {
            var newRow = Array(repeating: false, count: n)
            for col in 0..<n {
                if col == 0 {
                    newRow[col] = false
                } else {
                    if s[row - 1] == p[col - 1] || p[col - 1] == "?" {
                        newRow[col] = memo[col - 1]
                    } else if p[col - 1] == "*" {
                        newRow[col] = newRow[col - 1] || memo[col]
                    } else {
                        newRow[col] = false
                    }
                }
            }
            memo = newRow
        }
        return memo[n - 1]
    }
}

/*
 problem:
 Given an input string s and a pattern p, implement regular expression matching with support for '.' and '*' where:

 '.' Matches any single character.
 '*' Matches zero or more of the preceding element.
 The matching should cover the entire input string (not partial).
 
 Testcases:
 Input: s = "aa", p = "a"
 Output: false
 Explanation: "a" does not match the entire string "aa".
 
 Input: s = "aa", p = "a*"
 Output: true
 Explanation: '*' means zero or more of the preceding element, 'a'. Therefore, by repeating 'a' once, it becomes "aa".
 
 Input: s = "ab", p = ".*"
 Output: true
 Explanation: ".*" means "zero or more (*) of any character (.)".
 
 Input: s = "aab", p = "c*a*b"
 Output: true
 Explanation: c can be repeated 0 times, a can be repeated 1 time. Therefore, it matches "aab".
 
 Input: s = "mississippi", p = "mis*is*p*."
 Output: false
 
 Constraints:
 1 <= s.length <= 20
 1 <= p.length <= 30
 s contains only lowercase English letters.
 p contains only lowercase English letters, '.', and '*'.
 It is guaranteed for each appearance of the character '*', there will be a previous valid character to match.
 
 link: https://leetcode.com/problems/regular-expression-matching/
 explanation: https://www.youtube.com/watch?v=l3hda49XcDE
 primary idea:
 - Iterative with memoization
 - DP first row and first column mean empty string and empty pattern respectively (Base case)
 - if row and col values match then check one step negative diagonal. It means current values are matched, check rest string and pattern and update result
 - if col value is a *, then check for below two cases. Any one of them should be true
    - No occurence case (DP[row][col - 2]). we need to check 2 values before for no occurence case. OR
    - One or more occurence case. Check the pattern character before * and current row character match, if yes, then update with result from DP[row - 1][col]
 - Other than above 2 cases, it's always failed to match.
 Time Complexity: O(n + n*m)
 Space Complexity: O(2n)
 */
class RegularExpressionMatching {
    func isMatch(_ s: String, _ p: String) -> Bool {
        let s = Array(s), m = s.count + 1, n = p.count + 1
        var p = Array(p)
        if p.count > 1 {
            var res = [Character]()
            for i in 0..<p.count {
                if i == 0 && p[i] == "*" {
                    continue
                }
                if i > 0 && p[i] == "*" && p[i - 1] == "*" {
                    continue
                }
                res.append(p[i])
            }
            p = res
        }
        
        var memo = Array(repeating: false, count: n)
        memo[0] = true
        for col in 1..<n {
            memo[col] = p[col - 1] == "*" ? memo[col - 2] : false
        }
        
        for row in 1..<m {
            var newRow = Array(repeating: false, count: n)
            for col in 0..<n {
                if col == 0 {
                    newRow[col] = false
                } else {
                    if s[row - 1] == p[col - 1] || p[col - 1] == "." {
                        newRow[col] = memo[col - 1]
                    } else if p[col - 1] == "*" {
                        if newRow[col - 2]  {
                            newRow[col] = true
                        } else if s[row - 1] == p[col - 2] || p[col - 2] == "." {
                            newRow[col] = memo[col]
                        } else {
                            newRow[col] = false
                        }
                    } else {
                        newRow[col] = false
                    }
                }
            }
            memo = newRow
        }
        
        return memo[n - 1]
    }
}


class DistinctSubsequences {
    //Time&Space: O(n*m) where n is length of s and m is length of t
    func numDistinct(_ s: String, _ t: String) -> Int {
        var cache = [[Int]: Int]()
        func dfs(i: Int, j: Int) -> Int {
            if j == t.count {
                return 1
            }
            if i == s.count {
                return 0
            }
            if let cacheVal = cache[[i, j]] {
                return cacheVal
            }
            if s[i] == t[j] {
                cache[[i, j]] = dfs(i: i+1, j: j+1) + dfs(i: i+1, j: j)
            } else {
                cache[[i, j]] = dfs(i: i+1, j: j)
            }
            return cache[[i,j]] ?? 0
        }
        return dfs(i: 0, j: 0)
    }
}

/*
 problem:
 You are playing the following Flip Game with your friend: Given a string that contains only these two characters: + and -, you and your friend take turns to flip two consecutive "++" into "--". The game ends when a person can no longer make a move and therefore the other person will be the winner.

 Write a function to determine if the starting player can guarantee a win.
 
 Testcases:
 Input:  s = "++++"
 Output: true
 Explanation:
 The starting player can guarantee a win by flipping the middle "++" to become "+--+".
 
 Input: s = "+++++"
 Output: false
 Explanation:
 The starting player can not win
 "+++--" --> "+----"
 "++--+" --> "----+"
  
 link: https://www.lintcode.com/problem/913/
 explanation: https://www.youtube.com/watch?v=EgI5nU9etnU
 primary idea:
 - DFS with Memoization
 Time Complexity:
 Space Complexity:
 */
class FlipGameII {
    func canWin(_ s: String) -> Bool {
        if s.count < 2 {
            return false
        }
        var winMap = [[Character]: Bool]()
        
        func helper(_ sChars: [Character]) -> Bool {
            if let result = winMap[sChars] {
                return result
            }
            for i in 0..<sChars.count-1 where sChars[i] == "+" && sChars[i+1] == "+" {
                if !helper(sChars[0..<i] + ["-","-"] + sChars[i+2..<s.count]) {
                    winMap[sChars] = true
                    return true
                }
            }
            winMap[sChars] = false
            return false
        }
        
        return helper(Array(s))
    }
}

class GenerateParentheses {
    /*
     Approach: DFS
     TimeComplexity: O(2^n) where n is height of tree
     SpaceComplexity: O(n)
     */
    func generateParenthesis(_ n: Int) -> [String] {
        //If openCount < n, we can add open
        // If closeCount < openCount, we can add close
        //If openCount == closeCount == n, then return result
        var combinations = [String](), combination = [Character]()
        func dfs(_ openN: Int, _ closeN: Int) {
            if openN == n && closeN == n {
                combinations.append(String(combination))
                return
            }
            
            if openN < n {
                combination.append("(")
                dfs(openN+1, closeN)
                combination.removeLast()
            }
            
            if closeN < openN {
                combination.append(")")
                dfs(openN, closeN+1)
                combination.removeLast()
            }
        }
        dfs(0, 0)
        return combinations
    }
    
    func generateParenthesisOptimized(_ n: Int) -> [String] {
        //If openCount < n, we can add open
        // If closeCount < openCount, we can add close
        //If openCount == closeCount == n, then return result
        var combinations = [String]()
        func dfs(_ openN: Int, _ closeN: Int, _ combination: String) {
            if openN == n && closeN == n {
                combinations.append(combination)
                return
            }
            
            if openN < n {
                dfs(openN+1, closeN, combination + "(")
            }
            
            if closeN < openN {
                dfs(openN, closeN+1, combination + ")")
            }
        }
        dfs(0, 0, "")
        return combinations
    }
}

class BestTimeToBuyAndSellStock {
    func maxProfit(_ prices: [Int]) -> Int {
        var buy = 0, profit = 0
        for sell in 1..<prices.count {
            if prices[sell] < prices[buy] {
                buy = sell
            }
            let currentProfit = prices[sell] - prices[buy]
            if profit < currentProfit {
                profit = currentProfit
            }
        }
        return profit
    }
    
    func maxProfitMultipleTransactions(_ prices: [Int]) -> Int {
        var profit = 0
        for i in 1..<prices.count {
            if prices[i] > prices[i - 1] {
                profit += prices[i] - prices[i-1]
            }
        }
        return profit
    }
}
struct BestTimeToBuyAndSellStockIII {
    /*
     Approach: Bi directional Dynamic Programming
     TimeComplexity: O(3n)
     SpaceComplexity: O(2n)
     Explanation: https://www.youtube.com/watch?v=2E0-_LtUPiE&t=121s
     */
    func maxProfitWithAtMostTwoTransactions(_ prices: [Int]) -> Int {
        
        var left = Array(repeating: -1, count: prices.count)
        left[0] = 0
        var minLeft = prices[0]
        for i in 1..<prices.count {
            let currentPrice = prices[i]
            if currentPrice < minLeft {
                minLeft = currentPrice
                left[i] = left[i-1]
            } else {
                left[i] = max(left[i - 1], currentPrice - minLeft)
            }
        }
        
        var right = Array(repeating: -1, count: prices.count)
        right[prices.count-1] = 0
        var maxRight = prices.last!, i = prices.count-2
        while i >= 0 {
            let currentPrice = prices[i]
            if currentPrice > maxRight {
                maxRight = currentPrice
                right[i] = right[i+1]
            } else {
                right[i] = max(right[i+1], maxRight - currentPrice)
            }
            i -= 1
        }
        
        var maxProfit = 0
        for i in 0..<prices.count {
            let currentTotalprofit = left[i] + right[i]
            if currentTotalprofit > maxProfit {
                maxProfit = currentTotalprofit
            }
        }
        return maxProfit
    }
    
    /*
     Approach: Bi directional Dynamic Programming
     TimeComplexity: O(n)
     SpaceComplexity: O(1)
     Explanation: https://www.youtube.com/watch?v=YAWRyWJalM0, https://www.youtube.com/watch?v=2E0-_LtUPiE&t=121s
     */
    func maxProfitWith2TransactionsOptimized(_ prices: [Int]) -> Int {
        var t1Cost = Int.max, t1Profit = 0
        var t2Cost = Int.max, t2Profit = 0
        
        for currentPrice in prices {
            t1Cost = min(t1Cost, currentPrice)
            t1Profit = max(t1Profit, currentPrice - t1Cost)
            t2Cost = min(t2Cost, currentPrice - t1Profit)
            t2Profit = max(t2Profit, currentPrice - t2Cost)
        }
        
        return t2Profit
    }
}
class BestTimeToBuyAndSellStockIV {
    func maxProfit(_ k: Int, _ prices: [Int]) -> Int {
        //invalid number of transactions
        if k <= 0 || prices.isEmpty {
            return 0
        }
        if k >= prices.count/2 {
            // If k is half or more of prices count, we may assume any number of transactions
            var profit = 0
            for i in 0..<prices.count - 1 where prices[i] < prices[i+1] {
                profit += prices[i+1] - prices[i]
            }
            return profit
        } else {
            // when k is less than half count
            var tCosts = Array(repeating: prices[0], count: k)
            var tProfits = Array(repeating: 0, count: k)
            
            for currentPrice in prices {
                for i in 0..<k {
                    let currentTCost = tCosts[i]
                    tCosts[i] = min(currentTCost, i == 0 ? currentPrice : currentPrice - tProfits[i - 1])
                    tProfits[i] = max(tProfits[i], currentPrice - tCosts[i])
                }
            }
            return tProfits[k - 1]
        }
    }
}
class BestTimeToBuyAndSellStockWithCoolDownTime {
    /*
     Approach: DP
     TimeComplexity: O(n)
     SpaceComplexity: O(1)
     Explanation: https://www.youtube.com/watch?v=UlWFaWv8wWU
     */
    func maxProfit(_ prices: [Int]) -> Int {
        var sold = Int.min, held = Int.min, reset = 0
        for price in prices {
            (sold, held, reset) = (held + price, max(held, reset - price), max(reset, sold))
        }
        return max(sold, reset)
    }
}

struct PalindromeSubstrings {
    /*
     Explanation:
     Time Complexity: O(n^2)
     Space Complexity: O(1)
     */
    func countSubstringsDp(_ s: String) -> Int {
        let n = s.count
        var result = 0, s = Array(s)
        
        func isPalindrome(start: Int, end: Int) -> Int {
            var count = 0, start = start, end = end
            while start >= 0 && end < s.count && s[start] == s[end] {
                count += 1
                start -= 1
                end += 1
            }
            return count
        }
        
        for i in 0..<n {
            result += isPalindrome(start: i, end: i)
            result += isPalindrome(start: i, end: i+1)
        }
        return result
    }
}
/*
 link: https://leetcode.com/problems/course-schedule/
 */
class LongestPalindromicSubstring {
    /*
     explanation: https://www.youtube.com/watch?v=EgI5nU9etnU
     primary idea:
     - start and end variable represent results start and end index
     - loop through each index and find out the max length of odd and even palindromes and update the newly found max palindrome's start and end index
     - "end - start - 1" == the loop in expand func will break only after overflowing, we need to execute this to remove those overflowing indexes
     Time Complexity: O(n^2)
     Space Complexity: O(n)
     */
    func longestPalindrome(_ s: String) -> String {
        var start = 0, end = 0, s = Array(s)
        
        func expand(start: Int, end: Int) -> Int {
            var start = start, end = end
            while start >= 0 && end < s.count && s[start] == s[end] {
                start -= 1
                end += 1
            }
            return end - start - 1
        }
        
        for i in 0..<s.count {
            //odd palindrome
            let oddLen = expand(start: i, end: i)
            //even palindrome
            let evenLen = expand(start: i, end: i+1)
            
            let len = max(oddLen, evenLen)
            
            if len > (end - start) {
                start = i - (len - 1)/2
                end = i + len/2
            }
        }
        
        return String(s[start..<end+1])
    }
}
fileprivate extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
    
    subscript(range: Range<Int>) -> String {
        String(self[index(startIndex, offsetBy: range.startIndex)..<index(startIndex, offsetBy: range.endIndex)])
    }
}

class MaxSubArray {
    func callAsFunction(_ nums: [Int]) -> Int {
        var maximumSub = nums[0], current = 0
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

class MaxAlternatingSum {
    func callAsFunction(_ nums: [Int]) -> Int {
        var res = nums[0]
        for i in 0..<nums.count - 1 {
            res += max(nums[i] - nums[i + 1], res)
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
 A frog is crossing a river. The river is divided into some number of units, and at each unit, there may or may not exist a stone. The frog can jump on a stone, but it must not jump into the water.

 Given a list of stones' positions (in units) in sorted ascending order, determine if the frog can cross the river by landing on the last stone. Initially, the frog is on the first stone and assumes the first jump must be 1 unit.

 If the frog's last jump was k units, its next jump must be either k - 1, k, or k + 1 units. The frog can only jump in the forward direction.
 
 Testcases:
 Input: stones = [0,1,3,5,6,8,12,17]
 Output: true
 Explanation: The frog can jump to the last stone by jumping 1 unit to the 2nd stone, then 2 units to the 3rd stone, then 2 units to the 4th stone, then 3 units to the 6th stone, 4 units to the 7th stone, and 5 units to the 8th stone.
 
 Input: stones = [0,1,2,3,4,8,9,11]
 Output: false
 Explanation: There is no way to jump to the last stone as the gap between the 5th and 6th stone is too large.
 
 Constraints:
 2 <= stones.length <= 2000
 0 <= stones[i] <= 231 - 1
 stones[0] == 0
 stones is sorted in a strictly increasing order.
 
 link: https://leetcode.com/problems/frog-jump/
 primary idea:
 - Recursive Backtrack with memoization
 Time Complexity:
 Space Complexity:
 */
class FrogJump {
    func canCross(_ stones: [Int]) -> Bool {
        var cache = [String: Bool]()
        let lastStep = stones[stones.count - 1], set = Set(stones)
        
        func canCross(k: Int, jump: Int) -> Bool {
            let key = "\(k) | \(jump)"
            if let val = cache[key] {
                return val
            }
            if k == 0 {
                return false
            }
            let currentJump = k + jump
            if !set.contains(currentJump) {
                return false
            }
            if currentJump > lastStep {
                return false
            }
            if currentJump == lastStep {
                return true
            }
            
            let res = canCross(k: k, jump: currentJump) ||
                    canCross(k: k - 1, jump: currentJump) ||
                    canCross(k: k + 1, jump: currentJump)
            cache[key] = res
            return res
        }
        
        return canCross(k: 1, jump: 0)
     }
}
