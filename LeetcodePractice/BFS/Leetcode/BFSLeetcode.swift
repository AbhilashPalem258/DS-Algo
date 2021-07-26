//
//  BFSLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 24/07/21.
//

import Foundation

/*
 link: https://leetcode.com/problems/word-ladder/
 PrimaryIdea:
    -  create adjacency list, mapped from pattern to words (for finding neighbours)
 TimeComplexity:
 */
struct WordLadder {
    func callAsFunction(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        if !wordList.contains(endWord) {
            return 0
        }
        
        func getAstrikedStr(i: Int, word: String) -> String {
            let pattern = word.prefix(upTo: word.index(word.startIndex, offsetBy: i))
                + "*"
                + word.suffix(from: word.index(word.startIndex, offsetBy: i+1))
            return String(pattern)
        }
        
        var adjacencyList = [String: [String]]()
        for i in 0..<beginWord.count {
            let pattern = getAstrikedStr(i: i, word: beginWord)
            adjacencyList[pattern, default: []].append(beginWord)
        }
        for word in wordList {
            for i in 0..<word.count {
                let pattern = getAstrikedStr(i: i, word: word)
                adjacencyList[pattern, default: []].append(word)
            }
        }
        
        var visited = Set([beginWord])
        var stack = [beginWord], result = 1
        while !stack.isEmpty {
            let levelNodes = stack
            stack.removeAll()
            
            for word in levelNodes {
                if word == endWord {
                    return result
                }
                
                for i in 0..<word.count {
                    let pattern = getAstrikedStr(i: i, word: word)
                    for neighbour in adjacencyList[pattern] ?? [] where !visited.contains(neighbour) {
                        visited.insert(neighbour)
                        stack.append(neighbour)
                    }
                }
            }
            result += 1
        }
        return 0
    }
}

class EvaluateDivision {
    func calcEquation(_ equations: [[String]], _ values: [Double], _ queries: [[String]]) -> [Double] {
        var adjList = [String: [(String, Double)]](), result = [Double]()
        
        func createAdjList() {
            for i in 0..<equations.count {
                
                let equation = equations[i]
                let value = values[i]
                
                if let dividend = equation.first, let divisor = equation.last {
                    adjList[dividend, default: []].append((divisor, value))
                    adjList[divisor, default: []].append((dividend, 1.0/value))
                }
            }
        }
        
        func bfs(query: [String]) {
            guard let first = query.first, let last = query.last else {
                result.append(-1.0)
                return
            }
            if adjList[first] == nil || adjList[last] == nil {
                result.append(-1.0)
                return
            }
            if first == last {
                result.append(1.0)
                return
            }
            
            var stack = [first]
            var vals = [1.0]
            var visited = Set<String>()
            
            while !stack.isEmpty {
                
                let levelNodes = stack
                let levelVals = vals
                
                stack.removeAll()
                vals.removeAll()
                
                for i in 0..<levelNodes.count {
                    let currentStr = levelNodes[i]
                    let currentVal = levelVals[i]
                    
                    if currentStr == last {
                        result.append(currentVal)
                        return
                    }
                    
                    guard let neighbours = adjList[currentStr] else {
                        continue
                    }
                    
                    for neighbour in neighbours where !visited.contains(neighbour.0) {
                        visited.insert(neighbour.0)
                        stack.append(neighbour.0)
                        vals.append(currentVal * neighbour.1)
                    }
                }
            }
            result.append(-1.0)
        }
        
        createAdjList()
        for query in queries {
            bfs(query: query)
        }
        return result
    }
}

class ShortestDistanceAllBuildings {
    func shortestDistance(_ grid: [[Int]]) -> Int {
        let m = grid.count, n = grid.first!.count
        var shortestDistance = Int.max, buildingNums = 0
        var reachableDistanceGrid = Array(repeating: Array(repeating: (reachable: 0, distance: 0), count: n), count: m)
        
        func bfs(row: Int, col: Int) {
            var visted = Set<[Int]>(), stack = [[row, col]], distance = [0]
            visted.insert([row, col])
            
            while !stack.isEmpty {
                let levelPoints = stack
                let levelDistances = distance
                
                stack.removeAll()
                distance.removeAll()
                
                for i in 0..<levelPoints.count {
                    let currentRow = levelPoints[i][0]
                    let currentCol = levelPoints[i][1]
                    let currentDistance = levelDistances[i]
                    let ranges = [
                        (currentRow - 1, currentCol),
                        (currentRow + 1, currentCol),
                        (currentRow, currentCol - 1),
                        (currentRow, currentCol + 1)
                    ]
                    
                    if grid[currentRow][currentCol] == 0 {
                        let (existingReachable, existingDistance) = reachableDistanceGrid[currentRow][currentCol]
                        reachableDistanceGrid[currentRow][currentCol] = (existingReachable + 1, existingDistance + currentDistance)
                    }
                    
                    for range in ranges {
                        if !(0..<m).contains(range.0) || !(0..<n).contains(range.1) || visted.contains([range.0, range.1]) {
                            continue
                        }
                        if grid[range.0][range.1] != 0 {
                            continue
                        }
                        visted.insert([range.0, range.1])
                        stack.append([range.0, range.1])
                        distance.append(currentDistance + 1)
                    }
                }
            }
            
        }
        
        for row in 0..<m {
            for col in 0..<n where grid[row][col] == 1 {
                buildingNums += 1
                bfs(row: row, col: col)
            }
        }
        
        for row in 0..<m {
            for col in 0..<n {
                if reachableDistanceGrid[row][col].reachable == buildingNums {
                    shortestDistance = min(shortestDistance, reachableDistanceGrid[row][col].distance)
                }
            }
        }
        
        return shortestDistance == Int.max ? -1 : shortestDistance
    }
    
}
