//
//  LL146.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 18/06/21.
//

import Foundation

final class LFUCache {
    private typealias KeyValueTable = [Int: ValueNode]
    private var keyValueTable: KeyValueTable
    private var capacity: Int
    private var keySize: Int = 0
    private var lfuCountNode = CountNode(count: 1, prev: nil, next: nil)

    init(_ capacity: Int) {
        self.capacity = capacity
        self.keyValueTable = KeyValueTable(minimumCapacity: capacity)
    }
    
    func get(_ key: Int) -> Int {
        if let valueNode = keyValueTable[key] {
            updateFrequency(with: valueNode)
            
            return valueNode.value
        }
        return -1
    }
    
    func put(_ key: Int, _ value: Int) {
        guard capacity > 0 else { return }
        if let valueNode = keyValueTable[key] {
            valueNode.value = value
            updateFrequency(with: valueNode)
        } else {
            if keySize == capacity {
                compaction()
            } else {
                self.keySize += 1
            }
            
            if lfuCountNode.count > 1 {
                let newLfuCountNode = CountNode(count: 1, prev: nil, next: lfuCountNode)
                self.lfuCountNode.prev = newLfuCountNode
                self.lfuCountNode = newLfuCountNode
            }
            let valueNode = lfuCountNode.append(value, for: key)
            keyValueTable[key] = valueNode
        }
    }
    
    private func updateFrequency(with valueNode: ValueNode) {
        valueNode.incrementCount()
        if lfuCountNode.isEmpty {
            self.lfuCountNode = lfuCountNode.next ?? CountNode(count: 1, prev: nil, next: nil)
        }
    }
    
    private func compaction() {
        guard let evicted = lfuCountNode.pop() else {
            assertionFailure()
            return
        }
        //assert(evicted.countNode === lfuCountNode)
        if lfuCountNode.isEmpty {
            self.lfuCountNode = lfuCountNode.next ?? CountNode(count: 1, prev: nil, next: nil)
        }
        keyValueTable.removeValue(forKey: evicted.key)
    }
}

private final class ValueNode {
    let key: Int
    var value: Int
    private var countNode: CountNode
    var prev: ValueNode?
    var next: ValueNode?
    
    init(key: Int, value: Int, countNode: CountNode) {
        self.key = key
        self.value = value
        self.countNode = countNode
        self.prev = nil
        self.next = nil
    }

    func incrementCount() {
        // 現在のカウントノードのキューから抜く
        let temp = countNode
        temp.remove(self)
        
        let newCountNode = temp.insertNextCount(with: self)
        self.countNode = newCountNode
        
        if temp.isEmpty {
            temp.rip()
        }
    }
    
    func rip() {
        self.prev?.next = next
        self.next?.prev = prev
    }
}

private final class CountNode {
    let count: Int
    var prev: CountNode?
    var next: CountNode?
    private let queue = Queue()
    
    var isEmpty: Bool {
        queue.isEmpty
    }
    
    init(count: Int, prev: CountNode?, next: CountNode?) {
        self.count = count
        self.prev = prev
        self.next = next
    }
    
    func insertNextCount(with valueNode: ValueNode) -> CountNode {
        if let existingNext = next, existingNext.count == count + 1 {
            existingNext.queue.enqueue(valueNode)
            return existingNext
        } else {
            let newCount = CountNode(count: count + 1,
                                     prev: self,
                                     next: next)
            newCount.queue.enqueue(valueNode)
            self.next?.prev = newCount
            self.next = newCount
            return newCount
        }
    }
    
    func append(_ value: Int, for key: Int) -> ValueNode {
        let newValueNode = ValueNode(key: key, value: value, countNode: self)
        queue.enqueue(newValueNode)
        return newValueNode
    }
    
    func pop() -> ValueNode? {
        queue.dequeue()
    }
    
    func remove(_ valueNode: ValueNode) {
        queue.remove(valueNode)
    }
    
    func rip() {
        self.prev?.next = next
        self.next?.prev = prev
    }
}

private final class Queue {
    var head: ValueNode?
    var tail: ValueNode?
    
    var isEmpty: Bool {
        head == nil
    }
    
    func enqueue(_ node: ValueNode) {
        if let tail = tail {
            tail.next = node
            node.prev = tail
            self.tail = node
        } else {
            self.head = node
            self.tail = node
        }
    }
    
    func dequeue() -> ValueNode? {
        let result = head
        self.head = result?.next
        if self.head == nil {
            self.tail = nil
        }
        return result
    }
    
    func remove(_ valueNode: ValueNode) {
        if valueNode === head {
            if valueNode === tail {
                self.head = nil
                self.tail = nil
            } else {
                valueNode.next?.prev = nil
                self.head = valueNode.next
                //assert(self.head != nil)
            }
        } else {
            if valueNode === tail {
                self.tail = valueNode.prev
                //assert(self.tail != nil)
            } else {
                valueNode.rip()
            }
        }
    }
}
