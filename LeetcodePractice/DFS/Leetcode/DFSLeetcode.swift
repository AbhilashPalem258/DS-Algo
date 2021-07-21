//
//  DFSLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 19/07/21.
//

import Foundation

class NumberOfIslands {
    func depthFirst(_ grid: [[Character]]) -> Int {
        let m = grid.count, n = grid[0].count
        var numOfIslands = 0, grid = grid
        
        func bfs(_ row: Int, _ col: Int) {
            if !(0..<m).contains(row) || !(0..<n).contains(col) || grid[row][col] != "1" {
                return
            }
            grid[row][col] = "0"
            bfs(row-1, col)
            bfs(row+1, col)
            bfs(row, col+1)
            bfs(row, col-1)
        }
        
        for row in 0..<m {
            for col in 0..<n where grid[row][col] == "1" {
                numOfIslands += 1
                bfs(row, col)
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
    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        let m = board.count, n = board[0].count
        var visited = Set<[Int]>(), result = [String]()
        
        let boardSet = Set(board.reduce([], +))
        let newWords = words.filter {
            Set($0).subtracting(boardSet).count <= 0
        }
        
        let trie = Trie()
        for word in newWords {
            trie.insert(word)
        }
        
        func dfs(row: Int, col: Int, str: String) {
            if !(0..<m).contains(row) ||  !(0..<n).contains(col) || visited.contains([row, col]) {
                return
            }
            let str = str + "\(board[row][col])"
            if !trie.startsWith(str) {
                return
            }
            
            if trie.search(str) && !result.contains(str) {
                result.append(str)
            }
            
            visited.insert([row, col])
            dfs(row: row, col: col-1, str: str)
            dfs(row: row, col: col+1, str: str)
            dfs(row: row-1, col: col, str: str)
            dfs(row: row+1, col: col, str: str)
            visited.remove([row, col])
        }
        
        for row in 0..<m {
            for col in 0..<n {
                dfs(row: row, col: col, str: "")
            }
        }
        
        return result
    }
}


struct Subsets {
    
    func subsets(_ nums: [Int]) -> [[Int]] {
        var powerset: [[Int]] = [[]]
        nums.forEach { num in
            powerset.forEach { set in
                powerset.append(set + [num])
            }
        }
        return powerset
    }
    
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        let nums = nums.sorted()
        var result = [[Int]]()
        result.append([])
        result.append([nums[0]])
        var lastIndex = 1
        for i in 1..<nums.count {
            var startIndex = 0
            if nums[i] == nums[i-1] {
                startIndex = lastIndex
            }
            lastIndex = result.count
            for j in startIndex..<lastIndex {
                result.append(result[j]+[nums[i]])
            }
        }
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
        return Array(combinations)
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
        
        for i in 0..<graph.count {
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
