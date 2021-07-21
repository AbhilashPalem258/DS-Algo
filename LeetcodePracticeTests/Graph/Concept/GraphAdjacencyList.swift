//
//  GraphAdjacencyList.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 18/07/21.
//

import XCTest
@testable import LeetcodePractice

class GraphAdjacencyListTests: XCTestCase {

    func testAdjacencyList() {
        let list = GraphAdjacencyList<String>()
        
        let vertexA = list.createVertex("A")
        let vertexB = list.createVertex("B")
        let vertexC = list.createVertex("C")
        let vertexD = list.createVertex("D")
        let vertexE = list.createVertex("E")

        list.addDirectedEdge(from: vertexA, to: vertexB, weight: 5.6)
        list.addDirectedEdge(from: vertexA, to: vertexC, weight: 1.0)
        list.addDirectedEdge(from: vertexA, to: vertexD, weight: 4.2)
        
        list.addDirectedEdge(from: vertexB, to: vertexC, weight: 2.7)
        
        list.addDirectedEdge(from: vertexC, to: vertexA, weight: 1.0)
        list.addDirectedEdge(from: vertexC, to: vertexB, weight: 2.7)
        
        list.addDirectedEdge(from: vertexE, to: vertexB, weight: -3.0)

        XCTAssertEqual(list.BFS(), ["A", "B", "C", "D"])
        
        let list1 = GraphAdjacencyList<String>()
        
        let vertexa = list1.createVertex("a")
        let vertexb = list1.createVertex("b")
        let vertexc = list1.createVertex("c")
        let vertexd = list1.createVertex("d")
        let vertexe = list1.createVertex("e")
        let vertexf = list1.createVertex("f")
        let vertexg = list1.createVertex("g")
        let vertexh = list1.createVertex("h")
        
        list1.addDirectedEdge(from: vertexa, to: vertexb)
        list1.addDirectedEdge(from: vertexa, to: vertexc)
        list1.addDirectedEdge(from: vertexb, to: vertexd)
        list1.addDirectedEdge(from: vertexb, to: vertexe)
        list1.addDirectedEdge(from: vertexc, to: vertexf)
        list1.addDirectedEdge(from: vertexc, to: vertexg)
        list1.addDirectedEdge(from: vertexe, to: vertexh)
        list1.addDirectedEdge(from: vertexe, to: vertexf)
        list1.addDirectedEdge(from: vertexf, to: vertexg)
        
        XCTAssertEqual(list1.BFS(), ["a", "b", "c", "d", "e", "f", "g", "h"])
    }
    
    func testDFS() {
        let list1 = GraphAdjacencyList<String>()
        
        let vertexa = list1.createVertex("a")
        let vertexb = list1.createVertex("b")
        let vertexc = list1.createVertex("c")
        let vertexd = list1.createVertex("d")
        let vertexe = list1.createVertex("e")
        let vertexf = list1.createVertex("f")
        let vertexg = list1.createVertex("g")
        let vertexh = list1.createVertex("h")
        
        list1.addDirectedEdge(from: vertexa, to: vertexb)
        list1.addDirectedEdge(from: vertexa, to: vertexc)
        list1.addDirectedEdge(from: vertexb, to: vertexd)
        list1.addDirectedEdge(from: vertexb, to: vertexe)
        list1.addDirectedEdge(from: vertexc, to: vertexf)
        list1.addDirectedEdge(from: vertexc, to: vertexg)
        list1.addDirectedEdge(from: vertexe, to: vertexh)
        list1.addDirectedEdge(from: vertexe, to: vertexf)
        list1.addDirectedEdge(from: vertexf, to: vertexg)
        
        XCTAssertEqual(list1.DFS(source: vertexa), ["a", "b", "d", "e", "h", "f", "g", "c"])
    }

}
