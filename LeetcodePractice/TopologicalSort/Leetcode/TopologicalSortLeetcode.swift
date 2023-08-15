//
//  TopologicalSortLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 28/07/21.
//

import Foundation

// https://www.lintcode.com/problem/892/
struct AlienDictionary {
    func callAsFunction(_ wordList: [String]) -> String {
        var adjList = [Character: Set<Character>]()
        
        for i in 0..<wordList.count - 1 {
            let word1 = wordList[i], word2 = wordList[i + 1]
            let minLength = min(word1.count, word2.count)
            if word1.count > word2.count, word1.prefix(minLength) == word2.prefix(minLength) {
                return ""
            }
            for j in 0..<minLength {
                let firstWChar = word1[word1.index(word1.startIndex, offsetBy: j)]
                let secondWChar = word2[word2.index(word2.startIndex, offsetBy: j)]
                if firstWChar != secondWChar {
                    adjList[firstWChar, default: Set()].insert(secondWChar)
                }
            }
        }
        
        var visited = [Character: Bool](), res = [Character]()
        func dfs(_ c: Character) -> Bool {
            if visited[c] != nil {
                return visited[c]!
            }
            visited[c] = true
            for neighbour in adjList[c] ?? [] {
                if dfs(neighbour) {
                    return true
                }
            }
            visited[c] = false
            res.append(c)
            return false
        }
        
        for c in adjList.keys {
            if dfs(c) {
                return ""
            }
        }
        res = res.reversed()
        return String(res)
    }
}

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

    //Preferred
    func findOrderWithMemoryOptimization(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        typealias Course = Int
        var adjacencyList = [Course: Set<Course>]()
        for preq in prerequisites {
            adjacencyList[preq[0], default: Set()].insert(preq[1])
        }
        
        var visited = [Course: Bool]() // False: Visited, True: Visited && IsInPath
        var result = [Course]()
        
        func dfs(_ course: Course) -> Bool {
            if let visit = visited[course] {
                return visit
            }
            visited[course] = true
            for dependentCourse in adjacencyList[course] ?? [] {
                if dfs(dependentCourse) {
                    return true
                }
            }
            visited[course] = false
            result.append(course)
            return false
        }
        
        for course in 0..<numCourses {
            if dfs(course) {
                return []
            }
        }
        
        return result
    }
}

class CourseScheduleTopological {
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        typealias Course = Int
        var adjList = [Course: Set<Int>]()
        for preq in prerequisites {
            adjList[preq[0], default: Set()].insert(preq[1])
        }
        
        var visited = [Course: Bool]() //False: Visited && True: Visited and IsInPath
        
        func dfs(_ course: Course) -> Bool {
            if let visit = visited[course] {
                return visit
            }
            visited[course] = true
            for dependentCourse in adjList[course] ?? [] {
                if dfs(dependentCourse) {
                    return true
                }
            }
            visited[course] = false
            return false
        }
        
        for course in 0..<numCourses {
            if dfs(course) {
                return false
            }
        }
        return true
    }
}
