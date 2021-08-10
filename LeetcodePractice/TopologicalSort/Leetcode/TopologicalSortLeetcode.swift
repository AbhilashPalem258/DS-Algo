//
//  TopologicalSortLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 28/07/21.
//

import Foundation

struct CourseScheduleII {
    func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        
        typealias Node = Int
        
        var adjList = [Node: [Node]]()
        
        func createAdjList() {
            for preq in prerequisites {
                adjList[preq[0], default: []].append(preq[1])
            }
        }
        
        createAdjList()
        
        var visited = Set<Node>(), cycle = Set<Node>(), result = [Node]()
        func dfs(_ node: Node) -> Bool {
            if cycle.contains(node) {
                return true
            }
            if visited.contains(node) {
                return false
            }
            cycle.insert(node)
            for neighbour in adjList[node] ?? [] {
                if dfs(neighbour) {
                    return true
                }
            }
            cycle.remove(node)
            visited.insert(node)
            result.append(node)
            return false
        }
        
        for node in 0..<numCourses {
            if dfs(node) {
                return []
            }
        }
        return result
    }
    
    func findOrderWithMemoryOptimization(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        
        typealias Node = Int
        
        var adjList = [Node: [Node]]()
        
        func createAdjList() {
            for preq in prerequisites {
                adjList[preq[0], default: []].append(preq[1])
            }
        }
        
        createAdjList()
        
        var visited = [Node: Bool](), result = [Node]()
        // False: Visited, True: Visited && In current Path
        func dfs(_ node: Node) -> Bool {
            if let val = visited[node] {
                return val
            }

            visited[node] = true
            for neighbour in adjList[node] ?? [] {
                if dfs(neighbour) {
                    return true
                }
            }
            visited[node] = false

            result.append(node)
            return false
        }
        
        for node in 0..<numCourses {
            if dfs(node) {
                return []
            }
        }
        return result
    }
}
