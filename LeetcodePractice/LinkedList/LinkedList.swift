//
//  LinkedList.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 17/06/21.
//

import Foundation

protocol LinkedListNodeProtocol {
    associatedtype Value
    
    var value: Value {get set}
    var next: Self? {get set}
    var previous: Self? {get set}
}

protocol LinkedListProtocol: ExpressibleByArrayLiteral {
    associatedtype Value where Self.Value == Self.ArrayLiteralElement
    associatedtype Node: LinkedListNodeProtocol where Self.Node.Value == Self.Value
    
    var head: Node? {get set}
    var last: Node? {get}
    var isEmpty: Bool {get}
    var count: Int { get }
    
    subscript(index: Int) -> Value? { get }
        
    func node(at index: Int) -> Node?
    
    func append(_ value: Value)
    func append(_ node: Node)
    func append(_ linkedlist: Self)
    
    func insert(_ value: Value, at index: Int)
    func insert(_ node: Node, at index: Int)
    func insert(_ linkedList: Self, at index: Int)
    
    func removeAll()
    func remove(at index: Int) -> Value?
    func remove(node: Node) -> Value
    
    func reverse()
}

final class LinkedListNode<T>: LinkedListNodeProtocol {
    var value: T
    var next: LinkedListNode<T>?
    var previous: LinkedListNode<T>?
    
    init(_ value: T) {
        self.value = value
    }
}

final class LinkedList<T>: LinkedListProtocol {
    
    typealias Node = LinkedListNode<T>
    
    var head: Node?
    
    var last: Node? {
        guard var currentNode = head else {
            return nil
        }
        while let node = currentNode.next {
            currentNode = node
        }
        return currentNode
    }
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var count: Int {
        var count = 0
        var currentNode = head
        while !currentNode.isNil {
            count += 1
            currentNode = currentNode?.next
        }
        return count
    }
    
    init() {}
    
    subscript(index: Int) -> T? {
        return node(at: index)?.value
    }
    
    func node(at index: Int) -> Node? {
        if index == 0 {
            return head
        } else {
            var currentNode = head
            for _ in 1...index {
                currentNode = currentNode?.next
                if currentNode.isNil {
                    return nil
                }
            }
            return currentNode
        }
    }
    
    func append(_ value: T) {
        let new = Node(value)
        append(new)
    }
    
    func append(_ node: Node) {
        if let lastNode = last {
            lastNode.next = node
            node.previous = lastNode
        } else {
            head = node
        }
    }
    
    func append(_ linkedlist: LinkedList<T>) {
        guard !linkedlist.isEmpty else { return }
        if let last = last {
            linkedlist.head?.previous = last
            last.next = linkedlist.head
        } else {
            head = linkedlist.head
        }
    }
    
    func insert(_ value: T, at index: Int) {
        insert(Node(value), at: index)
    }
    
    func insert(_ node: LinkedListNode<T>, at index: Int) {
        if index == 0 {
            head?.previous = node
            node.next = head
            head = node
        } else if let nodeAtIndex = self.node(at: index) {
            let prev = nodeAtIndex.previous
            nodeAtIndex.previous = node
            prev?.next = node
            node.next = nodeAtIndex
            node.previous = prev
        }
    }
    
    func insert(_ linkedList: LinkedList<T>, at index: Int) {
        guard !linkedList.isEmpty else {
            return
        }
        
        if index == 0 {
            linkedList.last?.next = head
            head?.previous = linkedList.last
            head = linkedList.head
        } else if let nodeAtIndex = node(at: index) {
            let prev = nodeAtIndex.previous
            
            prev?.next = linkedList.head
            linkedList.head?.previous = prev
            linkedList.last?.next = nodeAtIndex
            nodeAtIndex.previous = linkedList.last
        }
    }
    
    func removeAll() {
        self.head = nil
    }
    
    @discardableResult
    func remove(at index: Int) -> T? {
        if let nodeAtIndex = node(at: index) {
            return remove(node: nodeAtIndex)
        }
        return nil
    }

    @discardableResult
    func remove(node: Node) -> T {
        let prev = node.previous
        if prev.isNil {
            head = node.next
        } else {
            prev?.next = node.next
        }
        node.next?.previous = prev
        
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    func reverse() {
        var node = head
        while let currentNode = node {
            node = currentNode.next
            swap(&currentNode.next, &currentNode.previous)
            head = currentNode
        }
    }
}
extension LinkedList: CustomStringConvertible {
    var description: String {
        var s = "["
        var currentNode = head
        while let node = currentNode {
            s.append("\(node.value)")
            currentNode = node.next
            if currentNode != nil {
                s.append(",")
            }
        }
        s.append("]")
        return s
    }
}
extension LinkedList {
    convenience
    init(_ array: [T]) {
        self.init()
        array.forEach { append($0) }
    }
}
extension LinkedList: ExpressibleByArrayLiteral {
    convenience init(arrayLiteral elements: T...) {
        self.init()
        elements.forEach { append($0) }
    }
}

extension LinkedList: Collection {

    typealias Index = LinkedListIndex<T>
    
    var startIndex: Index {
        .init(node: head, tag: 0)
    }
    
    var endIndex: Index {
        .init(node: head, tag: count)
    }
    
    subscript(position: Index) -> T? {
        return position.node?.value
    }
    
    func index(after i: Index) -> Index {
        .init(node: i.node?.next, tag: i.tag + 1)
    }
}

struct LinkedListIndex<T>: Comparable {
    static func == (lhs: LinkedListIndex<T>, rhs: LinkedListIndex<T>) -> Bool {
        lhs.tag == rhs.tag
    }
    
    let node: LinkedListNode<T>?
    let tag: Int
    
    static func < (lhs: LinkedListIndex, rhs: LinkedListIndex) -> Bool {
        lhs.tag < rhs.tag
    }
    
    static func > (lhs: LinkedListIndex, rhs: LinkedListIndex) -> Bool {
        lhs.tag > rhs.tag
    }
}

extension Optional {
    var isNil: Bool {
        return self == nil
    }
}
