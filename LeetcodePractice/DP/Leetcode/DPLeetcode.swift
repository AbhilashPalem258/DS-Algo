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

class UniquePaths {
    /*
     Approach: Iterative + Memoization (Top Bottom Iterative Approach)
     TimeComplexity: O(r*c)
     SpaceComplexity: O(r)
     */
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

class MinPathSum {
    /*
     Approach: Iterative + Memoization (Top Bottom Iterative Approach)
     TimeComplexity: O(m*n)
     SpaceComplexity: O(n)
     */
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
                    newRow[col] = min(newRow[col-1] + grid[row][col], memoRow[col] + grid[row][col])
                }
            }
            memoRow = newRow
        }
        return memoRow[n-1]
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
 link: https://leetcode.com/problems/edit-distance/
 explanation: https://www.youtube.com/watch?v=XYi2-LPrwm4&list=PLot-Xpze53lcvx_tjrr_m2lgD2NsRHlNO&index=24
 primary idea:
 - create Adj list, map from course to its prerequisite courses
 - perform classic DFS on Adj list
 - once we get to know that specific course is completable, mark it's adj list value as empty which helps reduce redundant operations #44
 - Given prerequites may contain un connected graphs, better to loops through evey course so that we don miss any course #67
 Time Complexity: O(m * n)
 Space Complexity: O(2n)
 */
class EditDistance {
    func minDistance(_ word1: String, _ word2: String) -> Int {
        let m = word1.count + 1, n = word2.count + 1
        let word1 = Array(word1), word2 = Array(word2)
        var memo = Array(0..<n)
        for i in 1..<m {
            var newArr = Array(repeating: -1, count: n)
            for j in 0..<n {
                if j == 0 {
                    newArr[j] = i
                    continue
                }
                if word1[i - 1] == word2[j - 1] {
                    newArr[j] = memo[j - 1]
                } else {
                    newArr[j] = 1 + min(newArr[j - 1], memo[j], memo[j - 1])
                }
            }
            memo = newArr
        }
        return memo[n - 1]
    }
}


class WildcardMatching {
    func isMatch(_ s: String, _ p: String) -> Bool {
        let s = Array(s)
        var p = Array(p)
        if p.count > 1 {
            var res = [Character]()
            for i in 0..<p.count {
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

/*
 link: https://leetcode.com/problems/combination-sum-iv/
 primary idea:
 - DFS with memoization
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
 link: https://leetcode.com/problems/course-schedule/
 explanation: https://www.youtube.com/watch?v=EgI5nU9etnU
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
 link: https://leetcode.com/problems/jump-game-ii/
 explanation: https://www.youtube.com/watch?v=dJ7sWiOoK7g&list=PLot-Xpze53lcvx_tjrr_m2lgD2NsRHlNO&index=20
 primary idea:
 - BFS, with l and r pointers
 - Keep track of BFS levels
 Time Complexity:
 Space Complexity:
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
