//
//  BFSLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 24/07/21.
//

import Foundation
import AppKit

//https://medium.com/techie-delight/top-20-breadth-first-search-bfs-practice-problems-ac2812283ab1
//https://igotanoffer.com/blogs/tech/breadth-first-search-interview-questions#medium
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

class AsFarFromLandAsPossible {
    //TLE
    func callAsFunction(_ grid: [[Int]]) -> Int {
        typealias Coordinate = (row: Int, col: Int)
        let m = grid.count, n = grid[0].count
        var reachableDistanceGrid = Array(repeating: Array(repeating: Int.max, count: n), count: m)
        let directions = [(-1, 0), (1, 0), (0, 1), (0, -1)]
        
        func bfs(_ coord: Coordinate) {
            var visited = Set<[Int]>()
            var stack = [(coord: coord, distance: 0)]
            
            while !stack.isEmpty {
                let level = stack
                stack.removeAll()
                
                for node in level {
                    let currentCoord = node.coord
                    if grid[currentCoord.row][currentCoord.col] == 0 {
                        let existingDistance = reachableDistanceGrid[currentCoord.row][currentCoord.col]
                        reachableDistanceGrid[currentCoord.row][currentCoord.col] = min(node.distance, existingDistance)
                    }
                    
                    for direction in directions {
                        let nRow = currentCoord.row + direction.0
                        let nCol = currentCoord.col + direction.1
                        
                        if nRow < 0 || nCol < 0 || nRow == m || nCol == n || grid[nRow][nCol] == 1 || visited.contains([nRow, nCol]) {
                            continue
                        }
                        
                        stack.append(((nRow, nCol), node.distance + 1))
                        visited.insert([nRow, nCol])
                    }
                }
            }
        }
        
        for row in 0..<m {
            for col in 0..<n where grid[row][col] == 1 {
                bfs((row, col))
            }
        }
        
        var maxDistance = Int.min
        for row in 0..<m {
            for col in 0..<n where ![0, Int.max].contains(reachableDistanceGrid[row][col]) {
                maxDistance = max(maxDistance, reachableDistanceGrid[row][col])
            }
        }
        return maxDistance == Int.min ? -1 : maxDistance
    }
    
    func maxDistance(_ grid: [[Int]]) -> Int {
        typealias Coordinate = (row: Int, col: Int)
        let land = 1
        let m = grid.count, n = grid[0].count
        let directions = [(-1, 0), (1, 0), (0, 1), (0, -1)]
        var visited = [[Bool]](repeating: [Bool](repeating: false, count: n), count: m)
        
        var stack: [Coordinate] = []
        for row in 0..<m {
            for col in 0..<n where grid[row][col] == land {
                stack.append((row, col))
                visited[row][col] = true
            }
        }
        
        if stack.isEmpty || stack.count == m*n {
            return -1
        }
        
        var levels = 0
        while !stack.isEmpty {
            let level = stack
            stack.removeAll()
            
            for current in level {
                for direction in directions {
                    let nRow = current.row + direction.0
                    let nCol = current.col + direction.1
                    
                    if nRow < 0 || nRow == m || nCol < 0 || nCol == n || visited[nRow][nCol] || grid[nRow][nCol] == 1{
                        continue
                    }
                    
                    stack.append((nRow, nCol))
                    visited[nRow][nCol] = true
                }
            }
            levels += 1
        }
        return levels - 1
    }
}

class RottingOranges {
    func callAsFunction(_ grid: [[Int]]) -> Int {
        var fresh = 0, time = 0, grid = grid
        var queue = [(row: Int, col: Int)]()
        
        let m = grid.count, n = grid[0].count
        for row in 0..<m {
            for col in 0..<n {
                if grid[row][col] == 1 {
                    fresh += 1
                } else if grid[row][col] == 2 {
                    queue.append((row, col))
                }
             }
        }
        
        while !queue.isEmpty && fresh > 0 {
            let levelNodes = queue
            queue.removeAll()
            
            for (row, col) in levelNodes {
                for (adjRow, adjCol) in [(row - 1, col), (row, col - 1), (row + 1, col), (row, col + 1)] {
                    if adjRow < 0 || adjRow == m || adjCol < 0 || adjCol == n || grid[adjRow][adjCol] != 1 {
                        continue
                    }
                    grid[adjRow][adjCol] = 2
                    fresh -= 1
                    queue.append((adjRow, adjCol))
                }
            }
            time += 1
        }
        
        return fresh == 0 ? time : -1
    }
}

/*
 problem:
 You have a lock in front of you with 4 circular wheels. Each wheel has 10 slots: '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'. The wheels can rotate freely and wrap around: for example we can turn '9' to be '0', or '0' to be '9'. Each move consists of turning one wheel one slot.

 The lock initially starts at '0000', a string representing the state of the 4 wheels.

 You are given a list of deadends dead ends, meaning if the lock displays any of these codes, the wheels of the lock will stop turning and you will be unable to open it.

 Given a target representing the value of the wheels that will unlock the lock, return the minimum total number of turns required to open the lock, or -1 if it is impossible.
 
 Testcases:
 Input: deadends = ["0201","0101","0102","1212","2002"], target = "0202"
 Output: 6
 Explanation:
 A sequence of valid moves would be "0000" -> "1000" -> "1100" -> "1200" -> "1201" -> "1202" -> "0202".
 Note that a sequence like "0000" -> "0001" -> "0002" -> "0102" -> "0202" would be invalid,
 because the wheels of the lock become stuck after the display becomes the dead end "0102".
 
 Input: deadends = ["8888"], target = "0009"
 Output: 1
 Explanation: We can turn the last wheel in reverse to move from "0000" -> "0009".
 
 Input: deadends = ["8887","8889","8878","8898","8788","8988","7888","9888"], target = "8888"
 Output: -1
 Explanation: We cannot reach the target without getting stuck.
 
 
 Constraints:
 1 <= deadends.length <= 500
 deadends[i].length == 4
 target.length == 4
 target will not be in the list deadends.
 target and deadends[i] consist of digits only.
 
 
 link: https://leetcode.com/problems/open-the-lock/
 explanation: https://www.youtube.com/watch?v=Pzg3bCDY87w
 primary idea:
 - As we need to find minium number of turns, shortest path, we go with BFS
 - As the deadends are technically something we dont want to visit them as we get struck, we initialize it with visit set
 - In case "9000" and we need to turn 9 + 1, ideally it should become "0000" but 9 + 1 = 10, so we take mod of 10 to make rotation
 - In case "0000" and we need to turn 9 - 1, ideally it should become "9000" but 0 - 1 = -1, so we add 10 to it and take mod of 10 to make rotation
 Time Complexity: O(10^4)
 Space Complexity: O(10^4)
 */
class OpenTheLock {
    func callAsFunction(_ deadends: [String], _ target: String) -> Int {
        
        func children(_ lock: String) -> [String] {
            let lock = lock.map{String($0)}
            var res = [String]()
            for i in 0..<4 {
                if let digit = Int(lock[i]) {
                    let AddLockChar = String((digit + 1) % 10)
                    res.append((lock[..<i] + [AddLockChar] + lock[(i+1)...]).joined())
                    let SubtractLockChar = String((digit - 1 + 10) % 10)
                    res.append((lock[..<i] + [SubtractLockChar] + lock[(i+1)...]).joined())
                }
            }
            return res
        }
        
        if deadends.contains("0000") {
            return -1
        }
        
        var visit: Set<String> = Set(deadends)
        var stack: [(lock: String, turns: Int)] = [("0000", 0)]
        
        while !stack.isEmpty {
            let level = stack
            stack.removeAll()
            
            for lockNode in level {
                if lockNode.lock == target {
                    return lockNode.turns
                }
                for child in children(lockNode.lock) {
                    if !visit.contains(child) {
                        visit.insert(child)
                        stack.append((child, lockNode.turns + 1))
                    }
                }
            }
        }
        return -1
    }
}


/*
 problem:
 You are given an n x n integer matrix board where the cells are labeled from 1 to n2 in a Boustrophedon style starting from the bottom left of the board (i.e. board[n - 1][0]) and alternating direction each row.

 You start on square 1 of the board. In each move, starting from square curr, do the following:

 Choose a destination square next with a label in the range [curr + 1, min(curr + 6, n2)].
 This choice simulates the result of a standard 6-sided die roll: i.e., there are always at most 6 destinations, regardless of the size of the board.
 If next has a snake or ladder, you must move to the destination of that snake or ladder. Otherwise, you move to next.
 The game ends when you reach the square n2.
 A board square on row r and column c has a snake or ladder if board[r][c] != -1. The destination of that snake or ladder is board[r][c]. Squares 1 and n2 do not have a snake or ladder.

 Note that you only take a snake or ladder at most once per move. If the destination to a snake or ladder is the start of another snake or ladder, you do not follow the subsequent snake or ladder.

 For example, suppose the board is [[-1,4],[-1,3]], and on the first move, your destination square is 2. You follow the ladder to square 3, but do not follow the subsequent ladder to 4.
 Return the least number of moves required to reach the square n2. If it is not possible to reach the square, return -1.
 
 Testcases:
 Input: board = [[-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1],[-1,35,-1,-1,13,-1],[-1,-1,-1,-1,-1,-1],[-1,15,-1,-1,-1,-1]]
 Output: 4
 Explanation:
 In the beginning, you start at square 1 (at row 5, column 0).
 You decide to move to square 2 and must take the ladder to square 15.
 You then decide to move to square 17 and must take the snake to square 13.
 You then decide to move to square 14 and must take the ladder to square 35.
 You then decide to move to square 36, ending the game.
 This is the lowest possible number of moves to reach the last square, so return 4.
 
 Input: board = [[-1,-1],[-1,3]]
 Output: 1
 
 Constraints:
 n == board.length == board[i].length
 2 <= n <= 20
 grid[i][j] is either -1 or in the range [1, n2].
 The squares labeled 1 and n2 do not have any ladders or snakes.
 
 link: https://leetcode.com/problems/snakes-and-ladders/
 explanation: https://www.youtube.com/watch?v=6lH4nO3JfLk
 primary idea:
 -
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class SnakesAndLadders {
    func callAsFunction(_ board: [[Int]]) -> Int {
        let board = Array(board.reversed())
        let n = board.count
        var visit = Set([1])
        
        // row col starts from 1. so row and col will be calculated by -1
        func position(_ square: Int) -> (row: Int, col: Int) {
            let row = (square - 1) / n
            var col = (square - 1) % n
            if row % 2 == 1 {
                col = n - 1 - col
            }
            return (row, col)
        }
        
        var stack: [(square: Int, moves: Int)] = [(1, 0)]
        
        while !stack.isEmpty {
            let level = stack
            stack.removeAll()
            
            for node in level {
                let (square, moves) = node
                
                for i in 1..<7 {
                    var nextSquare = square + i
                    let position = position(nextSquare)
                    if board[position.row][position.col] != -1 {
                        nextSquare = board[position.row][position.col]
                    }
                    if nextSquare == n * n {
                        return moves + 1
                    }
                    if !visit.contains(nextSquare) {
                        visit.insert(nextSquare)
                        stack.append((nextSquare, moves + 1))
                    }
                }
            }
        }
        return -1
    }
}

class CutOffTreesForAGolfEvent {
    typealias Coordinate = (row: Int, col: Int)
    typealias Tree = (height: Int, position: Coordinate)
    
    func callAsFunction(_ forest: [[Int]]) -> Int {
        if forest.isEmpty || forest[0].isEmpty {
            return -1
        }
        
        let m: Int = forest.count, n: Int = forest[0].count
        var trees: [Tree] = []
        
        for row in 0..<m {
            for col in 0..<n where forest[row][col] > 1 {
                trees.append((forest[row][col], (row, col)))
            }
        }
        
        trees.sort { $0.height < $1.height }
        var minSteps = bfs(forest: forest, start: (row: 0, col: 0), target: trees[0].position)
        if trees.count == 1 || minSteps == -1 {
            return minSteps
        }
        for i in 1..<trees.count {
            let start = trees[i - 1].position
            let target = trees[i].position
            let currentSteps = bfs(forest: forest, start: start, target: target)
            if currentSteps == -1 {
                return currentSteps
            }
            minSteps += currentSteps
        }
        return minSteps
    }
    
    func bfs(forest: [[Int]], start: Coordinate, target: Coordinate) -> Int {
        if start == target {
            return 0
        }
        var minSteps = 0, forest = forest
        var stack = [start]
        let m: Int = forest.count, n: Int = forest[0].count
        
        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        
        while !stack.isEmpty {
            let level = stack
            stack.removeAll()
            
            for coord in level {
                if coord == target {
                    return minSteps
                }
                
                for direction in directions {
                    let neighbourRow = coord.row + direction.0
                    let neighbourCol = coord.col + direction.1
                    if !(neighbourRow < 0 || neighbourRow == m || neighbourCol < 0 || neighbourCol == n) && forest[neighbourRow][neighbourCol] > 0 {
                        forest[neighbourRow][neighbourCol] = -1
                        stack.append((neighbourRow, neighbourCol))
                    }
                }
            }
            minSteps += 1
        }
        return -1
    }
}

class GetWatchedVideosbyYourFriends {
    func callAsFunction(_ watchedVideos: [[String]], _ friends: [[Int]], _ id: Int, _ level: Int) -> [String] {
        var stack = [id], currentLevel = 0
        var videoFrequency = [String: Int]()
        var visited = Set([id])
        
        while !stack.isEmpty {
            let levelNodes = stack
            stack.removeAll()
            
            for node in levelNodes {
                if level == currentLevel {
                    for video in watchedVideos[node] {
                        videoFrequency[video, default: 0] += 1
                    }
                } else {
                    for friend in friends[node] where !visited.contains(friend) {
                        visited.insert(friend)
                        stack.append(friend)
                    }
                }
            }
            currentLevel += 1
        }
        
        let result = videoFrequency.sorted(by: {
            if $0.value == $1.value {
                return $0.key < $1.key
            }
            return $0.value < $1.value
        })
        
        return result.map{$0.key}
    }
}

class ZeroOneMatrix {
    typealias Coordinate = (row: Int, col: Int)
    let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
    func callAsFunction(_ mat: [[Int]]) -> [[Int]] {
        let m = mat.count, n = mat[0].count
        var result = mat
        
        var stack: [Coordinate] = []
        for row in 0..<m {
            for col in 0..<n {
                if result[row][col] == 0 {
                    stack.append((row, col))
                } else {
                    result[row][col] = Int.max
                }
            }
        }
        
        while !stack.isEmpty {
            let level = stack
            stack.removeAll()
            
            for currentCoord in level {
                for direction in directions {
                    let neighbourRow = currentCoord.row + direction.0
                    let neighbourCol = currentCoord.col + direction.1
                    
                    if neighbourRow < 0 || neighbourRow == m || neighbourCol < 0 || neighbourCol == n || result[neighbourRow][neighbourCol] <= result[currentCoord.row][currentCoord.col] + 1 {
                        continue
                    }
                    
                    stack.append((neighbourRow, neighbourCol))
                    result[neighbourRow][neighbourCol] = result[currentCoord.row][currentCoord.col] + 1
                }
            }
        }
        return result
    }
}

class EmployeeImportance {
    public class Employee {
        public var id: Int
        public var importance: Int
        public var subordinates: [Int]
        public init(_ id: Int, _ importance: Int, _ subordinates: [Int]) {
            self.id = id
            self.importance = importance
            self.subordinates = subordinates
        }
    }
    func getImportance(_ employees: [Employee], id: Int) -> Int {
        var idToEmpDetails = [Int: Employee]()
        for employee in employees {
            idToEmpDetails[employee.id] = employee
        }
        
        var stack = [id]
        var importance = 0
        
        while !stack.isEmpty {
            let level = stack
            stack.removeAll()
            
            for currentEmpId in level {
                let currentEmp = idToEmpDetails[currentEmpId]
                importance += currentEmp?.importance ?? 0
                
                stack += currentEmp?.subordinates ?? []
            }
        }
        return importance
    }
}

class TimeNeededToInformAllEmployees {
    func bfs(_ n: Int, _ headID: Int, _ manager: [Int], _ informTime: [Int]) -> Int {
        var adjList = [Int: [Int]]()
        for subordinate in 0..<n {
            let boss = manager[subordinate]
            if boss != -1 {
                adjList[boss, default: []].append(subordinate)
            }
        }
        
        var stack = [(employee: headID, timeToReachHere: 0)]
        var maxTimeNeeded = Int.min
        
        while !stack.isEmpty {
            let level = stack
            stack.removeAll()
            
            for current in level {
                let currentPathTime = current.timeToReachHere + informTime[current.employee]
                if currentPathTime > maxTimeNeeded {
                    maxTimeNeeded = currentPathTime
                }
                
                for subordinate in adjList[current.employee] ?? [] {
                    stack.append((subordinate, currentPathTime))
                }
            }
        }
        
        return maxTimeNeeded
    }
    
    func dfs(_ n: Int, _ headID: Int, _ manager: [Int], _ informTime: [Int]) -> Int {
        var adjlist = [Int: [Int]]()
        for employee in 0..<n {
            let boss = manager[employee]
            if boss != -1 {
                adjlist[boss, default: []].append(employee)
            }
        }
        
        func totalTimeNeeded(_ employee: Int, _ currentPathTime: Int) -> Int {
            if adjlist[employee] == nil {
                return currentPathTime
            }
            
            let currentPathTime = currentPathTime + informTime[employee]
            var maxTimeNeeded = currentPathTime
            for subordinate in adjlist[employee] ?? [] {
                let totalPathTime = totalTimeNeeded(subordinate, currentPathTime)
                if totalPathTime > maxTimeNeeded {
                    maxTimeNeeded = totalPathTime
                }
            }
            return maxTimeNeeded
        }
        
        return totalTimeNeeded(headID, 0)
    }
}

class ShortestPathBinaryMatrix {
    func callAsFunction(_ grid: [[Int]]) -> Int {
        let n = grid.count
        if grid[0][0] == 1 {
            return -1
        }
        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1), (-1, -1), (-1, 1), (1, -1), (1, 1)]
        typealias Coordinate = (row: Int, col: Int)
        var grid = grid
        let targetCoord = (n-1, n-1)
        var stack: [(coord: Coordinate, pathSteps: Int)] = [((0, 0), 1)]
        
        var minSteps = Int.max
        while !stack.isEmpty {
            let level = stack
            stack.removeAll()
            
            for currentNode in level {
                if currentNode.coord == targetCoord {
                    minSteps = min(minSteps, currentNode.pathSteps)
                }
                
                for direction in directions {
                    let nRow = currentNode.coord.row + direction.0
                    let nCol = currentNode.coord.col + direction.1
                    
                    if nRow < 0 || nRow == n || nCol < 0 || nCol == n || grid[nRow][nCol] == 1 {
                        continue
                    }
                    
                    stack.append(((nRow, nCol), currentNode.pathSteps + 1))
                    grid[nRow][nCol] = 1
                }
            }
        }
        return minSteps == Int.max ? -1 : minSteps
    }
}

class ShortestPathInAGridWithObstacles {
    struct Coordinate: Hashable, Equatable {
        let row: Int
        let col: Int
    }
    
    struct CellVisit: Hashable, Equatable {
        let coord: Coordinate
        let obstacleChances: Int
    }
    
    func callAsFunction(_ grid: [[Int]], _ k: Int) -> Int {
        if k == 0 && grid[0][0] == 1 {
            return -1
        }
        var steps = 0, visited = Set<CellVisit>()
        var minSteps = Int.max
        let m = grid.count, n = grid[0].count
        let destination = Coordinate(row: m - 1, col: n - 1)
        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        
        var stack = [CellVisit(coord: Coordinate(row: 0,col: 0), obstacleChances: k)]
        while !stack.isEmpty {
            let level = stack
            stack.removeAll()
            
            for current in level {
                let (coord, chances) = (current.coord, current.obstacleChances)
                if coord == destination {
                    minSteps = min(minSteps, steps)
                }
                
                for direction in directions {
                    let neighbour = Coordinate(row: coord.row + direction.0, col: coord.col + direction.1)
                    
                    if neighbour.row < 0 || neighbour.row == m || neighbour.col < 0 || neighbour.col == n || (grid[neighbour.row][neighbour.col] == 1 && chances == 0) {
                        continue
                    }
                    var chances = chances
                    if grid[neighbour.row][neighbour.col] == 1 {
                        chances -= 1
                    }
                    let cell = CellVisit(coord: neighbour, obstacleChances: chances)
                    if !visited.contains(cell) {
                        visited.insert(cell)
                        stack.append(cell)
                    }
                }
            }
            steps += 1
        }
        return minSteps == Int.max ? -1 : minSteps
    }
}

/*
 link:https://leetcode.com/problems/largest-local-values-in-a-matrix/?envType=daily-question&envId=2024-05-12
 PrimaryIdea: https://www.youtube.com/watch?v=wdTRu9sarFA
 TimeComplexity: 9 * O(n^2)
 */
class LargestLocalValuesInaMatrix {
    func solution1(_ grid: [[Int]]) -> [[Int]] {
        func getMaxVal(row: Int, col: Int) -> Int {
            var maxVal = grid[row][col]
            for position in [(row - 1, col - 1), (row - 1, col), (row - 1, col + 1), (row, col - 1), (row, col + 1), (row + 1, col - 1), (row + 1, col), (row + 1, col + 1)] {
                maxVal = max(maxVal, grid[position.0][position.1])
            }
            return maxVal
        }
        
        let n = grid.count
        var output = [[Int]].init(repeating: [Int](repeating: 0, count: n-2), count: n-2)
        for row in 1..<n-1 {
            for col in 1..<n-1 {
                output[row - 1][col - 1] = getMaxVal(row: row, col: col)
            }
        }
        return output
    }
    
    func solution2(_ grid: [[Int]]) -> [[Int]] {
        func getMaxValue(row: Int, col: Int) -> Int {
            var maxVal = 0
            for currentRow in row..<row+3 {
                for currentCol in col..<col+3 {
                    maxVal = max(maxVal, grid[currentRow][currentCol])
                }
            }
            return maxVal
        }
        
        let n = grid.count
        var output = [[Int]].init(repeating: [Int](repeating: 0, count: n-2), count: n-2)
        for row in 0..<n-2 {
            for col in 0..<n-2 {
                output[row][col] = getMaxValue(row: row, col: col)
            }
        }
        return output
    }
}
