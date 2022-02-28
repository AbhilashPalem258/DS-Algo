//
//  UFLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 27/07/21.
//

import Foundation

/*
 Given n nodes labeled from 0 to n - 1 and a list of undirected edges (each edge is a pair of nodes), write a function to find the number of connected components in an undirected graph.

 Example 1:
      0          3
      |          |
      1 --- 2    4
 Given n = 5 and edges = [[0, 1], [1, 2], [3, 4]], return 2.

 Example 2:
      0           4
      |           |
      1 --- 2 --- 3
 Given n = 5 and edges = [[0, 1], [1, 2], [2, 3], [3, 4]], return 1.

 Note:
 You can assume that no duplicate edges will appear in edges. Since all edges are undirected, [0, 1] is the same as [1, 0] and thus will not appear together in edges.
 */
/*
 explanation: https://www.youtube.com/watch?v=8f1XPm4WOUc&list=PLot-Xpze53ldBT_7QA8NVot219jFNr_GI&index=14
 primary idea:
 - create Adj list, map from course to its prerequisite courses
 - perform classic DFS on Adj list
 - once we get to know that specific course is completable, mark it's adj list value as empty which helps reduce redundant operations #44
 - Given prerequites may contain un connected graphs, better to loops through evey course so that we don miss any course #67
 Time Complexity:
 Space Complexity:
 */
class NumberConnectedComponentsUndirectedGraph {
    func countComponents(_ n: Int, _ edges: [[Int]]) -> Int {
        var parent = Array(0..<n)
        var rank = Array(repeating: 1, count: n)
        
        func find(_ node: Int) -> Int {
            var res = node
            while res != parent[res] {
                parent[res] = parent[parent[res]]
                res = parent[res]
            }
            return res
        }
        
        func union(n1: Int, n2: Int) -> Int {
            let p1 = find(n1)
            let p2 = find(n2)
            
            if p1 == p2 {
                return 0
            }
            
            if rank[p2] > rank[p1] {
                parent[p1] = p2
                rank[p2] += rank[p1]
            } else {
                parent[p2] = p1
                rank[p1] += rank[p2]
            }
            return 1
        }
        
        var res = n
        for edge in edges {
            res -= union(n1: edge[0], n2: edge[1])
        }
        return res
    }
}

class NumberOfProvinces {
    func callAsFunction(_ isConnected: [[Int]]) -> Int {
        let n = isConnected.count
        var parent = Array(0..<n)
        var rank = Array(repeating: 1, count: n)
        
        func find(_ node: Int) -> Int {
            var res = node
            while res != parent[res] {
                parent[res] = parent[parent[res]]
                res = parent[res]
            }
            return res
        }
        
        func union(n1: Int, n2: Int) -> Int {
            let p1 = find(n1)
            let p2 = find(n2)
            if p1 == p2 {
                return 0
            }
            if rank[p2] > rank[p1] {
                parent[p1] = p2
                rank[p2] += rank[p1]
            } else {
                parent[p2] = p1
                rank[p1] += rank[p2]
            }
            return 1
        }
        
        var res = n
        for row in 0..<n {
            for col in 0..<n where isConnected[row][col] == 1 && row != col {
                res -= union(n1: row, n2: col)
            }
        }
        return res
    }
}

class RedundantConnection {
    func findRedundantConnection(_ edges: [[Int]]) -> [Int] {
        var parent = Array(0...edges.count+1)
        var rank = Array(repeating: 1, count: edges.count+1)
        
        func find(node: Int) -> Int {
            var res = node
            while res != parent[res] {
                parent[res] = parent[parent[res]]
                res = parent[res]
            }
            return res
        }
        
        func union(n1: Int, n2: Int) -> Bool {
            let p1 = find(node: n1), p2 = find(node: n2)
            if p1 == p2 {
                return false
            }
            if rank[p2] > rank[p1] {
                parent[p1] = p2
                rank[p2] += rank[p1]
            } else {
                parent[p2] = p1
                rank[p1] += rank[p2]
            }
            return true
        }
        
        for edge in edges {
            if !union(n1: edge[0], n2: edge[1]) {
                return [edge[0], edge[1]]
            }
        }
        return [-1, -1]
    }
}

class MinCostConnectPoints {
    func callAsFunction(_ points: [[Int]]) -> Int {
        var edges = [(v1: Int, v2: Int, weight: Int)]()
        for i in 0..<points.count {
            let p1 = points[i]
            for j in i+1..<points.count {
                let p2 = points[j]
                edges.append((i, j, abs(p1[0] - p2[0]) + abs(p1[1] - p2[1])))
            }
        }
        
        edges.sort {
            $0.weight < $1.weight
        }
        
        var parent = Array(0..<points.count)
        func find(_ node: Int) -> Int {
            var res = node
            while res != parent[node] {
                parent[node] = parent[parent[node]]
                res = parent[node]
            }
            return res
        }
        
        var minCost = 0
        for edge in edges {
            let p1 = find(edge.v1)
            let p2 = find(edge.v2)
            
            if p1 != p2 {
                minCost += edge.weight
                parent[p2] = p1
            }
        }
        
        return minCost
    }
}

class LargestComponentSizeByCommonFactor {
    func callAsFunction(_ nums: [Int]) -> Int {
        func factors(_ num: Int) -> [Int] {
            var num = num, result = [Int]()
            var factor = 2
            
            var prev = 1
            while num >= factor * factor {
                if num % factor == 0 {
                    if factor != prev {
                        result.append(factor)
                    }
                    prev = factor
                    num = num / factor
                } else {
                    factor += 1
                }
            }
            
            result.append(num)
            return result
        }
        
        var factorToNumList = [Int: [Int]]()
        for i in 0..<nums.count {
            for factor in factors(nums[i]) {
                factorToNumList[factor, default: []].append(i)
            }
        }
        
        var parent = Array(0..<nums.count)
        
        func find(_ index: Int) -> Int {
            var res = index
            while res != parent[res] {
                res = parent[res]
            }
            return res
        }
        
        func union(_ index1: Int, _ index2: Int) {
            parent[find(index2)] = parent[find(index1)]
        }
        
        for (_, list) in factorToNumList {
            for i in 0..<list.count - 1 {
                union(list[i], list[i+1])
            }
        }
        
        var rootToSizeCount = [Int: Int]()
        var maxSizeConnected = 0
        for i in 0..<nums.count {
            let root = find(i)
            rootToSizeCount[root, default: 0] += 1
            maxSizeConnected = max(maxSizeConnected, rootToSizeCount[root]!)
        }
        return maxSizeConnected
    }
}

class MostStonesRemovedWithSameRowOrCol {
    func callAsFunction(_ stones: [[Int]]) -> Int {
        var uf = DSU(stones.count)
        for i in 0..<stones.count {
            for j in i+1..<stones.count where stones[i][0] == stones[j][0] || stones[i][1] == stones[j][1] {
                uf.union(i, j)
            }
        }
        return uf.count
    }
    
    struct DSU {
        private var parent: [Int]
        private var rank: [Int]
        private(set) var count = 0
        
        init(_ m: Int) {
            parent = Array(0..<m)
            rank = [Int](repeating: 1, count: m)
        }
        
        mutating func findRoot(_ node: Int) -> Int {
            var res = node
            while res != parent[res] {
                parent[res] = parent[parent[res]]
                res = parent[res]
            }
            return res
        }
        
        mutating func union(_ node1: Int, _ node2: Int) {
            let root1 = findRoot(node1)
            let root2 = findRoot(node2)
            
            if root1 == root2 {
                return
            }
            
            if rank[root1] > rank[root2] {
                parent[root2] = root1
                rank[root1] += rank[root2]
            } else {
                parent[root1] = root2
                rank[root2] += rank[root1]
            }
            count += 1
        }
    }
}

class NumberOfOperationsToMakeNetworkConnected {
    func callAsFunction(_ n: Int, _ connections: [[Int]]) -> Int {
        if connections.count < (n-1) {
            return -1
        }
        var uf = DSU(n)
        for connection in connections {
            uf.union(connection[0], connection[1])
        }
        return  (n - 1) - uf.count
    }
    
    struct DSU {
        typealias Node = Int
        private var parent: [Node]
        private var rank: [Int]
        private(set) var count = 0
        
        init(_ n: Int) {
            parent = Array(0..<n)
            rank = [Int](repeating: 1, count: n)
        }
        
        private mutating func findRoot(_ node: Node) -> Node {
            var res = node
            while res != parent[res] {
                parent[res] = parent[parent[res]]
                res = parent[res]
            }
            return res
        }
        
        mutating func union(_ node1: Node, _ node2: Node) {
            let root1 = findRoot(node1)
            let root2 = findRoot(node2)
            
            if root1 == root2 {
                return
            }
            
            if rank[root2] > rank[root1] {
                parent[root1] = root2
                rank[root2] += rank[root1]
            } else {
                parent[root2] = root1
                rank[root1] += rank[root2]
            }
            count += 1
        }
    }
}
//Tarjan's Algorithm
class CriticalConnectionsInANetwork {
    func criticalConnections(_ n: Int, _ connections: [[Int]]) -> [[Int]] {
        typealias Node = Int
        var adjList = [Node: [Node]]()
        for connection in connections {
            let start = connection[0]
            let end = connection[1]
            adjList[start, default: []].append(end)
            adjList[end, default: []].append(start)
        }
        
        var rank = [Int](repeating: -2, count: n)
        var lowest = [Int](repeating: -2, count: n)
        var criticalConnections = [[Int]]()
        var articulationPoints = Set<Node>()
        let rootNode: Node = 0
        
        func dfs(_ node: Node, discoverRank: Int) -> (Int, Bool) {
            if rank[node] != -2 {
                return (lowest[node], true)
            }
            
            rank[node] = discoverRank
            lowest[node]  = discoverRank
            var child = 0
            
            for neighbour in adjList[node] ?? [] {
                if rank[neighbour] == discoverRank - 1 {
                    continue
                }
                
                let (recursiveRank, isAlreadyVisited) = dfs(neighbour, discoverRank: discoverRank+1)
                if isAlreadyVisited == false {
                    child += 1
                }
                lowest[node] = min(lowest[node], recursiveRank)
                
                if recursiveRank > discoverRank {
                    if (rootNode == node && child > 1) || (rootNode != node && child > 0) {
                        articulationPoints.insert(node)
                    }
                    criticalConnections.append([node, neighbour])
                }
            }
            return (lowest[node], false)
        }
        _ = dfs(rootNode, discoverRank: 0)
        return criticalConnections
    }
}

class AccountsMerge {
    func callAsFunction(_ accounts: [[String]]) -> [[String]] {
        var uf = DSU(accounts.count)
        
        var emailToIndex = [String: Int]()
        for (i,account) in accounts.enumerated() {
            for emailIndex in 1..<account.count {
                let email = account[emailIndex]
                if let index = emailToIndex[email] {
                    uf.union(index, i)
                } else {
                    emailToIndex[email] = i
                }
            }
        }
        
        var IntToMergedAccounts = [Int: [String]]()
        for email in emailToIndex.keys {
            let root = uf.findRoot(emailToIndex[email]!)
            IntToMergedAccounts[root, default: []].append(email)
        }
        
        var res = [[String]]()
        for (i, emails) in IntToMergedAccounts {
            let contents = [accounts[i][0]] + emails.sorted()
            res.append(contents)
        }
        
        return res
    }
    
    struct DSU {
        typealias Node = Int
        private var parent: [Node]
        private var rank: [Int]
        
        init(_ n: Int) {
            self.parent = Array(0..<n)
            self.rank = [Int](repeating: 1, count: n)
        }
        
        mutating func findRoot(_ node: Node) -> Node {
            var res = node
            while res != parent[res] {
                parent[res] = parent[parent[res]]
                res = parent[res]
            }
            return res
        }
        
        mutating func union(_ node1: Node, _ node2: Node) {
            let root1 = findRoot(node1)
            let root2 = findRoot(node2)
            
            if root1 == root2 {
                return
            }
            
            if rank[root2] > rank[root1] {
                parent[root1] = root2
                rank[root2] += rank[root1]
            } else {
                parent[root2] = root1
                rank[root1] += rank[root2]
            }
        }
    }
}

class NumberOfIslandsUF {
    func callAsFunction(_ grid: [[Character]]) -> Int {
        let m = grid.count, n = grid[0].count
        
        var uf = DSU(m * n)
        
        for row in 0..<m {
            for col in 0..<n {
                
                if grid[row][col] == Character("0") {
                    uf.reduceGroupByOne()
                    continue
                }
                
                let currentIndex = row*n + col
                if (row + 1) < m && grid[row+1][col] == Character("1")  {
                    uf.union(currentIndex, currentIndex + n)
                }
                
                if (col + 1) < n && grid[row][col+1] == Character("1") {
                    uf.union(currentIndex, currentIndex + 1)
                }
            }
        }
        
        return uf.numberOfGroups
    }
    
    struct DSU {
        typealias Node = Int
        
        private var parent: [Node]
        private var rank: [Int]
        private(set) var numberOfGroups: Int
        
        init(_ n: Int) {
            parent = Array(0..<n)
            rank = [Int](repeating: 1, count: n)
            numberOfGroups = n
        }
        
        mutating func reduceGroupByOne() {
            numberOfGroups -= 1
        }
        
        mutating private func findRoot(_ node: Node) -> Node {
            var res = node
            while res != parent[res] {
                parent[res] = parent[parent[res]]
                res = parent[res]
            }
            return res
        }
        
        mutating func union(_ node1: Node, _ node2: Node) {
            let root1 = findRoot(node1)
            let root2 = findRoot(node2)
            
            if root2 == root1 {
                return
            }
            
            if rank[root2] > rank[root1] {
                parent[root1] = root2
                rank[root2] += rank[root1]
            } else {
                parent[root2] = root1
                rank[root1] += rank[root2]
            }
            numberOfGroups -= 1
        }
    }
}

class SatisfiabilityOfEqualityEquations {
    func callAsFunction(_ equations: [String]) -> Bool {
        var uf = DSU(26)
        
        for equation in equations {
            let equationArr = Array(equation)
            let firstVal = Int(equationArr[0].asciiValue! - Character("a").asciiValue!)
            let secondVal = Int(equationArr[3].asciiValue! - Character("a").asciiValue!)
            
            if equationArr[1] == "=" {
                uf.union(firstVal, secondVal)
            }
        }
        
        for equation in equations {
            let equationArr = Array(equation)
            let firstVal = Int(equationArr[0].asciiValue! - Character("a").asciiValue!)
            let secondVal = Int(equationArr[3].asciiValue! - Character("a").asciiValue!)
            
            if equationArr[1] == "!" {
                let firstRoot = uf.findRoot(firstVal)
                let secondRoot = uf.findRoot(secondVal)
                
                if firstRoot == secondRoot {
                    return false
                }
            }
        }
        
        return true
    }
    
    struct DSU {
        typealias Node = Int
        private var parent: [Node]
        private var rank: [Int]
        
        init(_ n: Int) {
            self.parent = Array(0..<n)
            self.rank = [Int](repeating: 1, count: n)
        }
        
        mutating func findRoot(_ node: Node) -> Node {
            var res = node
            while res != parent[res] {
                parent[res] = parent[parent[res]]
                res = parent[res]
            }
            return res
        }
        
        mutating func union(_ node1: Node, _ node2: Node) {
            let root1 = findRoot(node1)
            let root2 = findRoot(node2)
            
            if root1 == root2 {
                return
            }
            
            if rank[root2] > rank[root1] {
                parent[root1] = root2
                rank[root2] += rank[root1]
            } else {
                parent[root2] = root1
                rank[root1] += rank[root2]
            }
        }
    }
}
