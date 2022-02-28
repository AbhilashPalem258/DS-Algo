//
//  LinkedListTests.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 17/06/21.
//

import XCTest
@testable import LeetcodePractice

class LinkedListTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
extension LinkedListTests {
    func testLinkedList() {
        let list = LinkedList<Int>()
        list.append(101)
        list.append(102)
        
        list.insert(201, at: 0)
        list.insert(.init(202), at: 1)
        
        XCTAssertEqual(list.node(at: 0)?.value, 201)
        XCTAssertEqual(list.node(at: 1)?.value, 202)
        XCTAssertEqual(list.node(at: 2)?.value, 101)
        XCTAssertEqual(list.node(at: 3)?.value, 102)
        
        list.insert(301, at: 3)
        list.remove(at: 3)
        
        let secList: LinkedList<Int> = [222,333,444,555]
        list.insert(secList, at: 2)
        XCTAssertEqual(secList.last?.value, 102)
        
        let thirdList = LinkedList.init([77, 88, 99, 11])
        XCTAssertEqual(thirdList.count, 4)
        thirdList.reverse()
        
    }
    
    func testLinkedListCollection() {
        let coll: LinkedList = ["A", "B", "C"]
        for element in coll {
            print(element)
        }
        coll.contains("D")
    }
    
    func test206() {
        let node = ListNode(101)
        node.next = .init(102)
        node.next?.next = .init(103)
        node.next?.next?.next = .init(104)
        
        let reversed = LL206().reverseListRecursive(node)
        print(node)
    }
    
    func testMaxStack() {
        let maxStack = MaxStack()
        let list = makeList(5)
        list.forEach({ maxStack.push($0) })
        let val = maxStack.popMax()
        let val2 = maxStack.popMax()
    }
    
    func makeList(_ n: Int) -> [Int] {
        return (0..<n).map { _ in .random(in: 1...20) }
    }
    
    func testLongestParentheses() {
//        LongestValidParentheses().longestValidParentheses("(()")
        LongestValidParentheses().longestValidParentheses(")()())")
    }
    
    func testExclusiveTF() {
        let timeFunc = ExclusiveTimeFunctions()
        
        XCTAssertEqual(timeFunc.exclusiveTime(2, ["0:start:0","1:start:2","1:end:5","0:end:6"]), [3,4])
        XCTAssertEqual(timeFunc.exclusiveTime(1, ["0:start:0","0:start:2","0:end:5","0:start:6","0:end:6","0:end:7"]), [8])
        XCTAssertEqual(timeFunc.exclusiveTime(2, ["0:start:0","1:start:2","1:end:5","0:end:6"]), [3,4])
        XCTAssertEqual(timeFunc.exclusiveTime(2, ["0:start:0","1:start:2","1:end:5","0:end:6"]), [3,4])
    }
    
    func testRotateLL() {
        let node = ListNode(1)
        node.next = .init(2)
        node.next?.next = .init(3)
        node.next?.next?.next = .init(4)
        node.next?.next?.next?.next = .init(5)
        
        let expectedNode = ListNode(4)
        expectedNode.next = .init(5)
        expectedNode.next?.next = .init(1)
        expectedNode.next?.next?.next = .init(2)
        expectedNode.next?.next?.next?.next = .init(3)
        
        let obj = RotateLL()
        let result = obj.rotateRight(node, 2)
        XCTAssertEqual(result, expectedNode)
    }
    
    func testSortList() {
        
        let node: ListNode = [-1,5,3,4,0]
        let expectedNode: ListNode = [-1,0,3,4,5]
        
        let obj = SortList()
        XCTAssertEqual(obj.sortList(node), expectedNode)
    }
    
    func testReverseKGroup() {
        let obj = ReverseKGroup()

        let node: ListNode? = [1,2,3,4,5]
        let expectedNode: ListNode? = [2,1,4,3,5]
        let result = obj(node, 2)
        XCTAssertEqual(result, expectedNode)

        let node1: ListNode? = [1,2,3,4,5]
        let expectedNode1: ListNode? = [3,2,1,4,5]
        XCTAssertEqual(obj(node1, 3), expectedNode1)
        
        let node2: ListNode? = [1,7,3,2,7,0,1,0,0]
        let expectedNode2: ListNode? = [2,3,7,1,0,1,0,7,0]
        let result2 = obj(node2, 4)
        XCTAssertEqual(result2, expectedNode2)
    }
    
    func testInsertionSortList() {
        let obj = InsertionSortList()
        let inputNode: ListNode = [4,2,1,3]
        let expectedNode: ListNode = [1,2,3,4]
        let result = obj(inputNode)
        XCTAssertEqual(obj(inputNode), expectedNode)
    }
}
