//
//  BellmanFordGraph.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 28/01/22.
//

import Foundation

class JennyLectures {
    func djikstraShortestPath(_ edges: [[Int]], start: Int, end: Int, n: Int) -> Int {
        typealias Node = Int
        typealias Weight = Int
        
        var adjacencyList = [Node: [(to: Node, val: Weight)]]()
        for edge in edges {
            adjacencyList[edge[0], default: []].append((edge[1], edge[2]))
            adjacencyList[edge[1], default: []].append((edge[0], edge[2]))
        }
        
        var distances = [Int](repeating: Int.max, count: n)
        distances[start] = 0
        
        var visited = Set<Int>()
        var minHeap = RHeap<(node: Node, val: Weight)>(array: [(start, 0)], sort: {$0.val<$1.val})
        
        while visited.count < n && !minHeap.isEmpty {
            let (node, val) = minHeap.remove()!
            if visited.contains(node) {
                continue
            }
            visited.insert(node)
//            if node == end {
//                return val
//            }
            
            for (neighbourNode, neighbourWeight) in adjacencyList[node] ?? [] {
                let newDistance = val + neighbourWeight
                if !visited.contains(neighbourNode) && newDistance < distances[neighbourNode] {
                    distances[neighbourNode] = newDistance
                    minHeap.insert((neighbourNode, newDistance))
                }
            }
        }
//        return -1
        return visited.count == n ? distances[end] : -1
    }
}

class CheapestFlightsWithinKStops {
    func bellmanFord(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ k: Int) -> Int {
        var prices = [Int](repeating: Int.max, count: n)
        prices[src] = 0
        
        for _ in 0..<k+1 {
            var temp = prices
            for flight in flights {
                let from = flight[0]
                if prices[from] == Int.max {
                    continue
                }
                
                let to = flight[1]
                let price = flight[2]
                
                if (prices[from] + price) < temp[to] {
                    temp[to] = prices[from] + price
                }
            }
            prices = temp
        }
        return prices[dst] == Int.max ? -1 : prices[dst]
    }
    //TLE
    // Djikstra will not work when a restriction such as k stops(minimum number of BFS levels). For shortest path, there will be many stops between src and destination and all nodes will be visited. If we remove visited set there can be chance of never ending loop as a node can be directed to someother node which is already processed and it goes on.
    func djikstraShortestPath(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ k: Int) -> Int {
        typealias City = Int
        typealias Cost = Int
        
        var adjacencyList = [City: [(neighbour: City, cost: Cost)]]()
        for flight in flights {
            adjacencyList[flight[0], default: []].append((flight[1], flight[2]))
        }
        
        var minHeap = RHeap<(city: City, cost: Cost, stops: Int)>(array: [(src, 0, -1)], sort: {$0.cost<$1.cost})
        
        while !minHeap.isEmpty {
            let currentCity = minHeap.remove()!
            if currentCity.stops > k {
                continue
            }
            if dst == currentCity.city {
                return currentCity.cost
            }
            
            for (neighbourCity, neighbourCost) in adjacencyList[currentCity.city] ?? [] {
                minHeap.insert((neighbourCity, currentCity.cost + neighbourCost, currentCity.stops + 1))
            }
        }
        return -1
    }
}

class NetworkDelayTime {
    func bellmanFord(_ times: [[Int]], _ n: Int, _ k: Int) -> Int {
        var distances = [Int](repeating: Int.max, count: n+1)
        distances[k] = 0
        
        for _ in 0..<n {
            var temp = distances
            for time in times {
                let from = time[0]
                if distances[from] == Int.max {
                    continue
                }
                
                let to = time[1]
                let time = time[2]
                
                if (distances[from] + time) < temp[to] {
                    temp[to] = distances[from] + time
                }
            }
            distances = temp
        }
        
        var res = 0
        for i in 1..<distances.count {
            res = max(res, distances[i])
        }
        return res == Int.max ? -1 : res
    }
    
    func djikstraShortestPath(_ times: [[Int]], _ n: Int, _ k: Int) -> Int {
        var adjacencyList = [Int: [(node: Int, weight: Int)]]()
        for time in times {
            adjacencyList[time[0], default: []].append((time[1], time[2]))
        }
        
        let minHeap = Heap([(0, k)], orderCriteria: { $0.0 < $1.0 })
        var visited = Set<Int>()
        var t = 0
        
        while !minHeap.isEmpty {
            let (currentW, currentN) = minHeap.remove()!
            if visited.contains(currentN) {
                continue
            }
            visited.insert(currentN)
            t = max(t, currentW)
            
            for (neighbourN, neighbourW) in adjacencyList[currentN] ?? [] {
                if !visited.contains(neighbourN) {
                    minHeap.insert((neighbourW + currentW, neighbourN))
                }
            }
        }
        return visited.count == n ? t : -1
    }
    
    func floydWarshall(_ times: [[Int]], _ n: Int, _ k: Int) -> Int {
        var d = [[Int]](repeating: [Int](repeating: Int.max, count: n), count: n)
        for time in times {
            d[time[0] - 1][time[1] - 1] = time[2]
        }
        for row in 0..<n {
            d[row][row] = 0
        }
        
        for k in 0..<n {
            for row in 0..<n {
                for col in 0..<n {
                    if ![d[row][k], d[k][col]].contains(Int.max){
                        d[row][col] = min(d[row][col], d[row][k] + d[k][col])
                    }
                }
            }
        }
        var res = Int.min
        for i in 0..<n {
            if d[k-1][i] == Int.max {
                return -1
            }
            res = max(res, d[k-1][i])
        }
        return res
    }
}

class PathWithMaxProbability {
    func djikstraShortestPath(_ n: Int, _ edges: [[Int]], _ succProb: [Double], _ start: Int, _ end: Int) -> Double {
        var adjacencyList = [Int: [(toNode: Int, weight: Double)]]()
        for i in 0..<edges.count {
            let edge = edges[i]
            adjacencyList[edge[0], default: []].append((edge[1], succProb[i]))
            adjacencyList[edge[1], default: []].append((edge[0], succProb[i]))
        }
        
        let maxHeap = Heap([(1.0, start)], orderCriteria: {$0.0 > $1.0})
        var visited = Set<Int>()
        var probs = [Int: Double]()
        for i in 0..<n {
            probs[i] = 0.0
        }
        probs[start]=1.0
        
        while !maxHeap.isEmpty {
            let (currentW, currentN) = maxHeap.remove()!
            if visited.contains(currentN) {
                continue
            }
            visited.insert(currentN)
            if currentN == end {
                return currentW
            }
            
            for (neighbourN, neighbourW) in adjacencyList[currentN] ?? [] {
                let newProb = currentW * neighbourW
                if !visited.contains(neighbourN) && newProb > probs[neighbourN]!  {
                    probs[neighbourN] = newProb
                    maxHeap.insert((newProb, neighbourN))
                }
            }
        }
        return 0.0
    }
    
    func bfs(_ n: Int, _ edges: [[Int]], _ succProb: [Double], _ start: Int, _ end: Int) -> Double {
        var adjacencyList = [Int: [(node: Int, weight: Double)]]()
        for i in 0..<edges.count {
            let edge = edges[i]
            adjacencyList[edge[0], default: []].append((edge[1], succProb[i]))
            adjacencyList[edge[1], default: []].append((edge[0], succProb[i]))
        }
        
        var stack = [(start, 1.0)]
        var ans = 0.0
        var probs = [Int: Double]()
        for i in 0..<n {
            probs[i] = 0.0
        }
        probs[start] = 1.0
        
        while !stack.isEmpty {
            let level = stack
            stack.removeAll()
            
            for (node, weight) in level {
                if node == end {
                    ans = max(ans, weight)
                }
                for (neighbourN, neighbourProb) in adjacencyList[node] ?? [] {
                    let newProb = weight * neighbourProb
                    if let existingProb = probs[neighbourN], existingProb < newProb {
                        stack.append((neighbourN, newProb))
                        probs[neighbourN] = newProb
                    }
                }
            }
        }
        return ans
    }
    
    //TLE
    func bellmanford(_ n: Int, _ edges: [[Int]], _ succProb: [Double], _ start: Int, _ end: Int) -> Double {
        var probs = [Double](repeating: 0.0, count: n)
        probs[start] = 1.0
        
        for _ in 0..<n {
            var temp = probs
            for i in 0..<edges.count {
                let edge = edges[i]
                let prob = succProb[i]
                
                let calculateProb = { (src: Int, dst: Int) in
                    if probs[src] != 0.0 {
                        let newProb =  prob * temp[src]
                        if probs[dst] < newProb {
                            temp[dst] = newProb
                        }
                    }
                }
                
                calculateProb(edge[0], edge[1])
                calculateProb(edge[1], edge[0])
            }
            probs = temp
        }
        return probs[end]
    }
}

class PathWithMinimumEffort {
    func djikstraShortestPath(_ heights: [[Int]]) -> Int {
        let m = heights.count, n = heights[0].count
        
        var effortsMatrix = [[Int]](repeating: [Int](repeating: Int.max, count: n), count: m)
        var minHeap = RHeap<(dist: Int, row: Int, col: Int)>(array: [(0,0,0)], sort: { $0.dist<$1.dist })
        
        while !minHeap.isEmpty {
            let min = minHeap.remove()!
            let (dist, row, col) = min
            if dist > effortsMatrix[row][col] {
                continue
            }
            if row == m - 1 && col == n - 1 {
                return dist
            }
            
            for (neighbourRow, neighbourCol) in [(row - 1, col), (row + 1, col), (row, col - 1), (row, col + 1)] {
                if !(neighbourRow >= 0 && neighbourRow < m && neighbourCol >= 0 && neighbourCol < n) {
                    continue
                }
                let neighbourDist = max(dist, abs(heights[row][col] - heights[neighbourRow][neighbourCol]))
                if neighbourDist < effortsMatrix[neighbourRow][neighbourCol] {
                    effortsMatrix[neighbourRow][neighbourCol] = neighbourDist
                    minHeap.insert((neighbourDist, neighbourRow, neighbourCol))
                }
            }
        }
        return 0
    }
 
    func djikstraShortestPathWithVisitedSet(_ heights: [[Int]]) -> Int {
        
        struct Cell: Hashable, Equatable {
            let row: Int
            let col: Int
        }
        
        typealias Effort = Int
        
        let m = heights.count, n = heights[0].count
        let dst = Cell(row: m - 1, col: n - 1)
        
        var minHeap = RHeap<(effort: Effort, cell: Cell)>(array: [(0, Cell(row: 0, col: 0))], sort: {$0.effort<$1.effort})
        var visited = Set<Cell>()
        
        while !minHeap.isEmpty {
            let (currentEffort, currentCell) = minHeap.remove()!
            if visited.contains(currentCell) {
                continue
            }
            visited.insert(currentCell)
            if currentCell == dst {
                return currentEffort
            }
            
            for (neighbourRow, neighbourCol) in [(currentCell.row - 1, currentCell.col), (currentCell.row + 1, currentCell.col), (currentCell.row, currentCell.col - 1), (currentCell.row, currentCell.col + 1)] {
                let neighbourCell = Cell(row: neighbourRow, col: neighbourCol)
                if (neighbourRow >= 0 && neighbourRow < m && neighbourCol >= 0 && neighbourCol < n) && !visited.contains(neighbourCell) {
                    let effort = max(currentEffort, abs(heights[currentCell.row][currentCell.col] - heights[neighbourRow][neighbourCol]))
                    minHeap.insert((effort, neighbourCell))
                }
            }
        }
        return 0
    }
}

class PathWithMaximumMinimumValue {
    func djikstraShortestPath(_ a: [[Int]]) -> Int {
        let m = a.count, n = a[0].count
        var maxHeap = RHeap<(val: Int, row: Int, col: Int)>(array: [(a[0][0], 0, 0)], sort: {$0.0>$1.0})
        var visited = Set<[Int]>(arrayLiteral: [0,0])
        
        while !maxHeap.isEmpty {
            let (val, row, col) = maxHeap.remove()!
            if row == m - 1 && col == n - 1 {
                return val
            }
            for (neighbourRow, neighbourCol) in [(row - 1, col), (row + 1, col), (row, col + 1), (row, col - 1)] {
                if neighbourRow >= 0 && neighbourRow < m && neighbourCol >= 0 && neighbourCol < n && !visited.contains([neighbourRow, neighbourCol]) {
                    visited.insert([neighbourRow, neighbourCol])
                    maxHeap.insert((min(val, a[neighbourRow][neighbourCol]), neighbourRow, neighbourCol))
                }
            }
        }
        return -1;
    }
}

class FindTheCityWithSmallestNumberOfNeighboursAtAThresholdDistance {
    func floydWarshall(_ n: Int, _ edges: [[Int]], _ distanceThreshold: Int) -> Int {
        var distance = [[Int]](repeating: [Int](repeating: Int.max, count: n), count: n)
        for row in 0..<n {
            distance[row][row] = 0
        }
        for edge in edges {
            distance[edge[0]][edge[1]] = edge[2]
            distance[edge[1]][edge[0]] = edge[2]
        }
        
        for k in 0..<n {
            for row in 0..<n {
                for col in 0..<n {
                    if ![distance[row][k], distance[k][col]].contains(Int.max) {
                        distance[row][col] = min(distance[row][col], distance[row][k] + distance[k][col])
                    }
                }
            }
        }
        
        var ans = 0
        var min = n - 1
        for city in 0..<n {
            var neighbourCount = 0
            for neighbour in 0..<n {
                if city == neighbour {
                    continue
                }
                if distance[city][neighbour] <= distanceThreshold {
                    neighbourCount += 1
                }
            }
            if neighbourCount <= min {
                ans = city
                min = neighbourCount
            }
        }
        return ans
    }
}
class MinCostConnectPointsPrim {
    func prims(_ points: [[Int]]) -> Int {
        typealias Node = Int
        typealias Weight = Int
        
        var adjacencyList = [Node: [(to: Node, val: Weight)]]()
        for i in 0..<points.count {
            let current = points[i]
            for j in i+1..<points.count {
                let neighbour = points[j]
                let dist = abs(current[0] - neighbour[0]) + abs(current[1] - neighbour[1])
                
                adjacencyList[i, default: []].append((j, dist))
                adjacencyList[j, default: []].append((i, dist))
            }
        }
        
        var res = 0
        var visited = Set<Int>()
        var minHeap = RHeap<(to: Node, val: Weight)>(array: [(0,0)], sort: {$0.val<$1.val})
        
        while visited.count < points.count {
            let (node, val) = minHeap.remove()!
            if visited.contains(node) {
                continue
            }
            res += val
            visited.insert(node)
            
            for (neighbourNode, neighbourVal) in adjacencyList[node] ?? [] {
                if !visited.contains(neighbourNode) {
                    minHeap.insert((neighbourNode, neighbourVal))
                }
            }
            
        }
        return res
    }
}

/*
 problem:
 There are N cities numbered from 1 to N.

 You are given connections, where each connections[i] = [city1, city2, cost] represents the cost to connect city1 and city2 together. (A connection is bidirectional: connecting city1 and city2 is the same as connecting city2 and city1.)

 Return the minimum cost so that for every pair of cities, there exists a path of connections (possibly of length 1) that connects those two cities together. The cost is the sum of the connection costs used. If the task is impossible, return -1.
 
 Testcases:
 Input: N = 3, connections = [[1,2,5],[1,3,6],[2,3,1]]
 Output: 6
 Explanation:
 Choosing any 2 edges will connect all cities so we choose the minimum 2.
 
 Input: N = 4, connections = [[1,2,3],[3,4,4]]
 Output: -1
 Explanation:
 There is no way to connect all cities even if all edges are used.
 
 
 Constraints:
 1 <= N <= 10000
 1 <= connections.length <= 10000
 1 <= connections[i][0], connections[i][1] <= N
 0 <= connections[i][2] <= 10^5
 connections[i][0] != connections[i][1]
 
 
 link: https://code.dennyzhang.com/connecting-cities-with-minimum-cost
 explanation: https://www.youtube.com/watch?v=f7JOBJIC-NA,
 primary idea:
 - Prims Algorithm https://www.youtube.com/watch?v=ZtZaR7EcI5Y
 Time Complexity:
 Space Complexity:
 */
class ConnectingCitiesWithMinimumCost {
    func prims(_ n: Int, _ edges: [[Int]]) -> Int {
        typealias Node = Int
        typealias Weight = Int
        
        var adjacencyList = [Node: [(to: Node, val: Weight)]]()
        for edge in edges {
            adjacencyList[edge[0], default: []].append((edge[1], edge[2]))
            adjacencyList[edge[1], default: []].append((edge[0], edge[2]))
        }
        
        var res = 0
        var minHeap = RHeap<(to: Node, val: Weight)>(array: [(edges[0][0],0)], sort: {$0.val<$1.val})
        var visited = Set<Node>()
        
        while visited.count < n && !minHeap.isEmpty {
            let (node, val) = minHeap.remove()!
            if visited.contains(node) {
                continue
            }
            res += val
            visited.insert(node)
            
            for (neighbourNode, neighbourWeight) in adjacencyList[node] ?? [] {
                if !visited.contains(neighbourNode) {
                    minHeap.insert((neighbourNode, neighbourWeight))
                }
            }
        }
        return visited.count == n ? res : -1
    }
}
