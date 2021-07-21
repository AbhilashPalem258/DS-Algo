//
//  DesignLeetcode.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 14/07/21.
//

import XCTest
@testable import LeetcodePractice

class DesignLeetcode: XCTestCase {
    
    func testTrie() {
        let trie = Trie()
        trie.insert("apple");
        XCTAssertEqual(trie.search("apple"), true);   // return True
        XCTAssertEqual(trie.search("app"), false);     // return False
        XCTAssertEqual(trie.startsWith("app"), true); // return True
        trie.insert("app");
        XCTAssertEqual(trie.search("app"), true);
    }
    
    func testWordDictionary() {
        let obj = WordDictionary()
        obj.addWord("bad")
        obj.addWord("dad")
        obj.addWord("mad")
        XCTAssertEqual(obj.search("pad"), false)
        XCTAssertEqual(obj.search("bad"), true)
        XCTAssertEqual(obj.search(".ad"), true)
        XCTAssertEqual(obj.search("b.."), true)
    }
    
    func testRandomizedSet() {
        let randomizedSet = RandomizedSet()
        XCTAssertEqual(randomizedSet.insert(1), true) // Inserts 1 to the set. Returns true as 1 was inserted successfully.
        XCTAssertEqual(randomizedSet.remove(2), false) // Returns false as 2 does not exist in the set.
        XCTAssertEqual(randomizedSet.insert(2), true) // Inserts 2 to the set, returns true. Set now contains [1,2].
        XCTAssertTrue([1,2].contains(randomizedSet.getRandom())) // getRandom() should return either 1 or 2 randomly.
        XCTAssertEqual(randomizedSet.remove(1), true) // Removes 1 from the set, returns true. Set now contains [2].
        XCTAssertEqual(randomizedSet.insert(2), false) // 2 was already in the set, so return false.
        XCTAssertEqual(randomizedSet.getRandom(), 2) // Since 2 is the only number in the set, getRandom() will always return 2.
    }
    
    func testAllOne() {
        var allOne = AllOne()
        allOne.inc("hello");
        allOne.inc("hello");
        XCTAssertEqual(allOne.getMaxKey(), "hello") // return "hello"
        XCTAssertEqual(allOne.getMinKey(), "hello") // return "hello"
        allOne.inc("leet");
        XCTAssertEqual(allOne.getMaxKey(), "hello") // return "hello"
        XCTAssertEqual(allOne.getMinKey(), "leet");
        
        allOne = AllOne()
        allOne.inc("hello");
        allOne.inc("goodbye");
        allOne.inc("hello");
        allOne.inc("hello");
        XCTAssertEqual(allOne.getMaxKey(), "hello") // return "hello"
        allOne.inc("leet");
        allOne.inc("code");
        allOne.inc("leet");
        allOne.dec("hello");
        allOne.inc("leet");
        allOne.inc("code");
        allOne.inc("code");
        XCTAssertEqual(allOne.getMaxKey(), "leet") // return "leet"
        
        allOne = AllOne()
        allOne.inc("hello");
        allOne.inc("world");
        allOne.inc("hello");
        allOne.dec("world");
        allOne.inc("hello");
        allOne.inc("leet");
        XCTAssertEqual(allOne.getMaxKey(), "hello") // return "hello"
        allOne.dec("hello");
        allOne.dec("hello");
        allOne.dec("hello");
        XCTAssertEqual(allOne.getMaxKey(), "leet") // return "leet"
    }
}
