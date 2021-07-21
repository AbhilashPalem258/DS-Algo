//
//  AdjacencyList.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 18/07/21.
//

import Foundation

class Vertex<T: Equatable> {
    let data: T
    let index: Int
    var isVisited = false
    
    init(_ val: T, index: Int) {
        self.data = val
        self.index = index
    }
}
extension Vertex: Equatable {
    static func == (lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
        lhs.data == rhs.data && lhs.index == rhs.index
    }
}

struct Edge<T: Equatable> {
    let from: Vertex<T>
    let to: Vertex<T>
    
    let weight: Double?
}

class EdgeList<T: Equatable> {
    
    let vertex: Vertex<T>
    private(set) var edges: [Edge<T>]?
    
    init(_ vertex: Vertex<T>) {
        self.vertex = vertex
    }
    
    func addEdge(_ edge: Edge<T>) {
        if edge.from.data == vertex.data {
            if  edges == nil {
                edges = [edge]
            } else {
                edges?.append(edge)
            }
        }
    }
    
}

class GraphAdjacencyList<T: Equatable> {
    
    private var adjacencyList: [EdgeList<T>] = []
    
    var edges: [Edge<T>] {
        var allEdges: [Edge<T>] = []
        for edgelist in adjacencyList {
            guard let edges = edgelist.edges else {
                continue
            }
            
            for edge in edges {
                allEdges.append(edge)
            }
        }
        return allEdges
    }
    
    var vertices: [Vertex<T>] {
        var allVertices = [Vertex<T>]()
        for edgeList in adjacencyList {
            allVertices.append(edgeList.vertex)
        }
        return allVertices
    }
    
    func createVertex(_ data: T) -> Vertex<T> {
        for list in adjacencyList where list.vertex.data == data {
            return list.vertex
        }
        
        let vertex = Vertex.init(data, index: adjacencyList.count)
        adjacencyList.append(.init(vertex))
        return vertex
    }
    
    func addDirectedEdge(from: Vertex<T>, to: Vertex<T>, weight: Double? = nil) {
        let list = adjacencyList[from.index]
        list.addEdge(.init(from: from, to: to, weight: weight))
    }
    
    func addUnDirectedEdge(from: Vertex<T>, to: Vertex<T>, weight: Double?) {
        addDirectedEdge(from: from, to: to, weight: weight)
        addDirectedEdge(from: to, to: from, weight: weight)
    }
    
    func weightFrom(from: Vertex<T>, to: Vertex<T>) -> Double? {
        let list = adjacencyList[from.index]
        for edge in list.edges ?? [] {
            if edge.to == to {
                return edge.weight
            }
        }
        return nil
    }
    
    func edgesFrom(from: Vertex<T>) -> [Edge<T>] {
        adjacencyList[from.index].edges ?? []
    }
    
    func BFS() -> [T] {
        guard let source = adjacencyList.first?.vertex else {
            return []
        }
        var result = [source.data]
        var queue = [source]
        source.isVisited = true
        
        while !queue.isEmpty {
            let vertex = queue.removeFirst()
            let list = adjacencyList[vertex.index]
            
            for edge in list.edges ?? [] {
                let neighbour = edge.to
                if !neighbour.isVisited {
                    result.append(neighbour.data)
                    queue.append(neighbour)
                    neighbour.isVisited = true
                }
            }
        }
        return result
    }
    
    func DFS(source: Vertex<T>) -> [T] {
        var source = source, result = [source.data]
        source.isVisited = true
        
        let list = adjacencyList[source.index]
        for edge in list.edges ?? [] {
            let neighbour = edge.to
            if !neighbour.isVisited {
                result += DFS(source: neighbour)
            }
        }
        
        return result
    }
    
}
extension GraphAdjacencyList: CustomDebugStringConvertible {
    var debugDescription: String {
        var rows = [String]()
        for list in adjacencyList {
            var row = ""
            for edge in list.edges ?? [] {
                if edge.weight != nil {
                    row += "(\(edge.to.data): \(edge.weight!))"
                }
            }
            rows.append("\(list.vertex.data) --> \(row)")
        }
        return rows.joined(separator: "\n")
    }
}
