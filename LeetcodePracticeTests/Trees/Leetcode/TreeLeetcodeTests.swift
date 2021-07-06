//
//  TreeLeetcodeTests.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 21/06/21.
//

import XCTest
@testable import LeetcodePractice

class TreeLeetcodeTests: XCTestCase {

    func testPreorderTraversal() {
        let third = TreeLeetcode.TreeNode(3)
        let second = TreeLeetcode.TreeNode(2, third, nil)
        let first = TreeLeetcode.TreeNode(1, nil, second)
        
        let obj = TreePreorderTraversal()
        XCTAssertEqual(obj(first), [1,2,3])
        XCTAssertEqual(obj(nil), [])
        XCTAssertEqual(obj(TreeLeetcode.TreeNode(1)), [1])
    }
    
    func testTreeInorderTraversal() {
        let third = TreeLeetcode.TreeNode(3)
        let second = TreeLeetcode.TreeNode(2, third, nil)
        let first = TreeLeetcode.TreeNode(1, nil, second)
        
        let obj = TreeInorderTraversal()
        XCTAssertEqual(obj(first), [1,3, 2])
        XCTAssertEqual(obj(nil), [])
        XCTAssertEqual(obj(TreeLeetcode.TreeNode(1)), [1])
    }
    
    func testBalancedBT() {
        let fifteen = TreeLeetcode.TreeNode(15)
        let seven = TreeLeetcode.TreeNode(7)
        let twenty = TreeLeetcode.TreeNode(20, fifteen, seven)
        let nine = TreeLeetcode.TreeNode(9)
        let three = TreeLeetcode.TreeNode(3, nine, twenty)
        
        let obj = BalancedBinaryTree()
        XCTAssertEqual(obj(three), true)
    }
    
    func testBinaryTreeToLinkedList() {
        let six = TreeLeetcode.TreeNode(6)
        let five = TreeLeetcode.TreeNode(5, nil, six)
        let four = TreeLeetcode.TreeNode(4)
        let three = TreeLeetcode.TreeNode(3)
        let two = TreeLeetcode.TreeNode(2, three, four)
        let one = TreeLeetcode.TreeNode(1, two, five)
        
        let six1 = TreeLeetcode.TreeNode(6)
        let five1 = TreeLeetcode.TreeNode(5, nil, six1)
        let four1 = TreeLeetcode.TreeNode(4, nil, five1)
        let three1 = TreeLeetcode.TreeNode(3, nil, four1)
        let two1 = TreeLeetcode.TreeNode(2,  nil, three1)
        let one1 = TreeLeetcode.TreeNode(1, nil, two1)
        
        let obj = BinaryTreeToLinkedList()
        obj.flatten(one)
        XCTAssertEqual(one, one1)
    }
    
    func testBinaryTreeLevelOrderTraversal() {
        let seven = TreeLeetcode.TreeNode(7)
        let fifteen = TreeLeetcode.TreeNode(15)
        let nine = TreeLeetcode.TreeNode(9)
        let twenty = TreeLeetcode.TreeNode(20, fifteen, seven)
        let three = TreeLeetcode.TreeNode(3, nine, twenty)
        
        let obj = BinaryLevelOrderTraversal()
        XCTAssertEqual(obj(three), [[3],[9,20],[15,7]])
        
        let one = TreeLeetcode.TreeNode(1)
        XCTAssertEqual(obj(one), [[1]])
        
        XCTAssertEqual(obj(nil), [])
    }
    
    func testBinaryTreeLevelOrderTraversalII() {
        let seven = TreeLeetcode.TreeNode(7)
        let fifteen = TreeLeetcode.TreeNode(15)
        let nine = TreeLeetcode.TreeNode(9)
        let twenty = TreeLeetcode.TreeNode(20, fifteen, seven)
        let three = TreeLeetcode.TreeNode(3, nine, twenty)
        
        let obj = BinaryLevelOrderTraversalII()
        XCTAssertEqual(obj(three), [[15,7], [9,20], [3]])
        
        let one = TreeLeetcode.TreeNode(1)
        XCTAssertEqual(obj(one), [[1]])
        
        XCTAssertEqual(obj(nil), [])
    }
    
    func testMergeTwoBinaryTrees() {
        let five = TreeLeetcode.TreeNode(5)
        let three = TreeLeetcode.TreeNode(3, five, nil)
        let two = TreeLeetcode.TreeNode(2)
        let one = TreeLeetcode.TreeNode(1, three, two)
        
        let four1 = TreeLeetcode.TreeNode(4)
        let seven1 = TreeLeetcode.TreeNode(7)
        let one1 = TreeLeetcode.TreeNode(1, nil, four1)
        let three1 = TreeLeetcode.TreeNode(3, nil, seven1)
        let two1 = TreeLeetcode.TreeNode(2, three1, one1)
        
        let four3 = TreeLeetcode.TreeNode(4, five, nil)
        let seven2 = TreeLeetcode.TreeNode(7, five, nil)
        let five3 = TreeLeetcode.TreeNode(5, nil, seven2)
        let four2 = TreeLeetcode.TreeNode(4, five3, four3)
        let five2 = TreeLeetcode.TreeNode(5, five, nil)
        let three2 = TreeLeetcode.TreeNode(3, four2, five2)


        
        let obj = MergeTwoBinaryTrees()
        XCTAssertEqual(obj.mergeTrees(one, two1), three2)
    }
    
    func testBinaryTreeZigZagTraversal() {
        let seven = TreeLeetcode.TreeNode(7)
        let fifteen = TreeLeetcode.TreeNode(15)
        let nine = TreeLeetcode.TreeNode(9)
        let twenty = TreeLeetcode.TreeNode(20, fifteen, seven)
        let three = TreeLeetcode.TreeNode(3, nine, twenty)
        
        let obj = BinaryZigZag()
        XCTAssertEqual(obj(three), [[3],[20,9],[15,7]])
        
        let one = TreeLeetcode.TreeNode(1)
        XCTAssertEqual(obj(one), [[1]])
        
        XCTAssertEqual(obj(nil), [])
    }
    
    func testBinaryRightSideView() {
        let five = TreeLeetcode.TreeNode(5)
        let four = TreeLeetcode.TreeNode(4)
        let three = TreeLeetcode.TreeNode(3, nil, four)
        let two = TreeLeetcode.TreeNode(2, nil, five)
        let one = TreeLeetcode.TreeNode(1, two, three)
        
        let obj = BinaryTreeRightSideView()
        XCTAssertEqual(obj(one), [1,3,4])
    }
    
    func testBinaryTreeVerticalOrderTraversal() {
        let seven = TreeLeetcode.TreeNode(7)
        let six = TreeLeetcode.TreeNode(6)
        let five = TreeLeetcode.TreeNode(5)
        let four = TreeLeetcode.TreeNode(4)
        let three = TreeLeetcode.TreeNode(3, six,seven)
        let two = TreeLeetcode.TreeNode(2, four, five)
        let one = TreeLeetcode.TreeNode(1, two, three)
        
        let obj = BinaryTreeVerticalOrderTraversal()
        XCTAssertEqual(obj(one), [[4], [2], [1,5,6], [3], [7]])
    }
    
    func testConstructBinaryTreeInorderPostorder() {
        let obj = ConstructBinaryTreeInorderPostorder()
        
        let seven = TreeLeetcode.TreeNode(7)
        let fifteen = TreeLeetcode.TreeNode(15)
        let nine = TreeLeetcode.TreeNode(9)
        let twenty = TreeLeetcode.TreeNode(20, fifteen, seven)
        let three = TreeLeetcode.TreeNode(3, nine, twenty)
        
        XCTAssertEqual(obj.buildTree1([9,3,15,20,7], [9,15,7,20,3]), three)
    }
    
    func testConstructBinaryTreePreorderInorder() {
        let obj = ConstructBinaryTreePreorderInorder()
        
        let seven = TreeLeetcode.TreeNode(7)
        let fifteen = TreeLeetcode.TreeNode(15)
        let nine = TreeLeetcode.TreeNode(9)
        let twenty = TreeLeetcode.TreeNode(20, fifteen, seven)
        let three = TreeLeetcode.TreeNode(3, nine, twenty)
        
        XCTAssertEqual(obj.buildTree([3,9,20,15,7], [9,3,15,20,7]), three)
    }
    
    func testBinaryTreeMaximumPathSum() {
        let obj = BinaryTreeMaximumPathSum()
        
        let two101 = TreeLeetcode.TreeNode(2)
        let three101 = TreeLeetcode.TreeNode(3)
        let one101 = TreeLeetcode.TreeNode(1, two101, three101)
        XCTAssertEqual(obj.maxPathSum(one101), 6)
    }
    
    func testPathSum() {
        let seven = TreeLeetcode.TreeNode(7)
        let two = TreeLeetcode.TreeNode(2)
        let thirteen = TreeLeetcode.TreeNode(13)
        let one = TreeLeetcode.TreeNode(1)
        let four2 = TreeLeetcode.TreeNode(4, nil, one)
        let eleven = TreeLeetcode.TreeNode(11, seven, two)
        let four = TreeLeetcode.TreeNode(4, eleven, nil)
        let eight = TreeLeetcode.TreeNode(8, thirteen, four2)
        let five = TreeLeetcode.TreeNode(5, four, eight)
        
        let obj = PathSum()
        XCTAssertEqual(obj.hasPathSum(five, 22), true)
        
        let two101 = TreeLeetcode.TreeNode(2)
        let three101 = TreeLeetcode.TreeNode(3)
        let one101 = TreeLeetcode.TreeNode(1, two101, three101)
        XCTAssertEqual(obj.hasPathSum(one101, 5), false)
    }
    
    func testPathSumII() {
        let five = TreeLeetcode.TreeNode(5)
        let seven = TreeLeetcode.TreeNode(7)
        let two = TreeLeetcode.TreeNode(2)
        let thirteen = TreeLeetcode.TreeNode(13)
        let one = TreeLeetcode.TreeNode(1)
        let four2 = TreeLeetcode.TreeNode(4, five, one)
        let eleven = TreeLeetcode.TreeNode(11, seven, two)
        let four = TreeLeetcode.TreeNode(4, eleven, nil)
        let eight = TreeLeetcode.TreeNode(8, thirteen, four2)
        let five2 = TreeLeetcode.TreeNode(5, four, eight)

        let obj = PathSumII()
        XCTAssertEqual(obj.pathSum(five2, 22), [[5,4,11,2],[5,8,4,5]])
        
        let two101 = TreeLeetcode.TreeNode(2)
        let three101 = TreeLeetcode.TreeNode(3)
        let one101 = TreeLeetcode.TreeNode(1, two101, three101)
        XCTAssertEqual(obj.pathSum(one101, 5), [])
    }
    
    func testHouseRobberyIII() {
        let three1 = TreeLeetcode.TreeNode(3)
        let two = TreeLeetcode.TreeNode(2, nil, three1)
        let one = TreeLeetcode.TreeNode(1)
        let three2 = TreeLeetcode.TreeNode(3, nil, one)
        let three3 = TreeLeetcode.TreeNode(3, two, three2)
        
        let obj = HouseRobberyIII()
        XCTAssertEqual(obj.rob(three3), 7)
    }
    
    func testSerializeAndDeserializeBinaryTree() {
        let five = TreeLeetcode.TreeNode(5)
        let seven = TreeLeetcode.TreeNode(7)
        let two = TreeLeetcode.TreeNode(2)
        let thirteen = TreeLeetcode.TreeNode(13)
        let one = TreeLeetcode.TreeNode(1)
        let four2 = TreeLeetcode.TreeNode(4, five, one)
        let eleven = TreeLeetcode.TreeNode(11, seven, two)
        let four = TreeLeetcode.TreeNode(4, eleven, nil)
        let eight = TreeLeetcode.TreeNode(8, thirteen, four2)
        let five2 = TreeLeetcode.TreeNode(5, four, eight)
        
        let obj = SerializeAndDeserializeBTree()
        XCTAssertEqual(obj.deserialize(obj.serialize(five2)), five2)
    }
    
    func testSerializeAndDeserializeNaryTree() {
        let five = TreeNode(value: 5)
        let four = TreeNode(value: 4)
        let three = TreeNode(value: 3)
        let two = TreeNode(value: 2)
        two.add(child: four)
        two.add(child: five)
        let one = TreeNode(value: 1)
        one.add(child: two)
        one.add(child: three)
        
        let obj = SerializeAndDeserializeNaryTree()
        let str = obj.serialize(one)
        let resultNode = obj.deserialize(str)
        
        XCTAssertEqual(resultNode, one)
    }
    
    func testBinaryTreePaths() {
        let five = TreeLeetcode.TreeNode(5)
        let three = TreeLeetcode.TreeNode(3)
        let two = TreeLeetcode.TreeNode(2, nil, five)
        let one = TreeLeetcode.TreeNode(1, two, three)
        
        let obj = BinaryTreePaths()
        XCTAssertEqual(obj(one), ["1->2->5","1->3"])
    }
}
