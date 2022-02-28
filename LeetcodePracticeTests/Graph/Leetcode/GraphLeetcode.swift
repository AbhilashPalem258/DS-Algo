//
//  GraphLeetcode.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 26/07/21.
//

import XCTest
@testable import LeetcodePractice

class GraphLeetcode: XCTestCase {
    func testCourseSchedule() {
        let obj = CourseSchedule()
        XCTAssertEqual(obj.canFinish(2, [[1,0]]), true)
        XCTAssertEqual(obj.canFinish(2, [[1,0],[0,1]]), false)
    }
    
    func testCountSubIslands() {
        let obj = CountSubIslands()
        XCTAssertEqual(obj([[1,1,1,0,0],[0,1,1,1,1],[0,0,0,0,0],[1,0,0,0,0],[1,1,0,1,1]], [[1,1,1,0,0],[0,0,1,1,1],[0,1,0,0,0],[1,0,1,1,0],[0,1,0,1,0]]), 3)
        XCTAssertEqual(obj([[1,0,1,0,1],[1,1,1,1,1],[0,0,0,0,0],[1,1,1,1,1],[1,0,1,0,1]], [[0,0,0,0,0],[1,1,1,1,1],[0,1,0,1,0],[0,1,0,1,0],[1,0,0,0,1]]), 2)
    }
    
    func testAlienDictionary() {
        let obj = AlienDictionary()
        XCTAssertEqual(obj(["wrt","wrf","er","ett","rftt"]), "wertf")
        XCTAssertEqual(obj(["z","x"]), "zx")
    }
    
    func testGraphValidTree() {
        let obj = GraphValidTree()
        XCTAssertEqual(obj(n: 5, edges: [[0, 1], [0, 2], [0, 3], [1, 4]]), true)
        XCTAssertEqual(obj(n: 5, edges: [[0, 1], [1, 2], [2, 3], [1, 3], [1, 4]]), false)
    }
    
    func testMinReorder() {
        let obj = MinReorder()
        XCTAssertEqual(obj(6, [[0,1],[1,3],[2,3],[4,0],[4,5]]), 3)
        XCTAssertEqual(obj(5, [[1,0],[1,2],[3,2],[3,4]]), 2)
        XCTAssertEqual(obj(3, [[1,0],[2,0]]), 0)
    }
    
    func testCheapestFlightsWithinKStops() {
        let obj = CheapestFlightsWithinKStops()
//        XCTAssertEqual(obj.bellmanFord(3, [[0,1,100],[1,2,100],[0,2,500]], 0, 2, 0), 500)
//        XCTAssertEqual(obj.bellmanFord(3, [[0,1,100],[1,2,100],[0,2,500]], 0, 2, 1), 200)
//        
//        XCTAssertEqual(obj.djikstraShortestPath(3, [[0,1,100],[1,2,100],[0,2,500]], 0, 2, 0), 500)
//        XCTAssertEqual(obj.djikstraShortestPath(3, [[0,1,100],[1,2,100],[0,2,500]], 0, 2, 1), 200)
        XCTAssertEqual(obj.djikstraShortestPath(4, [[0,1,1],[0,2,5],[1,2,1],[2,3,1]], 0, 3, 1), 6)
    }
    
    func testNetworkDelayTime() {
        let obj = NetworkDelayTime()
//        XCTAssertEqual(obj.bellmanFord([[1,2,1]], 2, 2), -1)
//        XCTAssertEqual(obj.bellmanFord([[1,2,1],[2,3,2],[1,3,4]], 3, 1), 3)
//        XCTAssertEqual(obj.bellmanFord([[2,1,1],[2,3,1],[3,4,1]], 4, 2), 2)
//
//        XCTAssertEqual(obj.djikstraShortestPath([[1,2,4],[1,3,1],[3,4,1],[4,2,1]], 4, 1), 3)
//        XCTAssertEqual(obj.djikstraShortestPath([[1,2,1]], 2, 2), -1)
//        XCTAssertEqual(obj.djikstraShortestPath([[1,2,1],[2,3,2],[1,3,4]], 3, 1), 3)
//        XCTAssertEqual(obj.djikstraShortestPath([[2,1,1],[2,3,1],[3,4,1]], 4, 2), 2)

        
//        XCTAssertEqual(obj.floydWarshall([[1,2,9],[2,1,6],[1,3,-4],[3,2,5],[2,4,2],[4,3,1]], 4, 3), -1) //Jenny
        XCTAssertEqual(obj.floydWarshall([[2,1,1],[2,3,1],[3,4,1]], 4, 2), 2)
    }
    
    func testPathWithMaxProbability() {
        let obj = PathWithMaxProbability()
        XCTAssertEqual(obj.djikstraShortestPath(3, [[0,1],[1,2],[0,2]],  [0.5,0.5,0.2], 0, 2), 0.25000)
        XCTAssertEqual(obj.djikstraShortestPath(3, [[0,1],[1,2],[0,2]],  [0.5,0.5,0.3], 0, 2), 0.3000)
        XCTAssertEqual(obj.djikstraShortestPath(3, [[0,1]],  [0.5], 0, 2), 0.0000)

        XCTAssertEqual(obj.bfs(3, [[0,1],[1,2],[0,2]],  [0.5,0.5,0.2], 0, 2), 0.25000)
        XCTAssertEqual(obj.bfs(3, [[0,1],[1,2],[0,2]],  [0.5,0.5,0.3], 0, 2), 0.3000)
        XCTAssertEqual(obj.bfs(3, [[0,1]],  [0.5], 0, 2), 0.0000)
        
        XCTAssertEqual(obj.bellmanford(3, [[0,1],[1,2],[0,2]],  [0.5,0.5,0.2], 0, 2), 0.25000)
        XCTAssertEqual(obj.bellmanford(3, [[0,1],[1,2],[0,2]],  [0.5,0.5,0.3], 0, 2), 0.3000)
        XCTAssertEqual(obj.bellmanford(3, [[0,1]],  [0.5], 0, 2), 0.0000)
    }
    
    func testPathWithMinimumEffort() {
        let obj = PathWithMinimumEffort()
//        XCTAssertEqual(obj.djikstraShortestPath([[1,2,2],[3,8,2],[5,3,5]]), 2)
//        XCTAssertEqual(obj.djikstraShortestPath([[1,2,3],[3,8,4],[5,3,5]]), 1)
//        XCTAssertEqual(obj.djikstraShortestPath([[1,2,1,1,1],[1,2,1,2,1],[1,2,1,2,1],[1,2,1,2,1],[1,1,1,2,1]]), 0)
        
        XCTAssertEqual(obj.djikstraShortestPathWithVisitedSet([[1,2,2],[3,8,2],[5,3,5]]), 2)
        XCTAssertEqual(obj.djikstraShortestPathWithVisitedSet([[1,2,3],[3,8,4],[5,3,5]]), 1)
        XCTAssertEqual(obj.djikstraShortestPathWithVisitedSet([[1,2,1,1,1],[1,2,1,2,1],[1,2,1,2,1],[1,2,1,2,1],[1,1,1,2,1]]), 0)
    }
    
    func testPathWithMaximumMinimumValue() {
        let obj = PathWithMaximumMinimumValue()
        XCTAssertEqual(obj.djikstraShortestPath([[5,4,5],[1,2,6],[7,4,6]]), 4)
        XCTAssertEqual(obj.djikstraShortestPath([[2,2,1,2,2,2],[1,2,2,2,1,2]]), 2)
        XCTAssertEqual(obj.djikstraShortestPath([[3,4,6,3,4],[0,2,1,1,7],[8,8,3,2,7],[3,2,4,9,8],[4,1,2,0,0],[4,6,5,4,3]]), 3)
    }
    
    func testFindTheCityWithSmallestNumberOfNeighboursAtAThresholdDistance() {
        let obj = FindTheCityWithSmallestNumberOfNeighboursAtAThresholdDistance()
        XCTAssertEqual(obj.floydWarshall(4, [[0,1,3],[1,2,1],[1,3,4],[2,3,1]], 4), 3)
        XCTAssertEqual(obj.floydWarshall(5, [[0,1,2],[0,4,8],[1,2,3],[1,4,2],[2,3,1],[3,4,1]], 2), 0)
    }
    
    func testMinCostConnectPointsPrim() {
        let obj = MinCostConnectPointsPrim()
        XCTAssertEqual(obj.prims([[0,0],[2,2],[3,10],[5,2],[7,0]]), 20)
    }
    
    func testConnectingCitiesWithMinimumCost() {
        let obj = ConnectingCitiesWithMinimumCost()
        XCTAssertEqual(obj.prims(3,  [[1,2,5],[1,3,6],[2,3,1]]), 6)
        XCTAssertEqual(obj.prims(4,  [[1,2,3],[3,4,4]]), -1)
    }
    
    func testCriticalConnectionsInANetwork() {
        let obj = CriticalConnectionsInANetwork()
        XCTAssertEqual(obj.criticalConnections(4, [[0,1],[1,2],[2,0],[1,3]]), [[1,3]])
        XCTAssertEqual(obj.criticalConnections(2, [[0,1]]), [[0,1]])
    }
    
    func testJennyLectures() {
        let obj = JennyLectures()
        XCTAssertEqual(obj.djikstraShortestPath([[0,1,4], [0,4,8], [1,4,11], [1,2,8],[4,8,7],[4,5,1],[2,8,2],[5,8,6],[2,3,7],[2,6,4],[5,6,2],[3,6,14],[3,7,9],[7,6,10]], start: 0, end: 8, n: 9), 14)
    }
}
