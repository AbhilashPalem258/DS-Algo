//
//  TriesLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 05/04/22.
//

import Foundation

//https://leetcode.com/problems/implement-trie-prefix-tree/
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

//https://leetcode.com/problems/design-add-and-search-words-data-structure/
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

class WordSearchII {
    class TrieNode {
        var children: [Character: TrieNode] = [:]
        var isWord: Bool = false
        
        init() {}
        
        func addWord(_ word: String) {
            var cur = self
            for char in word {
                if cur.children[char] == nil {
                    cur.children[char] = TrieNode()
                }
                cur = cur.children[char]!
            }
            cur.isWord = true
        }
    }
    
    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        let m = board.count, n = board[0].count
        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        
        let trie = TrieNode()
        for word in words {
            trie.addWord(word)
        }
        
        var res = Set<String>(), visited = Set<Coordinate>()
        
        func dfs(coord: Coordinate, node: TrieNode, word: String) {
            if coord.row < 0 || coord.row == m || coord.col < 0 || coord.col == n || visited.contains(coord) || node.children[ board[coord.row][coord.col]] == nil {
                return
            }
            
            visited.insert(coord)
            let word = word + "\(board[coord.row][coord.col])"
            let node = node.children[board[coord.row][coord.col]]!
            if node.isWord {
                res.insert(word)
            }
            for direction in directions {
                let nRow = coord.row + direction.0
                let nCol = coord.col + direction.1
                
                dfs(coord: Coordinate(row: nRow, col: nCol), node: node, word: word)
            }
            visited.remove(coord)
        }
        
        for row in 0..<m {
            for col in 0..<n where trie.children[board[row][col]] != nil  {
                dfs(coord: Coordinate(row: row, col: col), node: trie, word: "")
            }
        }
        return Array(res)
    }
    
    struct Coordinate: Hashable {
        let row: Int
        let col: Int
    }
}
