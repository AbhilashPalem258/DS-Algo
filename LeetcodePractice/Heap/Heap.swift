//
//  Heap.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 28/07/21.
//

import Foundation

class Heap<T> {
    private var nodes: [T]
    private let orderCriteria: (T, T) -> Bool
    
    init(_ elements: [T], orderCriteria: @escaping (T,T) -> Bool) {
        self.orderCriteria = orderCriteria
        self.nodes = elements
        configureHeap()
    }
    
    init(sort orderCriteria: @escaping (T,T) -> Bool) {
        nodes = []
        self.orderCriteria = orderCriteria
    }
}
extension Heap {
    func configureHeap() {
        var i = nodes.count/2 - 1
        while i >= 0 {
            shiftDown(i)
            i -= 1
        }
    }
    
    func shiftDown(_ index: Int) {
        shiftDown(from: index, until: nodes.count)
    }
    
    func shiftDown(from index: Int, until endIndex: Int) {
        var first = index
        
        let leftChildIndex = leftChildIndex(index)
        if leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex], nodes[index]) {
            first = leftChildIndex
        }
        
        let rightChildIndex = leftChildIndex + 1
        if rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex], nodes[index]) {
            first = rightChildIndex
        }
        
        if first == index { return }
        
        (nodes[index], nodes[first]) = (nodes[first], nodes[index])
        shiftDown(from: first, until: endIndex)
    }
    
    func shiftUp(_ index: Int) {
        var parentIndex = parentOf(index), childIndex = index
        let parent = nodes[parentIndex], child = nodes[childIndex]
        
        while childIndex > 0 && orderCriteria(nodes[childIndex], parent) {
            nodes[childIndex] = nodes[parentIndex]
            childIndex = parentIndex
            parentIndex = parentOf(childIndex)
        }
        
        nodes[childIndex] = child
    }
    
    func insert(_ element: T) {
        nodes.append(element)
        shiftUp(nodes.count - 1)
    }
    
    func insert<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
        for element in sequence {
            insert(element)
        }
    }
    
    func replace(at index: Int, element: T) {
        if index < nodes.count {
            return
        }
        remove(at: index)
        insert(element)
    }
    
    @discardableResult
    func remove() -> T? {
        if nodes.isEmpty {
            return nil
        }
        
        if nodes.count == 1 {
            return nodes.removeLast()
        } else {
            let value = nodes[0]
            nodes[0] = nodes.removeLast()
            shiftDown(0)
            return value
        }
    }
    
    @discardableResult
    func remove(at index: Int) -> T? {
        if !(0..<nodes.count).contains(index) {
            return nil
        }
        
        let size = nodes.count - 1
        if index != size {
            (nodes[index], nodes[size]) = (nodes[size], nodes[index])
            shiftDown(from: index, until: size)
            shiftUp(index)
        }
        return nodes.removeLast()
    }
    
    func leftChildIndex(_ parentIndex: Int) -> Int {
        2*parentIndex + 1
    }
    
    func rightChildIndex(_ parentIndex: Int) -> Int {
        2*parentIndex + 2
    }
    
    func parentOf(_ childIndex: Int) -> Int {
        (childIndex - 1)/2
    }
    
    func peek() -> T? {
        nodes.first
    }
    
    func count() -> Int {
        nodes.count
    }
    
    var isEmpty: Bool {
        nodes.isEmpty
    }
}
extension Heap where T: Equatable {
    //O(n)
    func indexOf(_ node: T) -> Int? {
        nodes.firstIndex(where: { $0 == node })
    }
    
    func remove(node: T) -> T? {
        if let index = indexOf(node) {
            return remove(at: index)
        }
        return nil
    }
}
