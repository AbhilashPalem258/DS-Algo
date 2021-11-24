//
//  DPLeetcode.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 31/07/21.
//

import XCTest
@testable import LeetcodePractice

class DPLeetcodeTests: XCTestCase {
    func testFibonacciNumbers() {
        let obj = FibonacciNumbers()
        XCTAssertEqual(obj(4), 3)
        XCTAssertEqual(obj(3), 2)
        XCTAssertEqual(obj(2), 1)
    }
    
    func testClimbStairs() {
        let obj = ClimbStairs()
        XCTAssertEqual(obj(2), 2)
        XCTAssertEqual(obj(3), 3)
    }
    
    func testMinCostClimbingStairs() {
        let obj = MinCostClimbStairs()
        XCTAssertEqual(obj.greedy([10,15,20]), 15)
        XCTAssertEqual(obj.greedy([1,100,1,1,1,100,1,1,100,1]), 6)
        
        XCTAssertEqual(obj.dp([10,15,20]), 15)
        XCTAssertEqual(obj.dp([1,100,1,1,1,100,1,1,100,1]), 6)
    }
    
    func testHouseRobbery() {
        let obj = HouseRobbery()
        XCTAssertEqual(obj([1,2,3,1]), 4)
        XCTAssertEqual(obj([2,7,9,3,1]), 12)
    }
    
    func testPaintFence() {
        let obj = PaintFence()
        XCTAssertEqual(obj.numWays(3, 2), 6)
        XCTAssertEqual(obj.numWays(2, 2), 4)
    }
    
    func testUniquePathsII() {
        let obj = UniquePathsII()
        XCTAssertEqual(obj.uniquePathsWithObstaclesOnlyDFS([[0,0,0],[0,1,0],[0,0,0]]), 2)
        XCTAssertEqual(obj.uniquePathsWithObstaclesOnlyDFS([[0,1],[0,0]]), 1)
        XCTAssertEqual(obj.uniquePathsWithObstaclesOnlyDFS([[0,0]]), 1)
        
        XCTAssertEqual(obj.uniquePathsWithObstaclesDFSWithMemoization([[0,0,0],[0,1,0],[0,0,0]]), 2)
        XCTAssertEqual(obj.uniquePathsWithObstaclesDFSWithMemoization([[0,1],[0,0]]), 1)
        XCTAssertEqual(obj.uniquePathsWithObstaclesDFSWithMemoization([[0,0]]), 1)
        
        XCTAssertEqual(obj.uniquePathsWithObstaclesIterativeWithMemo([[0,0,0],[0,1,0],[0,0,0]]), 2)
        XCTAssertEqual(obj.uniquePathsWithObstaclesIterativeWithMemo([[0,1],[0,0]]), 1)
        XCTAssertEqual(obj.uniquePathsWithObstaclesIterativeWithMemoII([[0,0]]), 1)
        
        XCTAssertEqual(obj.uniquePathsWithObstaclesIterativeWithMemoII([[0,0,0],[0,1,0],[0,0,0]]), 2)
        XCTAssertEqual(obj.uniquePathsWithObstaclesIterativeWithMemoII([[0,1],[0,0]]), 1)
        XCTAssertEqual(obj.uniquePathsWithObstaclesIterativeWithMemoII([[0,0]]), 1)
        XCTAssertEqual(obj.uniquePathsWithObstaclesIterativeWithMemoII([[0,1,0,0,0],[1,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]), 0)
        
    }
    
    func testUniquePaths() {
        let obj = UniquePaths()
        XCTAssertEqual(obj.uniquePaths(3, 7), 28)
        XCTAssertEqual(obj.uniquePaths(3, 2), 3)
    }
    
    func testDungeonGame() {
        let obj = DungeonGame()
        XCTAssertEqual(obj.calculateMinimumHP([[-2,-3,3],[-5,-10,1],[10,30,-5]]), 7)
        XCTAssertEqual(obj.calculateMinimumHP([[0]]), 1)
    }
    
    func testMinCoinChange() {
        let obj = MinCoinChange()
        XCTAssertEqual(obj([1,2,5], 11), 3)
        XCTAssertEqual(obj([2], 3), -1)
        XCTAssertEqual(obj([1], 0), 0)
    }
    
    func testPerfectSquares() {
        let obj = PerfectSquares()
        XCTAssertEqual(obj.numSquares(12), 3)
    }
    
    func testCoinChange2() {
        let obj = CoinChange2()
        XCTAssertEqual(obj.change(5, [1,2,5]), 4)
        XCTAssertEqual(obj.change(3, [2]), 0)
        XCTAssertEqual(obj.change(10, [10]), 1)
    }
    
    func testFlipGameII() {
        let obj = FlipGameII()
        XCTAssertEqual(obj.canWin("++++"), true)
        XCTAssertEqual(obj.canWin("+++++"), false)
    }
    
    func testDecodeWays() {
        let obj = DecodeWays()
        XCTAssertEqual(obj.numDecodings("06"), 0)
        XCTAssertEqual(obj.numDecodings("0"), 0)
        XCTAssertEqual(obj.numDecodings("12"), 2)
        XCTAssertEqual(obj.numDecodings("226"), 3)
        
        XCTAssertEqual(obj.numDecodingsLinearWithConstantSpace("06"), 0)
        XCTAssertEqual(obj.numDecodingsLinearWithConstantSpace("0"), 0)
        XCTAssertEqual(obj.numDecodingsLinearWithConstantSpace("12"), 2)
        XCTAssertEqual(obj.numDecodingsLinearWithConstantSpace("226"), 3)
    }
    
    func testWordBreak() {
        let obj = WordBreak()
        XCTAssertEqual(obj.wordBreak("leetcode", ["leet","code"]), true)
        XCTAssertEqual(obj.wordBreak("catsanddog", ["cat","cats","and","sand","dog"]), true)
    }
    
    func testWordBreakII() {
        let obj = WordBreakII()
        XCTAssertEqual(obj.wordBreak("catsanddog", ["cat","cats","and","sand","dog"]), ["cat sand dog", "cats and dog"])
        XCTAssertEqual(obj.wordBreak("pineapplepenapple", ["apple","pen","applepen","pine","pineapple"]), ["pine apple pen apple", "pine applepen apple", "pineapple pen apple"])
        XCTAssertEqual(obj.wordBreak("catsandog", ["cats","dog","sand","and","cat"]), [])
    }
    
    func testPascalTriangle() {
        let obj = PascalTriangle()
        XCTAssertEqual(obj.generate(5), [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]])
        XCTAssertEqual(obj.generate(1), [[1]])
    }
    
    func testMinPathSum() {
        let obj = MinPathSum()
        XCTAssertEqual(obj.minPathSumTopBottomWithMemo([[1,3,1],[1,5,1],[4,2,1]]), 7)
        XCTAssertEqual(obj.minPathSumTopBottomWithMemo([[1,2,3],[4,5,6]]), 12)
    }
    
    func testGenerateParentheses() {
        let obj = GenerateParentheses()
        XCTAssertEqual(obj.generateParenthesis(3), ["((()))","(()())","(())()","()(())","()()()"])
        XCTAssertEqual(obj.generateParenthesis(1), ["()"])
        
        XCTAssertEqual(obj.generateParenthesisOptimized(3), ["((()))","(()())","(())()","()(())","()()()"])
        XCTAssertEqual(obj.generateParenthesisOptimized(1), ["()"])
    }
    
    func testSubsetSum() {
        let obj = SubsetSum()
        XCTAssertEqual(obj([2,3,5,7,10], target: 14), true)
    }
    
    func testTargetSum() {
        let obj = TargetSum()
//        XCTAssertEqual(obj([1,1,1,1,1], 3), 5)
    }
    
    func testPartitionEqualSubsetSum() {
        let obj = PartitionEqualSubsetSum()
        XCTAssertEqual(obj.canPartition([1,5,11,5]), true)
        XCTAssertEqual(obj.canPartition([1,2,3,5]), false)
    }
    
    func testBestTimeToBuyAndSellStock() {
        let obj = BestTimeToBuyAndSellStock()
        XCTAssertEqual(obj.maxProfit([7,1,5,3,6,4]), 5)
        XCTAssertEqual(obj.maxProfit([7,6,4,3,1]), 0)
//
//        XCTAssertEqual(obj.maxProfitMultipleTransactions([7,1,5,3,6,4]), 7)
//        XCTAssertEqual(obj.maxProfitMultipleTransactions([1,2,3,4,5]), 4)
    }
    
    func testBestTimeToBuyAndSellStockIII() {
        let obj = BestTimeToBuyAndSellStockIII()
//        XCTAssertEqual(obj.maxProfitWithAtMostTwoTransactions([3,3,5,0,0,3,1,4]), 6)
//        XCTAssertEqual(obj.maxProfitWithAtMostTwoTransactions([1,2,3,4,5]), 4)
//
        XCTAssertEqual(obj.maxProfitWith2TransactionsOptimized([3,3,5,0,0,3,1,4]), 6)
//        XCTAssertEqual(obj.maxProfitWith2TransactionsOptimized([1,2,3,4,5]), 4)
    }
    
    func testBestTimeToBuyAndSellStockIV() {
        let obj = BestTimeToBuyAndSellStockIV()
        XCTAssertEqual(obj.maxProfit(2, [5, 11, 3, 50, 60, 90]), 93)
        XCTAssertEqual(obj.maxProfit(2, []), 0)
    }
    
    func testBestTimeToBuyAndSellStockWithCoolDownTime() {
        let obj = BestTimeToBuyAndSellStockWithCoolDownTime()
        XCTAssertEqual(obj.maxProfit([1,2,3,0,2]), 3)
        XCTAssertEqual(obj.maxProfit([1]), 0)
    }
    
    func testPaintHouse() {
        let obj = PaintHouse()
        XCTAssertEqual(obj([[14,2,11],[11,14,5],[14,3,10]]), 10)
        XCTAssertEqual(obj([[1,2,3],[1,4,6]]), 3)
    }
    
    func testPaintHouseII() {
        let obj = PaintHouseII()
        XCTAssertEqual(obj([[14,2,11],[11,14,5],[14,3,10]]), 10)
        XCTAssertEqual(obj([[5]]), 5)
    }
    
    func testLongestIncreasingSubsequence() {
        let obj = LongestIncreasingSubsequence()
        XCTAssertEqual(obj.dfsWithMemo([2,5,3,7,101,18]), 4)
        
        XCTAssertEqual(obj.dp([2,5,3,7,101,18]), 4)
        XCTAssertEqual(obj.dp([0,1,0,3,2,3]), 4)
        XCTAssertEqual(obj.dp([7,7,7,7,7,7,7]), 1)
    }
    
    func testLISOptimized() {
        let obj = LISOptimized()
        XCTAssertEqual(obj.lengthOfLIS([2,5,3,7,101,18]), 4)
    }
    
    func testPalindromeSubstrings() {
        let obj = PalindromeSubstrings()        
        XCTAssertEqual(obj.countSubstringsDp("abcbbc"), 9)
    }
    
    func testLongestPalindromicSubstring() {
        let obj = LongestPalindromicSubstring()
        XCTAssertEqual(obj.longestPalindrome("babad"), "aba")
        XCTAssertEqual(obj.longestPalindrome("cbbd"), "bb")
        XCTAssertEqual(obj.longestPalindrome("a"), "a")
        XCTAssertEqual(obj.longestPalindrome("ac"), "c")
    }
    
    func testLCS() {
        let obj = LCS()
        XCTAssertEqual(obj.longestCommonSubsequence("abcde", "ace"), 3)
        XCTAssertEqual(obj.longestCommonSubsequence("abc", "abc"), 3)
        XCTAssertEqual(obj.longestCommonSubsequence("abc", "def"), 0)
    }
    
    func testDistinctSubsequences() {
        let obj = DistinctSubsequences()
        XCTAssertEqual(obj.numDistinct("rabbbit", "rabbit"), 3)
        XCTAssertEqual(obj.numDistinct("babgbag", "bag"), 5)
    }
    
    func testMaxSubArray() {
        let obj = MaxSubArray()
        XCTAssertEqual(obj([-2,1,-3,4,-1,2,1,-5,4]), 6)
        XCTAssertEqual(obj([5,4,-1,7,8]), 23)
        XCTAssertEqual(obj([1]), 1)
    }
    
    func testEditDistance() {
        let obj = EditDistance()
        XCTAssertEqual(obj.minDistance("horse", "ros"), 3)
        XCTAssertEqual(obj.minDistance("intention", "execution"), 5)
        XCTAssertEqual(obj.minDistance("abd", "acd"), 1)
    }
    
    func testWildcardMatching() {
        let obj = WildcardMatching()
        XCTAssertEqual(obj.isMatch("aa", "a"), false)
        XCTAssertEqual(obj.isMatch("aa", "*"), true)
        XCTAssertEqual(obj.isMatch("cb", "?a"), false)
        XCTAssertEqual(obj.isMatch("aab", "c*a*b"), false)
    }
    
    func testRegularExpressionMatching() {
        let obj = RegularExpressionMatching()
//        XCTAssertEqual(obj.isMatch("aa", "a"), false)
//        XCTAssertEqual(obj.isMatch("aa", "a*"), true)
//        XCTAssertEqual(obj.isMatch("ab", ".*"), true)
//        XCTAssertEqual(obj.isMatch("aab", "c*a*b"), true)
        XCTAssertEqual(obj.isMatch("mississippi", "mis*is*p*."), false)
    }
    
    func testMaximalSquare() {
        let obj = MaximalSquare()
        XCTAssertEqual(obj([["1","0","1","0","0"],["1","0","1","1","1"],["1","1","1","1","1"],["1","0","0","1","0"]]), 4)
        XCTAssertEqual(obj([["0","1"],["1","0"]]), 1)
        XCTAssertEqual(obj([["0"]]), 0)
    }
    
    func testCombinationSum4() {
        let obj = CombinationSum4()
        XCTAssertEqual(obj.combinationSum4([1,2,3], 4), 7)
        XCTAssertEqual(obj.combinationSum4([9], 3), 0)
        XCTAssertEqual(obj.combinationSum4([3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], 10), 9)
    }
    
    func testJumpGame() {
        let obj = JumpGame()
        XCTAssertEqual(obj.dfsWithMemo([2,3,1,1,4]), true)
        XCTAssertEqual(obj.dfsWithMemo([3,2,1,0,4]), false)
        
        XCTAssertEqual(obj.greedy([2,3,1,1,4]), true)
        XCTAssertEqual(obj.greedy([3,2,1,0,4]), false)
    }
    
    func testJumpII() {
        let obj = JumpII()
        XCTAssertEqual(obj.bfs([2,3,1,1,4]), 2)
    }
    
    func testFrogJump() {
        let obj = FrogJump()
        XCTAssertEqual(obj.canCross([0,1,3,5,6,8,12,17]), true)
        XCTAssertEqual(obj.canCross([0,1,2,3,4,8,9,11]), false)
    }
}
