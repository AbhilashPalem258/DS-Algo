//
//  DesignLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 14/07/21.
//

import Foundation
import AppKit

class ShuffleAnArray {

    private let nums: [Int]
    
    init(_ nums: [Int]) {
        self.nums = nums
    }
    
    /** Resets the array to its original configuration and return it. */
    func reset() -> [Int] {
        return nums
    }
    
    /** Returns a random shuffling of the array. */
    func shuffle() -> [Int] {
        var shuffled = nums
        for i in 0..<shuffled.count {
            let randomIndex = Int.random(in: 0..<shuffled.count)
            (shuffled[i], shuffled[randomIndex]) = (shuffled[randomIndex], shuffled[i])
        }
        return shuffled
    }
}

class MyHashMap {

    private var arr: [Int]
    /** Initialize your data structure here. */
    init() {
        arr = [Int]()
    }
    
    /** value will always be non-negative. */
    func put(_ key: Int, _ value: Int) {
        if key >= arr.count {
            arr += Array(repeating: -1, count: key + arr.count + 1)
        }
        arr[key] = value
    }
    
    /** Returns the value to which the specified key is mapped, or -1 if this map contains no mapping for the key */
    func get(_ key: Int) -> Int {
        if key >= arr.count {
            return -1
        }
        return arr[key]
    }
    
    /** Removes the mapping of the specified value key if this map contains a mapping for the key */
    func remove(_ key: Int) {
        if key < arr.count {
            arr[key] = -1
        }
    }
}

/**
 * Question Link: https://leetcode.com/problems/design-tic-tac-toe/
 * Primary idea: Use two arrays and variables for accumulated scroes for
 *               rows, cols, and diagonal rows.
 *               Use their absoluate value to determine the winner.
 * Time Complexity: O(1), Space Complexity: O(n)
 *
 */

class TicTacToe {
    
    private var rows: [Int]
    private var cols: [Int]
    private var diagonal: Int
    private var antidiagonal: Int
    
    private let n: Int

    /** Initialize your data structure here. */
    init(_ n: Int) {
        rows = [Int](repeating: 0, count: n)
        cols = [Int](repeating: 0, count: n)
        diagonal = 0
        antidiagonal = 0
        self.n = n
    }
    
    func move(_ row: Int, _ col: Int, _ player: Int) -> Int {
        let marker = player == 1 ? 1 : -1
        
        rows[row] += marker
        cols[col] += marker
        
        if row == col {
            diagonal += marker
        }
        
        if row + col == n - 1 {
            antidiagonal += marker
        }
        
        if abs(rows[row]) == n || abs(cols[col]) == n || abs(diagonal) == n || abs(antidiagonal) == n {
            return player
        }
        
        return 0
    }
}

//class NestedIterator {
//
//
//    init(_ nestedList: [NestedInteger]) {
//
//    }
//
//    func next() -> Int {
//
//    }
//
//    func hasNext() -> Bool {
//
//    }
//}


class Trie {
    
    class TrieNode {
        var children: [Character: TrieNode] = [:]
        var endOfWord = false
    }

    private var root: TrieNode
    
    /** Initialize your data structure here. */
    init() {
        root = TrieNode()
    }
    
    /** Inserts a word into the trie. */
    func insert(_ word: String) {
        var current = root
        
        for char in word {
            if current.children[char] == nil {
                current.children[char] = TrieNode()
            }
            current = current.children[char]!
        }
        current.endOfWord = true
    }
    
    /** Returns if the word is in the trie. */
    func search(_ word: String) -> Bool {
        var current = root
        for char in word {
            if current.children[char] == nil {
                return false
            }
            current = current.children[char]!
        }
        return current.endOfWord
    }
    
    /** Returns if there is any word in the trie that starts with the given prefix. */
    func startsWith(_ prefix: String) -> Bool {
        var current = root
        for char in prefix {
            if current.children[char] == nil {
                return false
            }
            current = current.children[char]!
        }
        return true
    }
}

class WordDictionary {

    /** Initialize your data structure here. */
    
    private var collection: [Int: Set<String>]
    
    init() {
        collection = [:]
    }
    
    func addWord(_ word: String) {
        collection[word.count, default: Set<String>()].insert(word)
    }
    
    func search(_ word: String) -> Bool {
        guard let collectedWords = collection[word.count] else {
            return false
        }
        if collectedWords.contains(word) {
            return true
        }
        
        let wordChars = Array(word)
        
        for w in collectedWords {
            let wChars = Array(w)
            
            var notEqual = false
            for i in 0..<wordChars.count {
                let p1 = wordChars[i]
                let p2 = wChars[i]
                
                if p1 == "." {
                    continue
                } else if p1 != p2 {
                    notEqual = true
                    break
                }
            }
            if notEqual == false {
                return true
            }
        }
        return false
    }
}

/**
 * Your WordDictionary object will be instantiated and called as such:
 * let obj = WordDictionary()
 * obj.addWord(word)
 * let ret_2: Bool = obj.search(word)
 */


class RandomizedSet {

    private var values: [Int]
    private var hashMap: [Int: Int]
    
    init() {
        values = []
        hashMap = [:]
    }
    
    /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
    func insert(_ val: Int) -> Bool {
        if hashMap[val] != nil {
            return false
        }
        let count = values.count
        values.append(val)
        hashMap[val] = count
        return true
    }
    
    /** Removes a value from the set. Returns true if the set contained the specified element. */
    func remove(_ val: Int) -> Bool {
        guard let pos = hashMap[val] else {
            return false
        }
        let lastVal = values[values.count - 1]
        values[pos] = lastVal
        hashMap[lastVal] = pos
        values.removeLast()
        hashMap[val] = nil
        return true
    }
    
    /** Get a random element from the set. */
    func getRandom() -> Int {
        let randomIndex = Int.random(in: 0..<values.count)
        return values[randomIndex]
    }
}

/**
 * Your RandomizedSet object will be instantiated and called as such:
 * let obj = RandomizedSet()
 * let ret_1: Bool = obj.insert(val)
 * let ret_2: Bool = obj.remove(val)
 * let ret_3: Int = obj.getRandom()
 */

class AllOneNode {
    //Using Set never guarantees of the order, the first element can be anything, use Array instead
    var strs: Set<String>
    var value: Int
    var prev: AllOneNode?
    var next: AllOneNode?
    
    init(_ value: Int) {
        self.value = value
        strs = []
    }
}

class AllOne {
    private var dict: [String: AllOneNode]
    private let head: AllOneNode
    private let tail: AllOneNode
    
    init() {
        dict = [:]
        head = AllOneNode(0)
        tail = AllOneNode(0)
        head.next = tail
        tail.prev = head
    }
    
    func inc(_ str: String) {
        if let currentNode = dict[str] {
            currentNode.strs.remove(str)
            self.addToNext(currentNode, val: 1 + currentNode.value, str: str)
            codeCleanupFornode(currentNode)
        } else {
            addToNext(head, val: 1, str: str)
        }
    }
    
    func dec(_ key: String) {
        if let currentNode = dict[key] {
            currentNode.strs.remove(key)
            let val = currentNode.value - 1
            if val == 0 {
                dict[key] = nil
            } else {
                moveToPrev(currentNode, val: val, str: key)
            }
            codeCleanupFornode(currentNode)
        }
    }
    
    func getMaxKey() -> String {
        return tail.prev?.strs.first ?? ""
    }
    
    func getMinKey() -> String {
        return head.next?.strs.first ?? ""
    }
    
    private func addToNext(_ node: AllOneNode, val: Int, str: String) {
        let next = node.next
        if node.next?.value != val {
            
            let newNode = AllOneNode(val)
            newNode.prev = node
            newNode.next = next
            next?.prev = newNode
            node.next = newNode
            
            dict[str] = newNode
            newNode.strs.insert(str)
        } else {
            dict[str] = next
            next?.strs.insert(str)
        }
    }
    
    private func moveToPrev(_ node: AllOneNode, val: Int, str: String) {
        let prev = node.prev
        if prev?.value != val {
            let newNode = AllOneNode(val)
            (newNode.prev, newNode.next) = (prev, node)
            prev?.next = newNode
            node.prev = newNode
            
            dict[str] = newNode
            newNode.strs.insert(str)
        } else {
            dict[str] = prev
            prev?.strs.insert(str)
        }
    }
    
    private func codeCleanupFornode(_ node: AllOneNode) {
        if node.strs.count == 0 {
            (node.prev!.next, node.next!.prev) = (node.next, node.prev)
        }
    }
}

/*
 link: https://www.lintcode.com/problem/601/
 */
class Vector2D {
    
    private let arr: [[Int]]
    private var arrId: Int
    private var elementid: Int
    
    init(_ v: [[Int]]) {
        self.arr = v
        arrId = 0
        elementid = 0
    }
    
    func next() -> Int {
        if hasNext() {
            let element =  arr[arrId][elementid]
            elementid += 1
            return element
        }
        return -1
    }
    
    func hasNext() -> Bool {
        findNext()
        
        return arrId < arr.count
    }
    
    private func findNext() {
        while arrId < arr.count {
            if elementid < arr[arrId].count {
                return
            } else {
                arrId += 1
                elementid = 0
            }
        }
    }
    
}
