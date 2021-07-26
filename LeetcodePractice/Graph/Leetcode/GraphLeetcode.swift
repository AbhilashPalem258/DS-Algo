//
//  GraphLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 26/07/21.
//

import Foundation

/*
 link: https://leetcode.com/problems/course-schedule/
 explanation: https://www.youtube.com/watch?v=EgI5nU9etnU
 primary idea:
    - create Adj list, map from course to its prerequisite courses
    - perform classic DFS on Adj list
    - once we get to know that specific course is completable, mark it's adj list value as empty which helps reduce redundant operations #44
    - Given prerequites may contain un connected graphs, better to loops through evey course so that we don miss any course #67
 */
class CourseSchedule {
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        var adjList = [Int: [Int]](), visited = Set<Int>()
        func createAdjList() {
            for prerequite in prerequisites {
                adjList[prerequite.first!, default: []].append(prerequite.last!)
            }
        }
        createAdjList()
        
        func dfs(_ course: Int) -> Bool {
            if visited.contains(course) {
                return false
            }
            if adjList[course] == [] {
                return true
            }
            
            visited.insert(course)
            for dependency in adjList[course] ?? [] {
                if !dfs(dependency) {
                    return false
                }
            }
            visited.remove(course)
            adjList[course] = []
            return true
        }
        for node in 0..<numCourses {
            if !dfs(node) {
                return false
            }
        }
        return true
    }
}


class CloneGraph {
    public class Node: Hashable {
        public static func == (lhs: CloneGraph.Node, rhs: CloneGraph.Node) -> Bool {
            lhs.val == rhs.val
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(val)
            hasher.combine(neighbors)
        }
        
         public var val: Int
         public var neighbors: [Node?]
         public init(_ val: Int) {
             self.val = val
             self.neighbors = []
         }
     }
    
    func callAsFunction(_ node: Node?) -> Node? {
        guard let node = node else {
             return nil
         }
         var map = [Node: Node]()
         
         func dfs(source: Node) -> Node {
             if let node = map[source] {
                 return node
             }
             
             let clone = Node(source.val)
             map[source] = clone
             
             for neighbour in source.neighbors {
                clone.neighbors.append(dfs(source: neighbour!))
             }
             return clone
         }
         
         return dfs(source: node)
    }
}
