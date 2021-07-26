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
            map = [String: [String]](),
            visited = Set<String>()
        
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
//                visited.insert(currentWord)
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
//                visited.remove(prefixWords[i])
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
