//
//  DFSLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 19/07/21.
//

import Foundation
import AppKit

class NumberOfIslands {
    func depthFirst(_ grid: [[Character]]) -> Int {
        let m = grid.count, n = grid[0].count
        var numOfIslands = 0, grid = grid
        
        func dfs(_ row: Int, _ col: Int) {
            if !(0..<m).contains(row) || !(0..<n).contains(col) || grid[row][col] != "1" {
                return
            }
            grid[row][col] = "0"
            dfs(row-1, col)
            dfs(row+1, col)
            dfs(row, col+1)
            dfs(row, col-1)
        }
        
        for row in 0..<m {
            for col in 0..<n where grid[row][col] == "1" {
                numOfIslands += 1
                dfs(row, col)
            }
        }
        return numOfIslands
    }
}

class Permutation {
    func permute(_ nums: [Int]) -> [[Int]] {
        var permutations = [[Int]]()
        let count = nums.count
        
        func calculatePermutations(_ newNums: [Int],_ start: Int) {
            if start == newNums.count {
                permutations.append(newNums)
            }
            
            var mutableNums = newNums
            for i in start..<count {
                (mutableNums[start], mutableNums[i]) = (mutableNums[i], mutableNums[start])
                calculatePermutations(mutableNums, start+1)
                (mutableNums[start], mutableNums[i]) = (mutableNums[i], mutableNums[start])
            }
        }
        
        calculatePermutations(nums, 0)
        return permutations
    }
}

class PermutationII {
    func permute(_ nums: [Int]) -> [[Int]] {
        var permutations = [[Int]]()
        let count = nums.count
        
        func calculatePermutations(_ newNums: [Int],_ start: Int) {
            if start == newNums.count {
                permutations.append(newNums)
            }
            
            var set = Set<Int>()
            
            var mutableNums = newNums
            for i in start..<count where !set.contains(mutableNums[i]) {
                set.insert(mutableNums[i])
                (mutableNums[start], mutableNums[i]) = (mutableNums[i], mutableNums[start])
                calculatePermutations(mutableNums, start+1)
                (mutableNums[start], mutableNums[i]) = (mutableNums[i], mutableNums[start])
            }
        }
        
        calculatePermutations(nums, 0)
        return permutations
    }
}

struct WordSearch {
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        let m = board.count, n = board[0].count, wordCount = word.count
        let wordChars = Array(word)
        var visited = Set<[Int]>()
    
        let wordSet = Set(word)
        let boardSet = Set(board.reduce([], +))
        
        if wordSet.subtracting(boardSet).count > 0 { return false }
        
        func callDFS(row: Int, col: Int, i: Int) -> Bool {
            if i == wordCount {
                return true
            }
            if !(0..<m).contains(row) || !(0..<n).contains(col) || visited.contains([row, col]) || board[row][col] != wordChars[i] {
                return false
            }
            visited.insert([row, col])
            let res = callDFS(row: row-1, col: col, i: i + 1) ||
                    callDFS(row: row+1, col: col, i:  i + 1) ||
                    callDFS(row: row, col: col-1, i:  i + 1) ||
                    callDFS(row: row, col: col+1, i:  i + 1)
            visited.remove([row, col])
            return res
        }
        
        for row in 0..<m {
            for col in 0..<n {
                if callDFS(row: row, col: col, i: 0) {
                    return true
                }
            }
        }
        
        return false
    }
}

class WordSearchII {
    class TrieNode {
        var children: [Character: TrieNode] = [:]
        var isWord: Bool = false
        
        init() {}
        
        func addWord(_ word: String) {
            var cur = self
            for char in word {
                if cur.children[char] == nil {
                    cur.children[char] = TrieNode()
                }
                cur = cur.children[char]!
            }
            cur.isWord = true
        }
    }
    
    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        let m = board.count, n = board[0].count
        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        
        let trie = TrieNode()
        for word in words {
            trie.addWord(word)
        }
        
        var res = Set<String>(), visited = Set<Coordinate>()
        
        func dfs(coord: Coordinate, node: TrieNode, word: String) {
            if coord.row < 0 || coord.row == m || coord.col < 0 || coord.col == n || visited.contains(coord) || node.children[ board[coord.row][coord.col]] == nil {
                return
            }
            
            visited.insert(coord)
            let word = word + "\(board[coord.row][coord.col])"
            let node = node.children[board[coord.row][coord.col]]!
            if node.isWord {
                res.insert(word)
            }
            for direction in directions {
                let nRow = coord.row + direction.0
                let nCol = coord.col + direction.1
                
                dfs(coord: Coordinate(row: nRow, col: nCol), node: node, word: word)
            }
            visited.remove(coord)
        }
        
        for row in 0..<m {
            for col in 0..<n where trie.children[board[row][col]] != nil  {
                dfs(coord: Coordinate(row: row, col: col), node: trie, word: "")
            }
        }
        return Array(res)
    }
    
    struct Coordinate: Hashable {
        let row: Int
        let col: Int
    }
}


struct Subsets {
    
    //TimeComplexity: O(n * lengthOfSubset(2^n)) where n is length of nums and in the worst case the length of each subset can be 2^n
    // for each element in nums, we have 2 choices, either to include it in subset or not include it. for an array of [1,2,3], the number of sets is 2 * 2 * 2 = 2^n
    //Neetcode
    func subsets(_ nums: [Int]) -> [[Int]] {
        var result: [[Int]] = []
        
        func dfs(index: Int, subset: [Int]) {
            if index == nums.count {
                result.append(subset)
                return
            }
            
            let nextIndex = index + 1
            dfs(index: nextIndex, subset: subset + [nums[index]])
            dfs(index: nextIndex, subset: subset)
        }
        
        dfs(index: 0, subset: [])
        return result
    }
    
    //TimeComplexity: O(n * lengthOfSubset(2^n)) where n is length of nums and in the worst case the length of each subset can be 2^n
    //First element of mutiple ocuurence of number will be included and when not including we go forward with next duplicate number, so in not including when avoid duplicate number.
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
       let nums = nums.sorted()
       var result = [[Int]]()
        
        func dfs(index: Int, subset: [Int]) {
            if index >= nums.count {
                result.append(subset)
                return
            }
            
            dfs(index: index + 1, subset: subset + [nums[index]])

            var nextIndex = index + 1
            while nextIndex < nums.count && nums[index] == nums[nextIndex] {
                nextIndex += 1
            }
            
            dfs(index: nextIndex, subset: subset)
        }
        dfs(index: 0, subset: [])
        return result
   }
}

class Combinations {
    func callAsFunction(_ n: Int, _ k: Int) -> [[Int]] {
        var result = [[Int]](), path = [Int]()
        let nums = Array(1...n)
        
        func dfs(i: Int) {
            if path.count == k {
                result.append(path)
                return
            }
            
            for index in i..<nums.count {
                path.append(nums[index])
                dfs(i: index+1)
                path.removeLast()
            }
        }
        
        dfs(i: 0)
        return result
    }
}

class CombinationSum {
    func callAsFunction(_ candidates: [Int], _ target: Int) -> [[Int]] {
        let candidates = candidates.sorted()
        var combinations = [[Int]](), combination = [Int]()
        
        func dfs(_ start: Int, target: Int) {
            if target == 0 {
                combinations.append(combination)
                return
            }
            
            for i in start..<candidates.count {
                let current = candidates[i]
                if current > target {
                    break
                }
                combination.append(current)
                dfs(i, target: target - current)
                combination.removeLast()
            }
        }
        
        dfs(0, target: target)
        return combinations
    }
}

class CombinationSumII {
    func callAsFunction(_ candidates: [Int], _ target: Int) -> [[Int]] {
        let candidates = candidates.sorted()
        var combinations = [[Int]](), combination = [Int]()
        
        func dfs(_ start: Int, target: Int) {
            if target == 0 {
                combinations.append(combination)
                return
            }
            
            for i in start..<candidates.count {
                
                let current = candidates[i]
                if current > target {
                    break
                }
                
                if i > 0 && candidates[i] == candidates[i - 1] && i != start {
                    continue
                }
                
                combination.append(current)
                dfs(i+1, target: target - current)
                combination.removeLast()
            }
        }
        
        dfs(0, target: target)
        return combinations
    }
}

class CombinationSumIII {
    func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
        var combinations = [[Int]](), combination = [Int]()
        let nums = Array(1...9)
        
        func dfs(_ start: Int, target: Int) {
            if target == 0 && combination.count == k {
                combinations.append(combination)
                return
            }
            
            if combination.count > k {
                return
            }
            
            for i in start..<nums.count {
                let current = nums[i]
                if current > target {
                    break
                }
                combination.append(current)
                dfs(i+1, target: target - current)
                combination.removeLast()
            }
        }
        
        dfs(0, target: n)
        
        return combinations
    }
}

class LetterCombinationsPhoneNumber {
    func callAsFunction(_ digits: String) -> [String] {
        
        if digits.isEmpty {
            return []
        }
        
        var combinations = [String](), combination = ""
        let arr = digits.compactMap { $0.wholeNumberValue }
        let map = [
            2: "abc",
            3: "def",
            4: "ghi",
            5: "jkl",
            6: "mno",
            7: "pqrs",
            8: "tuv",
            9: "wxyz"
        ]
        
        func dfs(_ index: Int) {
            if combination.count == digits.count {
                combinations.append(combination)
                return
            }
            
            let num = arr[index]
            let str = map[num]
            
            for char in str ?? "" {
                combination.append(char)
                dfs(index+1)
                combination.removeLast()
            }
        }
        
        dfs(0)
        return combinations
    }
}

//https://leetcode.com/problems/find-unique-binary-string/
class FindDiffBinaryStr {
    func callAsFunction(_ nums: [String]) -> String {
        let n = nums[0].count
        let existing = Set(nums)
        
        func dfs(path: String) -> String? {
            if path.count == n {
                if !existing.contains(path) {
                    return path
                }
                return nil
            }
            
            for bNum in ["0", "1"] {
                let path = path + bNum
                if let res = dfs(path: path) {
                    return res
                }
            }
            return nil
        }
        
        let result = dfs(path: "")
        return result ?? ""
    }
}

class MaxLengthOfConcatenatedStrWithUniqChars {
    func callAsFunction(_ arr: [String]) -> Int {
        var charSet = Set<Character>()
        
        func isoverlaping(str: String) -> Bool {
            var counter = [Character: Int]()
            for char in charSet {
                counter[char, default: 0] += 1
            }
            for char in str {
                counter[char, default: 0] += 1
                if counter[char]! > 1 {
                    return true
                }
            }
            return false
        }
        
        func dfs(_ i: Int) -> Int {
            if i == arr.count {
                return charSet.count
            }
            
            var res = 0
            if !isoverlaping(str: arr[i]) {
                for char in arr[i] {
                    charSet.insert(char)
                }
                res = dfs(i + 1)
                for char in arr[i] {
                    charSet.remove(char)
                }
            }
            return max(res, dfs(i + 1)) // dont concante current str
        }
        return dfs(0)
    }
}

class SplitStrIntoDescendingConsecutiveVals {
    func callAsFunction(_ s: String) -> Bool {
        let sComponents = Array(s)
        
        func dfs(_ i: Int, prev: Int) -> Bool {
            if i == s.count && prev != Int(s) {
                return true
            }
            
            for j in i..<s.count {
                if let nextNum = Int(String(sComponents[i..<j+1])), nextNum + 1 == prev {
                    if dfs(j+1, prev: nextNum) {
                        return true
                    }
                }
            }
            return false
        }
        
        for i in 0..<s.count {
            if let num = Int(String(sComponents[0..<i+1])), dfs(i+1, prev: num) {
                return true
            }
        }
        
        return false
    }
}
//O(4^n)
class MatchsticksToSquare {
    func callAsFunction(_ matchsticks: [Int]) -> Bool {
        let sum = matchsticks.reduce(0, +)
        let sideLength = sum/4
        if Double(sideLength) != Double(sum)/4.0 {
            return false
        }
        let matchsticks = matchsticks.sorted(by: >)
        var square = [Int](repeating: 0, count: 4)
        
        func dfs(_ i: Int) -> Bool {
            if i == matchsticks.count {
                return true
            }
            
            let matchstick = matchsticks[i]
            for side in 0..<4 {
                if square[side] + matchstick <= sideLength {
                    square[side] += matchstick
                    if dfs(i + 1) {
                        return true
                    }
                    square[side] -= matchstick
                }
            }
            return false
        }
        
        return dfs(0)
    }
}

class RestoreIPAddress {
    func callAsFunction(_ s: String) -> [String] {
        if s.count < 4 && s.count > 12 {
            return []
        }
        var res = [String]()
        let sComponents = Array(s)
        
        func dfs(_ i: Int, path: [Int]) {
            if path.count == 4 && i != s.count {
                return
            }
            if i == s.count && path.count == 4 {
                var ipAddress = ""
                for i in 0..<path.count {
                    ipAddress += "\(path[i])"
                    if i != (path.count - 1) {
                        ipAddress += "."
                    }
                }
                res.append(ipAddress)
                return
            }
            
            for j in i..<i+3 where j < s.count {
                if j != i && sComponents[i] == Character("0") {
                    break
                }
                if let currentDigit = Int(String(sComponents[i..<j+1])), (0..<256).contains(currentDigit) {
                    let path = path + [currentDigit]
                    dfs(j+1, path: path)
                }
            }
        }
        
        dfs(0, path: [])
        return res
    }
}
/*
 Numbers can be regarded as product of its factors. For example,

 8 = 2 x 2 x 2;
   = 2 x 4.
 Write a function that takes an integer n and return all possible combinations of its factors.

 Note:

 Each combination's factors must be sorted ascending, for example: The factors of 2 and 6 is [2, 6], not [6, 2].
 You may assume that n is always positive.
 Factors should be greater than 1 and less than n.
 Examples:

 input: 1
 output:
 []
 input: 37
 output:
 []
 input: 12
 output:
 [
   [2, 6],
   [2, 2, 3],
   [3, 4]
 ]
 input: 32
 output:
 [
   [2, 16],
   [2, 2, 8],
   [2, 2, 2, 4],
   [2, 2, 2, 2, 2],
   [2, 4, 4],
   [4, 8]
 ]
 */
class FactorCombinations {
    func getFactors(_ n: Int) -> [[Int]] {
        var factors = [[Int]]()
        
        func dfs(_ start: Int, target: Int, path: [Int]) {
            if target == 1 {
                if path.count > 1 {
                    factors.append(path)
                }
                return
            }
            
            if start > target {
                return
            }
            
            for factor in start...target {
                if factor > target {
                    break
                }
                if target % factor == 0 {
                    dfs(factor, target: target/factor, path: path + [factor])
                }
            }
        }
        
        dfs(2, target: n, path: [])
        return factors
    }
}
/*
 A strobogrammatic number is a number that looks the same when rotated 180 degrees (looked at upside down).

 Find all strobogrammatic numbers that are of length = n.

 For example, Given n = 2, return ["11","69","88","96"].
 */
class StrobogrammaticNumberII {
    func callAsFunction(_ n: Int) -> [String] {
        let mirrorDigits = [0: 0, 1: 1, 6: 9, 8: 8, 9: 6]
        var combinations = [String](), combination = Array(repeating: "", count: n)
        
        func dfs(_ left: Int, _ right: Int) {
            if left > right {
                combinations.append(combination.joined())
                return
            }
            
            for (key, val) in mirrorDigits {
                
                if left == right && [6,9].contains(key) {
                    continue
                }
                
                if left != right && left == 0 && key == 0 {
                    continue
                }
                
                combination[left] = String(key)
                combination[right] = String(val)
                
                dfs(left+1, right-1)
            }
        }
        dfs(0, n-1)
        return combinations
    }
}

/*
 Write a function to generate the generalized abbreviations of a word.
 Example:
 Given word = "word", return the following list (order does not matter):
 ["word", "1ord", "w1rd", "wo1d", "wor1", "2rd", "w2d", "wo2", "1o1d", "1or1", "w1r1", "1o2"
 */
class GeneralizedAbbreviation {
    func generateAbbreviations(_ word: String) -> [String] {
        var result = [String]()
        let chars = Array(word).map {String($0)}
        
        func dfs(start: Int, subset: String) {
            if start == word.count {
                result.append(subset)
                return
            }
            
            result.append(subset + String(chars.count - start))
            
            for i in start..<chars.count {
                let offset = i - start
                print("start: \(start), i: \(i), offset: \(offset), subset: \(subset), chars[i]: \(chars[i])")
                if offset != 0 {
                    dfs(start: i + 1, subset: subset + String(offset) + chars[i])
                } else {
                    dfs(start: i + 1, subset: subset + chars[i])
                }
            }
        }
        
        dfs(start: 0, subset: "")
        return result
    }
}


class PalindromePartioning {
    func callAsFunction(_ s: String) -> [[String]] {
        var result = [[String]](), path = [String]()
        let count = s.count
        let sChars = Array(s)
        
        func isPalindrome(_ s: String) -> Bool {
            let pChars = Array(s)
            var i = 0, j = pChars.count - 1
            
            while i <= j {
                if pChars[i] != pChars[j] {
                    return false
                }
                i += 1
                j -= 1
            }
            return true
        }

        func dfs(_ start: Int) {
            if start == count {
                result.append(path)
                return
            }

            for i in start..<s.count {
                let current = String(sChars[start...i])

                if isPalindrome(current) {
                    path.append(current)
                    dfs(i+1)
                    path.removeLast()
                }
            }
        }
        dfs(0)
        return result
    }
}

class IsGraphBipartite {
    /*
     1 -> Blue
     0 -> Red
     */
    func callAsFunction(_ graph: [[Int]]) -> Bool {
        var colorArr = [Int](repeating: -1, count: graph.count)
        
        func isValidColor(index: Int, color: Int) -> Bool {
            if colorArr[index] != -1 {
                return colorArr[index] == color
            }
            
            colorArr[index] = color
            for neighbour in graph[index] {
                if !isValidColor(index: neighbour, color: 1 - color) {
                    return false
                }
            }
            return true
        }
        //loop through all vertices as we are not sure if graph is connected
        for i in 0..<graph.count {
            if colorArr[i] == -1 && !isValidColor(index: i, color: 1) {
                return false
            }
        }
        return true
    }
}

class PossibleBipartition {
    func callAsFunction(_ n: Int, _ dislikes: [[Int]]) -> Bool {
        var adjList = [Int: [Int]]()
        for dislike in dislikes {
            adjList[dislike[0] - 1, default: []].append(dislike[1] - 1)
            adjList[dislike[1] - 1, default: []].append(dislike[0] - 1)
        }
        
        var colorArr = [Int](repeating: -1, count: n)
        
        func isValidColor(index: Int, color: Int) -> Bool {
            if colorArr[index] != -1 {
                return colorArr[index] == color
            }
            
            colorArr[index] = color
            for neighbour in adjList[index] ?? [] {
                if !isValidColor(index: neighbour, color: 1 - color) {
                    return false
                }
            }
            return true
        }
        
        for i in 0..<n {
            if colorArr[i] == -1 && !isValidColor(index: i, color: 1) {
                return false
            }
        }
        return true
    }
}

class WallsGates {
    func callAsFunction(_ rooms: inout [[Int]]) {
        let m = rooms.count, n = rooms[0].count
        
        func dfs(row: Int, col: Int, distance: Int) {
            if !(0..<m).contains(row) || !(0..<n).contains(col) || rooms[row][col] == -1 {
                return
            }
            if distance == 0 || distance < rooms[row][col] {
                rooms[row][col] = distance
                dfs(row: row-1, col: col, distance: distance+1)
                dfs(row: row+1, col: col, distance: distance+1)
                dfs(row: row, col: col-1, distance: distance+1)
                dfs(row: row, col: col+1, distance: distance+1)
            }
            
        }
        
        for row in 0..<m {
            for col in 0..<n where rooms[row][col] == 0 {
                dfs(row: row, col: col, distance: 0)
            }
        }
    }
}

//class Solution {
//    func canPartitionKSubsets(_ nums: [Int], _ k: Int) -> Bool {
//
//    }
//}

class NQueens {
    func callAsFunction(_ n: Int) -> [[String]] {
        var result = [[String]]()
        var board = [[String]](repeating: [String](repeating: ".", count: n), count: n)
        var colSet = Set<Int>(), posDiagSet = Set<Int>(), negDiagSet = Set<Int>()
        
        func backtrack(row: Int) {
            if row == n {
                result.append( board.map{ $0.joined() })
                return
            }
            
            for col in 0..<n {
                if colSet.contains(col) || posDiagSet.contains(row + col) || negDiagSet.contains(row - col) {
                    continue
                }
                
                board[row][col] = "Q"
                colSet.insert(col)
                posDiagSet.insert(row + col)
                negDiagSet.insert(row - col)
                
                backtrack(row: row + 1)
                
                board[row][col] = "."
                colSet.remove(col)
                posDiagSet.remove(row + col)
                negDiagSet.remove(row - col)
                
            }
        }
        
        backtrack(row: 0)
        return result
    }
}

class NQueensII {
    func callAsFunction(_ n: Int) -> Int {
        var result = 0
        var board = [[String]](repeating: [String](repeating: ".", count: n), count: n)
        var colSet = Set<Int>(), posDiagSet = Set<Int>(), negDiagSet = Set<Int>()
        
        func backtrack(row: Int) {
            if row == n {
                result += 1
                return
            }
            
            for col in 0..<n {
                if colSet.contains(col) || posDiagSet.contains(row + col) || negDiagSet.contains(row - col) {
                    continue
                }
                
                board[row][col] = "Q"
                colSet.insert(col)
                posDiagSet.insert(row + col)
                negDiagSet.insert(row - col)
                
                backtrack(row: row + 1)
                
                board[row][col] = "."
                colSet.remove(col)
                posDiagSet.remove(row + col)
                negDiagSet.remove(row - col)
                
            }
        }
        
        backtrack(row: 0)
        return result
    }
}

class SudokuSolver {
    func callAsFunction(_ board: inout [[Character]]) {
        if board.count != 9 || board.first?.count != 9 {
            return 
        }
        
        var emptyElements = [(Int, Int)]()
        
        func isValidValue(row: Int, col: Int, num: Character) -> Bool {
            // check row
            for tCol in 0..<9 {
                if board[row][tCol] == num {
                    return false
                }
            }
            
            // check col
            for tRow in 0..<9 {
                if board[tRow][col] == num {
                    return false
                }
            }
            
            // check square
            let boxStartRow = (row / 3) * 3, boxStartCol = (col / 3) * 3
            for row in boxStartRow..<boxStartRow + 3 {
                for col in boxStartCol..<boxStartCol + 3 {
                    if board[row][col] == num {
                        return false
                    }
                }
            }
            
            return true
        }
        
        func findEmptyElements() {
            for row in 0..<9 {
                for col in 0..<9 where board[row][col] == "." {
                    emptyElements.append((row, col))
                }
            }
        }
        
        @discardableResult
        func dfs(_ i: Int) -> Bool {
            if i == emptyElements.count {
                return true
            }
            let (row, col) = emptyElements[i]
            for num in 1...9 {
                let char = Character("\(num)")
                if isValidValue(row: row, col: col, num: char) {
                    board[row][col] = char
                    if dfs(i+1) {
                       return true
                    }
                   board[row][col] = "."
                }
            }
            return false
        }
        
        findEmptyElements()
        dfs(0)
    }
}

class RemoveInvalidParentheses {
    func removeInvalidParentheses(_ s: String) -> [String] {
        var paths = [String]()
        
        dfs(&paths, Array(s), 0, 0, ("(", ")"))
        
        return paths
    }
    
    fileprivate func dfs(_ paths: inout [String], _ s: [Character], _ lastValid: Int, _ lastRight: Int, _ parens: (Character, Character)) {
        var counter = 0, s = s
        
        for i in lastValid..<s.count {
            if s[i] == parens.0 {
                counter += 1
            }
            if s[i] == parens.1 {
                counter -= 1
            }
            
            if counter < 0 {
                for j in lastRight...i {
                    guard s[j] == parens.1 else {
                        continue
                    }
                    guard j == 0 || s[j] != s[j - 1] || j == lastRight else {
                        continue
                    }
                    
                    dfs(&paths, Array(s[0..<j] + s[j + 1..<s.count]), i, j, parens)
                }
                // jump over invalid ones
                return
            }
        }
        
        if parens.0 == "(" {
            dfs(&paths, s.reversed(), 0, 0, (")", "("))
        } else {
            paths.append(String(s.reversed()))
        }
    }
}

class ExpressionAddOperators {
    
    // the problem description is a bit vague, but we don't just
    // care about single digits, it's all possible numbers comprised
    // of those digits, this greatly increases the number of permutations
    // to O(n^2)
    func addOperators(_ num: String, _ target: Int) -> [String] {
        var results = [String](), nums = Array(num).map {Int(String($0))!}
        if num.isEmpty {
            return results
        }
        
        func dfs(offset: Int, path: String, mr: Int, prior: Int) {
            
            if offset == num.count {
                if mr == target {
                    results.append(path)
                }
                return
            }
            for i in offset..<nums.count {
                
                if i != offset && nums[offset] == 0 {
                    break
                }
                
                var val = 0
                for j in offset..<i+1 {
                    val *= 10
                    val += nums[j]
                }

                if offset == 0 {
                    dfs(offset: i+1, path: path + String(val), mr: mr + val, prior: val)
                } else {
                    dfs(offset: i+1, path: path + "+" + String(val), mr: mr + val, prior: val)
                    dfs(offset: i+1, path: path + "-" + String(val), mr: mr - val, prior: -val)
                    dfs(offset: i+1, path: path + "*" + String(val), mr: mr - prior + (prior * val), prior: prior * val)
                }
            }
        }
        dfs(offset: 0, path: "", mr: 0, prior: 0)
        return results
    }
}


struct ClimbingStairs {
    func callAsFunction(steps: Int, eligibleStep: Int) -> [[Int]] {
        var combinations = [[Int]](), combination = [Int]()
        let arr = Array(1...eligibleStep)
        
        func dfs(_ start: Int, target: Int) {
            if target == 0 {
                combinations.append(combination)
                return
            }
            for i in start..<arr.count {
                let current = arr[i]
                if current > target {
                    break
                }
                combination.append(current)
                dfs(start, target: target - current)
                combination.removeLast()
            }
        }
        dfs(0, target: steps)
        return combinations
    }
}

class CanPartitionKSubsets {
    func canPartitionKSubsets(_ nums: [Int], _ k: Int) -> Bool {
        let sum = nums.reduce(0, +)
        if sum % k != 0 {
            return false
        }
        let target = sum/k
        let index = nums.count - 1
        var groupToKArr = Array(repeating: 0, count: k), numbers = nums.sorted()
        
        if numbers[index] > target {
            return false
        }
        
        func dfs(index: Int) -> Bool {
            if index < 0 {
                return true
            }
            let currentNum = numbers[index]
            for i in 0..<groupToKArr.count {
                if groupToKArr[i] + currentNum <= target {
                    groupToKArr[i] += currentNum
                    if dfs(index: index-1) {
                        return true
                    }
                    groupToKArr[i] -= currentNum
                }
                
                if groupToKArr[i] == 0 {
                    break
                }
            }
            return false
        }
        return dfs(index: index)
    }
}

struct WordSquares {
    func callAsFunction(wordList: [String]) -> [[String]] {
        let count = wordList.first!.count
        var combinations = [[String]](),
            combination = [[Character]](
                repeating: [Character](repeating: Character("."),
                                       count: count),
                count: count
            ),
            visited = Set<String>()
        
        func dfs(start: Int, prefix: String) {
            if start == count {
                combinations.append(combination.map{String($0)})
                return
            }
            
            var prefixWords = [String]()
            for word in wordList {
                if !visited.contains(word) && word.hasPrefix(prefix) {
                    prefixWords.append(word)
                }
            }
            
            for i in 0..<prefixWords.count {
                let currentWord = prefixWords[i]
                let pChars = Array(currentWord)
                visited.insert(currentWord)
                for index in 0..<pChars.count {
                    combination[start][index] = pChars[index]
                    combination[index][start] = pChars[index]
                }
                var nextPrefix = ""
                if start+1 < count {
                    for i in 0..<start+1 {
                        nextPrefix.append(combination[start+1][i])
                    }
                }
                dfs(start: start+1, prefix: nextPrefix)
                visited.remove(prefixWords[i])
                for index in 0..<pChars.count {
                    combination[start][index] = Character(".")
                    combination[index][start] = Character(".")
                }
            }
        }
        dfs(start: 0, prefix: "")
        return combinations
    }
    
    func wordSquaresUsingMap(wordList: [String]) -> [[String]] {
        let count = wordList.first!.count
        var combinations = [[String]](),
            combination = [[Character]](
                repeating: [Character](repeating: Character("."),count: count),
                count: count
            ),
            map = [String: [String]]()
        
        func createPrefixMap() {
            for word in wordList {
                for i in 1...count {
                    map[String(word.prefix(i)), default: []].append(word)
                }
            }
        }
        
        createPrefixMap()
        
        func dfs(start: Int, prefix: String) {
            if start == count {
                combinations.append(combination.map{String($0)})
                return
            }
            
            let prefixWords = map[prefix] ?? wordList
            
            for currentWord in prefixWords {
                let pChars = Array(currentWord)
                for index in 0..<pChars.count {
                    combination[start][index] = pChars[index]
                    combination[index][start] = pChars[index]
                }
                var nextPrefix = ""
                if start+1 < count {
                    for i in 0..<start+1 {
                        nextPrefix.append(combination[start+1][i])
                    }
                }
                dfs(start: start+1, prefix: nextPrefix)
                for index in 0..<pChars.count {
                    combination[start][index] = Character(".")
                    combination[index][start] = Character(".")
                }
            }
        }
        dfs(start: 0, prefix: "")
        return combinations
    }
}

class WordPatternII {
    func wordPatternMatch(_ pattern: String, _ str: String) -> Bool {
        func dfs(_ pattern: String, _ str: String, _ patternToWord: [Character: String]) -> Bool {
            guard let patternFirstChar = pattern.first, str.count > 0 else {
                return str.isEmpty && pattern.isEmpty
            }
            let newPattern = String(pattern.suffix(pattern.count - 1))
            
            if let existingWord = patternToWord[patternFirstChar] {
                if str.hasPrefix(existingWord) {
                    return dfs(newPattern, String(str.suffix(str.count - existingWord.count)), patternToWord)
                } else {
                    return false
                }
            }
            
            for i in 0..<str.count {
                let word = String(str.prefix(i + 1))
                if patternToWord.values.contains(word) {
                    continue
                }
                
                var patternToWord = patternToWord
                patternToWord[patternFirstChar] = word
                if dfs(newPattern, String(str.suffix(str.count - word.count)), patternToWord) {
                    return true
                }
            }
            return false
        }
        return dfs(pattern, str, [:])
    }
}

/*
 link: https://leetcode.com/problems/count-sub-islands/
 explanation: https://www.youtube.com/watch?v=mLpW3qfbNJ8&list=PLot-Xpze53ldBT_7QA8NVot219jFNr_GI&index=17
 primary idea:
 - Second grid's island should be present in first grid
 - Traverse through second grid's island even if it doesnt meet conditions, as we want it to be visited
 - return true if both conditions meet and traversed through island
 Time Complexity: O(n * m)
 Space Complexity: O(n * m)
 */
class CountSubIslands {
    func callAsFunction(_ grid1: [[Int]], _ grid2: [[Int]]) -> Int {
        var result = 0
        if grid2.isEmpty || grid2.first!.isEmpty || grid1.count != grid2.count || grid1.first!.count != grid2.first!.count  {
            return result
        }
        let (m, n) = (grid2.count, grid2.first!.count)
        var visited = Set<[Int]>()
        
        func dfs(row: Int, col: Int) -> Bool {
            if !(0..<m).contains(row) || !(0..<n).contains(col) || grid2[row][col] == 0 || visited.contains([row, col]) {
                return true
            }
            visited.insert([row, col])
            var result = true
            if grid1[row][col] == 0 {
                result = false
            }
            
            let ranges = [(row+1, col), (row, col+1), (row - 1, col), (row, col - 1)]
            for range in ranges {
                result =  dfs(row: range.0, col: range.1) && result
            }
            return result
        }
        
        for row in 0..<m {
            for col in 0..<n where grid2[row][col] == 1 && !visited.contains([row, col]) && dfs(row: row, col: col) {
                result += 1
            }
        }
        return result
    }
}

class PacificAtlantic {
    func callAsFunction(_ heights: [[Int]]) -> [[Int]] {
        let m = heights.count, n = heights[0].count
        var pac = Set<[Int]>(), atl = Set<[Int]>()
        
        func dfs(row: Int, col: Int, isPacific: Bool, prevHeight: Int) {
            if !(0..<m).contains(row) || !(0..<n).contains(col) || heights[row][col] < prevHeight {
                return
            }
            if isPacific && pac.contains([row, col]) || !isPacific && atl.contains([row, col]) {
                return
            }
            _ = isPacific ? pac.insert([row, col]) : atl.insert([row, col])
            for range in [(row + 1, col), (row, col + 1), (row - 1, col), (row, col - 1)] {
                dfs(row: range.0, col: range.1, isPacific: isPacific, prevHeight: heights[row][col])
            }
        }
        
        for col in 0..<n {
            dfs(row: 0, col: col, isPacific: true, prevHeight: heights[0][col])
            dfs(row: m - 1, col: col, isPacific: false, prevHeight: heights[m - 1][col])
        }
        
        for row in 0..<m {
            dfs(row: row, col: 0, isPacific: true, prevHeight: heights[row][0])
            dfs(row: row, col: n - 1, isPacific: false, prevHeight: heights[row][n - 1])
        }
        
        var result = [[Int]]()
        for row in 0..<m {
            for col in 0..<n where pac.contains([row, col]) && atl.contains([row, col]) {
                result.append([row, col])
            }
        }
        
        return result
    }
}
/*
 problem:
 Given an m x n matrix board containing 'X' and 'O', capture all regions that are 4-directionally surrounded by 'X'.

 A region is captured by flipping all 'O's into 'X's in that surrounded region.
 
 Testcases:
 Input: board = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]
 Output: [["X","X","X","X"],["X","X","X","X"],["X","X","X","X"],["X","O","X","X"]]
 Explanation: Surrounded regions should not be on the border, which means that any 'O' on the border of the board are not flipped to 'X'. Any 'O' that is not on the border and it is not connected to an 'O' on the border will be flipped to 'X'. Two cells are connected if they are adjacent cells connected horizontally or vertically.
 
 Input: board = [["X"]]
 Output: [["X"]]
 
 
 Constraints:
 m == board.length
 n == board[i].length
 1 <= m, n <= 200
 board[i][j] is 'X' or 'O'
 
 
 link: https://leetcode.com/problems/surrounded-regions/
 explanation: https://www.youtube.com/watch?v=9z2BunfoZ5Y&t=559s
 primary idea:
 - Reverse Thinking. Check if there is any UnSurrounded region from borders like first row, first column, last row, last column. If any, convert `O` to `T`
 - Rest all `O` will be surrounded regions. Convert all `O` to `X` if one traverse
 - Convert all `T` to `O`
 Time Complexity: O(3(m*n))
 Space Complexity: O(1)
 */
class SurroundedRegions {
    func callAsFunction(_ board: inout [[Character]]) {
        let m = board.count, n = board.first!.count
        
        func markUnSurroundedTemporary(row: Int, col: Int) {
            if row < 0 || row == m || col < 0 || col == n || board[row][col] != Character("O") {
                return
            }
            board[row][col] = Character("T")
            for position in [(row - 1, col), (row, col - 1), (row + 1, col), (row, col + 1)] {
                markUnSurroundedTemporary(row: position.0, col: position.1)
            }
        }
        
        for row in 0..<m {
            for col in 0..<n where board[row][col] == Character("O") && ([0, m-1].contains(row) || [0, n-1].contains(col)) {
                markUnSurroundedTemporary(row: row, col: col)
            }
        }
        
        for row in 0..<m {
            for col in 0..<n where board[row][col] == Character("O") {
                board[row][col] = Character("X")
            }
        }
        
        for row in 0..<m {
            for col in 0..<n where board[row][col] == Character("T") {
                board[row][col] = Character("O")
            }
        }
    }
}

class FloodFill {
    func callAsFunction(_ image: [[Int]], _ sr: Int, _ sc: Int, _ newColor: Int) -> [[Int]] {
        var image = image
        let m = image.count, n = image[0].count
        let startColor: Int = image[sr][sc]
        func dfs(row: Int, col: Int) {
            if row < 0 || row == m || col < 0 || col == n || image[row][col] != startColor || image[row][col] == newColor {
                return
            }
            image[row][col] = newColor
            for (nRow, nCol) in [(row - 1, col), (row + 1, col), (row, col - 1), (row, col + 1)] {
                dfs(row: nRow, col: nCol)
            }
        }
        dfs(row: sr, col: sc)
        return image
    }
}

class ReconstructItinerary {
    func callAsFunction(_ tickets: [[String]]) -> [String] {
        var adjList = [String: [String]]()
        let tickets = tickets.sorted{
            if $0[0] == $1[0] {
                return $0[1] < $1[1]
            }
            return $0[0] < $1[0]
        }
        
        for ticket in tickets {
            adjList[ticket[0], default: []].append(ticket[1])
        }
        
        var res = ["JFK"]
        func dfs(_ airport: String) -> Bool {
            if res.count == (tickets.count + 1) {
                return true
            }
            if adjList[airport] == nil {
                return false
            }
            
            let temp = adjList[airport]!
            for (i,destination) in temp.enumerated() {
                adjList[airport]!.remove(at: i)
                res.append(destination)
                if dfs(destination) {
                    return true
                }
                _ = res.popLast()
                adjList[airport]!.insert(destination, at: i)
            }
            return false
        }
        _ = dfs("JFK")
        return res
    }
}

class MaxAreaOfIsland {
    func callAsFunction(_ grid: [[Int]]) -> Int {
        typealias Coordinate = (row: Int, col: Int)
        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        var grid = grid
        let m = grid.count, n = grid[0].count
        
        func dfs(_ coord: Coordinate) -> Int {
            if coord.row < 0 || coord.row == m || coord.col < 0 || coord.col == n || grid[coord.row][coord.col] != 1 {
                return 0
            }
            grid[coord.row][coord.col] = 0
            var area = 1
            for direction in directions {
                area += dfs((coord.row + direction.0, coord.col + direction.1))
            }
            return area
        }
        
        var maxArea = 0
        for row in 0..<m {
            for col in 0..<n where grid[row][col] == 1 {
                maxArea = max(maxArea, dfs((row, col)))
            }
        }
        
        return maxArea
    }
}

/*
 problem:
 There is a directed graph of n nodes with each node labeled from 0 to n - 1. The graph is represented by a 0-indexed 2D integer array graph where graph[i] is an integer array of nodes adjacent to node i, meaning there is an edge from node i to each node in graph[i].

 A node is a terminal node if there are no outgoing edges. A node is a safe node if every possible path starting from that node leads to a terminal node.

 Return an array containing all the safe nodes of the graph. The answer should be sorted in ascending order.
 
 Testcases:
 Input: graph = [[1,2],[2,3],[5],[0],[5],[],[]]
 Output: [2,4,5,6]
 Explanation: The given graph is shown above.
 Nodes 5 and 6 are terminal nodes as there are no outgoing edges from either of them.
 Every path starting at nodes 2, 4, 5, and 6 all lead to either node 5 or 6.
 
 Input: graph = [[1,2,3,4],[1,2],[3,4],[0,4],[]]
 Output: [4]
 Explanation:
 Only node 4 is a terminal node, and every path starting at node 4 leads to node 4.
 
 
 Constraints:
 n == graph.length
 1 <= n <= 104
 0 <= graph[i].length <= n
 0 <= graph[i][j] <= n - 1
 graph[i] is sorted in a strictly increasing order.
 The graph may contain self-loops.
 The number of edges in the graph will be in the range [1, 4 * 104].
 
 
 link: https://leetcode.com/problems/find-eventual-safe-states/
 explanation: https://leetcode.com/problems/find-eventual-safe-states/discuss/902091/Swift-Recursion-%2B-Memo
 primary idea:
 - Backtracking
 - For everypath we traverse, we use a set to detect any cycle
 - We traverse till end of dfs and while backtracking we keep track of safenodes state in memo
 - Every path starting from terminal node leads to same node, so even it is a safe node.
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class FindEventualSafeStates {
    func callAsFunction(_ graph: [[Int]]) -> [Int] {
        typealias Node = Int
        var memo = [Node: Bool]()
        func isSafe(node: Node, path: Set<Int>) -> Bool {
            var eventuallySafe = true
            for neighbourNode in graph[node] {
                if let isAlreadySafe = memo[node] {
                    return isAlreadySafe
                }
                if path.contains(neighbourNode) {
                    eventuallySafe = false
                    break
                }
                var path = path
                path.insert(node)
                if !isSafe(node: neighbourNode, path: path) {
                    eventuallySafe = false
                }
            }
            memo[node] = eventuallySafe
            return eventuallySafe
        }
        var result = [Node]()
        for i in 0..<graph.count {
            if isSafe(node: i, path: Set<Int>()) {
                result.append(i)
            }
        }
        return result
    }
}

class NumberOfClosedIslands {
    func dfsWithBitManipulation(_ grid: [[Int]]) -> Int {
        typealias Coordinate = (row: Int, col: Int)
        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        var grid = grid
        let m = grid.count, n = grid[0].count
        
        func dfs(_ coord: Coordinate) -> Int {
            if coord.row < 0 || coord.row == m || coord.col < 0 || coord.col == n {
                return 0
            }
            if grid[coord.row][coord.col] == 1 {
                return 1
            }
            grid[coord.row][coord.col] = 1
            var res = 1
            for direction in directions {
                let neighbourCoord: Coordinate = (coord.row + direction.0, coord.col + direction.1)
                res = res & dfs(neighbourCoord)
            }
            return res
        }
        
        var result = 0
        for row in 0..<m {
            for col in 0..<n where grid[row][col] == 0 {
                result += dfs((row, col))
            }
        }
        return result
    }
    
    //TO-DO: Check why its failing while using bool instead of bit manipulation
    // link: https://leetcode.com/problems/number-of-closed-islands/discuss/507470/Clean-Swift-Solution-100-Faster-and-100-better-Space-by-Joshua-Puente
    func dfs(_ grid: [[Int]]) -> Int {
        typealias Coordinate = (row: Int, col: Int)
        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        let m = grid.count, n = grid[0].count
        var grid = grid
        
        func dfs(_ coord: Coordinate) -> Bool {
            if coord.row < 0 || coord.row == m || coord.col < 0 || coord.col == n {
                return false
            }
            
            if [1, -1].contains(grid[coord.row][coord.col]) {
                return true
            }
            if grid[coord.row][coord.col] == 0 {
                grid[coord.row][coord.col] = -1
            }
            var res = true
            for direction in directions {
                let neighbourCoord = (coord.row + direction.0, coord.col + direction.1)
                res = res && dfs(neighbourCoord)
            }
            return res
        }
        
        var result = 0
        for row in 0..<m {
            for col in 0..<n where grid[row][col] == 0 {
                if dfs((row, col)) {
                    result += 1
                }
            }
        }
        return result
    }
}

class NumberOfEnclaves {
    func callAsFunction(_ grid: [[Int]]) -> Int {
        typealias Coordinate = (row: Int, col: Int)
        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        let m = grid.count, n = grid[0].count
        var grid = grid
        
        func dfs(_ coord: Coordinate, currentIslandLands: inout Int) -> Int {
            if coord.row < 0 || coord.row == m || coord.col < 0 || coord.col == n {
                return 0
            }
            if grid[coord.row][coord.col] == 0 {
                return 1
            }
            grid[coord.row][coord.col] = 0
            currentIslandLands += 1
            var res = 1
            for direction in directions {
                let neighbourCoord = (coord.row + direction.0, coord.col + direction.1)
                res = res & dfs(neighbourCoord, currentIslandLands: &currentIslandLands)
            }
            return res
        }
        
        var total = 0
        for row in 0..<m {
            for col in 0..<n where grid[row][col] == 1 {
                var currentLands = 0
                if dfs((row, col), currentIslandLands: &currentLands) == 1 {
                    total += currentLands
                }
            }
        }
        return total
    }
}

class KeysAndRooms {
    func dfs(_ rooms: [[Int]]) -> Bool {
        var visited = Set<Int>()
        
        func dfs(_ room: Int) {
            visited.insert(room)
            for nRoom in rooms[room] where !visited.contains(nRoom) {
                dfs(nRoom)
            }
        }
        dfs(0)
        return visited.count == rooms.count
    }
    
    func bfs(_ rooms: [[Int]]) -> Bool {
        var visited = Set<Int>()
        var stack = [0]
        
        while !stack.isEmpty {
            let level = stack
            stack.removeAll()
            
            for room in level {
                visited.insert(room)
                
                for nRoom in rooms[room] {
                    if !visited.contains(nRoom) {
                        stack.append(nRoom)
                    }
                }
            }
        }
        
        return visited.count == rooms.count
    }
}

class FindTownJudge {
    func callAsFunction(_ n: Int, _ trust: [[Int]]) -> Int {
        var trustCountArr = [Int](repeating: 0, count: n+1)
        
        for edge in trust {
            trustCountArr[edge[0]] -= 1
            trustCountArr[edge[1]] += 1
        }
        
        for i in 1..<trustCountArr.count {
            let count = trustCountArr[i]
            if count == (n-1) {
                return i
            }
        }
        return -1
    }
}

class RegionCutBySlashes {
    func regionsBySlashes(_ grid: [String]) -> Int {
        typealias Coordinate = (row: Int, col: Int)
        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        let charToPixelSet = [
            " ": [[0,0,0], [0,0,0], [0,0,0]],
            "/": [[0,0,1], [0,1,0], [1,0,0]],
            "\\": [[1,0,0], [0,1,0], [0,0,1]],
        ]
        
        var matrix = [[Int]]()
        for row in grid {
            var firstRow = [Int](), secondRow = [Int](), thirdRow = [Int]()
            for char in row {
                let pixels = charToPixelSet[String(char)]
                firstRow += pixels![0]
                secondRow += pixels![1]
                thirdRow += pixels![2]
            }
            matrix += [firstRow, secondRow, thirdRow]
        }
        
        let m = matrix.count, n = matrix[0].count
        
        func dfs(_ coord: Coordinate) {
            if coord.row < 0 || coord.row == m || coord.col < 0 || coord.col == n || matrix[coord.row][coord.col] != 0 {
                return
            }
            matrix[coord.row][coord.col] = -1
            for direction in directions {
                let nRow = coord.row + direction.0
                let nCol = coord.col + direction.1
                dfs((nRow, nCol))
            }
        }
        
        var totalregion = 0
        for row in 0..<m {
            for col in 0..<n where matrix[row][col] == 0 {
                dfs((row, col))
                totalregion += 1
            }
        }
        return totalregion
    }
}
