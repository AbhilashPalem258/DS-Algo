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
