//
//  GraphLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 26/07/21.
//

//https://leetcode.com/discuss/study-guide/1326900/graph-algorithms-problems-to-practice
//https://leetcode.com/discuss/study-guide/655708/graph-for-beginners-problems-pattern-sample-solutions/1241624
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

//https://www.lintcode.com/problem/178/
struct GraphValidTree {
    func callAsFunction(n: Int, edges: [[Int]]) -> Bool {
        typealias Node = Int
        
        var adjList = [Node: [Node]]()
        func createAdjList() {
            for edge in edges {
                adjList[edge[0], default: []].append(edge[1])
                adjList[edge[1], default: []].append(edge[0])
            }
        }
        createAdjList()
        
        var visited = Set<Node>()
        func dfs(_ node: Node, prev: Node) -> Bool {
            if visited.contains(node) {
                return false
            }
            
            visited.insert(node)
            for neighbour in adjList[node] ?? [] {
                if neighbour == prev {
                    continue
                }
                if !dfs(neighbour, prev: node) {
                    return false
                }
            }
            return true
        }

        return dfs(0, prev: -1) && visited.count == n
    }
}

//https://leetcode.com/problems/reorder-routes-to-make-all-paths-lead-to-the-city-zero/
struct MinReorder {
    func callAsFunction(_ n: Int, _ connections: [[Int]]) -> Int {
        
        var edges = Set<[Int]>()
        for connection in connections {
            edges.insert(connection)
        }
        
        var adjList = [Int: [Int]]()
        for connection in connections {
            let from = connection[0], to = connection[1]
            adjList[from, default: []].append(to)
            adjList[to, default: []].append(from)
        }
        
        var visited = Set<Int>(), changes = 0
        visited.insert(0)
        
        func dfs(city: Int) {
            for neighbour in adjList[city] ?? [] {
                if visited.contains(neighbour) {
                    continue
                }
                if !edges.contains([neighbour, city]) {
                    changes += 1
                }
                visited.insert(neighbour)
                dfs(city: neighbour)
            }
        }
        dfs(city: 0)
        return changes
    }
}

//https://leetcode.com/problems/minimum-height-trees/description/
class MinHeightTrees {
    func findMinHeightTrees(_ n: Int, _ edges: [[Int]]) -> [Int] {
        guard n > 1 else {
            return [0]
        }

        guard n > 2 else {
            return [0, 1]
        }

        typealias Node = Int
        var adjList = [Node: Set<Node>]()

        func createAdjList() {
            for edge in edges {
                let from = edge[0], to = edge[1]
                adjList[from, default: .init()].insert(to)
                adjList[to, default: .init()].insert(from)
            }
        }

        createAdjList()

        var leaves = [Node]()
        for node in 0..<n {
            let neighbours = adjList[node]
            if neighbours?.count == 1 {
                leaves.append(node)
            }
        }

        var remaining = n
        while remaining > 2 {
            var newLeaves = [Node]()
            for leaf in leaves {
                for adjNode in adjList[leaf] ?? [] {
                    adjList[adjNode]!.remove(leaf)
                    if adjList[adjNode]!.count == 1 {
                        newLeaves.append(adjNode)
                    }
                }
            }
            remaining -= leaves.count
            leaves = newLeaves
        }
        return leaves
    }
}
