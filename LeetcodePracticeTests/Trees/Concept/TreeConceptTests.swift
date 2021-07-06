//
//  TreeConceptTests.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 21/06/21.
//

import XCTest
@testable import LeetcodePractice

class TreeConceptTests: XCTestCase {

    func testTreeNode() {
        let beverages = TreeNode(value: "Beverages")
        let hot = TreeNode(value: "Hot")
        let cold = TreeNode(value: "Cold")
        let tea = TreeNode(value: "Tea")
        let coffee = TreeNode(value: "Coffee")
        let soda = TreeNode(value: "Soda")
        let milk = TreeNode(value: "Milk")
        
        hot.add(child: tea)
        hot.add(child: coffee)
        
        cold.add(child: soda)
        cold.add(child: milk)
        
        beverages.add(child: hot)
        beverages.add(child: cold)
        
        var storage: [TreeNode<String>] = []
        beverages.depthFirstTraversal {
            storage.append($0)
        }
        
        XCTAssertEqual(storage, [beverages, hot, tea, coffee, cold, soda, milk])
        
        storage = []
        beverages.levelOrderTraversal {
            storage.append($0)
        }
        
        XCTAssertEqual(storage, [beverages, hot, cold, tea, coffee, soda, milk])
        
        XCTAssertEqual(beverages.search("Hot"), hot)
        XCTAssertEqual(beverages.search("Coffee"), coffee)
        XCTAssertEqual(beverages.search("Soda"), soda)
        XCTAssertEqual(beverages.search("Invalid"), nil)
    }
    
    func testBinaryTreeNode() {
        let beverages = BinaryTreeNode(value: "Beverages")
        let hot = BinaryTreeNode(value: "Hot")
        let cold = BinaryTreeNode(value: "Cold")
        let tea = BinaryTreeNode(value: "Tea")
        let coffee = BinaryTreeNode(value: "Coffee")
        let soda = BinaryTreeNode(value: "Soda")
        let milk = BinaryTreeNode(value: "Milk")
        
        hot.left = tea
        hot.right = coffee
        
        cold.left = soda
        cold.right = milk
        
        beverages.left = hot
        beverages.right = cold
        
        var storage: [BinaryTreeNode<String>] = []
        beverages.preOrderTraversal {
            storage.append($0)
        }
        
        XCTAssertEqual(storage, [beverages, hot, tea, coffee, cold, soda, milk])
        
        storage = []
        beverages.inOrderTraversal {
            storage.append($0)
        }
        
        XCTAssertEqual(storage, [tea, hot, coffee, beverages, soda, cold, milk])
        
        storage = []
        beverages.postOrderTraversal {
            storage.append($0)
        }
        
        XCTAssertEqual(storage, [tea, coffee, hot, soda, milk, cold, beverages,])
    }
}
