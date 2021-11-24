//
//  MathLeetcodeTests.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 16/08/21.
//

import XCTest
@testable import LeetcodePractice

class MathLeetcodeTests: XCTestCase {
    func testAddBinary() {
        let obj = AddBinary()
        XCTAssertEqual(obj("11", "1"), "100")
    }
    
    func testAddTwoNumbers() {
        
//        let listNode1 = ListNode(2)
//        listNode1.next = ListNode(4)
//        listNode1.next?.next = ListNode(3)
//
//        let listNode2 = ListNode(5)
//        listNode2.next = ListNode(6)
//        listNode2.next?.next = ListNode(4)
//
//        let result = ListNode(7)
//        result.next = ListNode(0)
//        result.next?.next = ListNode(8)
//
//        let obj = AddTwoNumbers()
//        XCTAssertEqual(obj(listNode1, listNode2), result)
        
        let first1 = createLL([9,9,9,9,9,9,9])
        let second1 = createLL([9,9,9,9])
        let result = createLL([8,9,9,9,0,0,0,1])
        let obj = AddTwoNumbers()
        XCTAssertEqual(obj(first1, second1), result)
    }
    
    func testAddDigits() {
        let obj = AddDigits()
        XCTAssertEqual(obj(38), 2)
        XCTAssertEqual(obj(0), 0)
    }
    
    func testPlusOne() {
        let obj = PlusOne()
        XCTAssertEqual(obj([1,2,3]), [1,2,4])
        XCTAssertEqual(obj([4,3,2,1]),  [4,3,2,2])
        XCTAssertEqual(obj([9]),  [1,0])
    }
    
    func testMissingNumber() {
        let obj = MissingNumber()
        XCTAssertEqual(obj([3,0,1]), 2)
        XCTAssertEqual(obj([0,1]), 2)
        XCTAssertEqual(obj([9,6,4,2,3,5,7,0,1]), 8)
    }
    
    func testIntegerBreak() {
        let obj = IntegerBreak()
        XCTAssertEqual(obj(2), 1)
        XCTAssertEqual(obj(10), 36)
    }
    
    func testTrailingZeros() {
        let obj = FactorialTrailingZeros()
        XCTAssertEqual(obj(5), 1)
        XCTAssertEqual(obj(30), 7)
        XCTAssertEqual(obj(3), 0)
        XCTAssertEqual(obj(0), 0)
    }
    
    func testHappyNumber() {
        let obj = HappyNumber()
        XCTAssertEqual(obj(19), true)
        XCTAssertEqual(obj(2), false)
    }
    
    func testSingleNumber() {
        let obj = SingleNumber()
        XCTAssertEqual(obj([2,2,1]), 1)
        XCTAssertEqual(obj([4,1,2,1,2]), 4)
        XCTAssertEqual(obj([1]), 1)
        
        XCTAssertEqual(obj.usingXOR([2,2,1]), 1)
        XCTAssertEqual(obj.usingXOR([4,1,2,1,2]), 4)
        XCTAssertEqual(obj.usingXOR([1]), 1)
    }
    
    func testUglyNumber() {
        let obj = UglyNumber()
        XCTAssertEqual(obj(6), true)
        XCTAssertEqual(obj(8), true)
        XCTAssertEqual(obj(14), false)
        XCTAssertEqual(obj(1), true)
    }
    
    func testUglyNumberII() {
        let obj = UglyNumberII()
        XCTAssertEqual(obj(10), 12)
        XCTAssertEqual(obj(1), 1)
    }
    
    func testSuperUglyNumber() {
        let obj = SuperUglyNumber()
        XCTAssertEqual(obj(12, [2,7,13,19]), 32)
        XCTAssertEqual(obj(1, [2,3,5]), 1)
    }
    
    func testCountPrimes() {
        let obj = CountPrimes()
        XCTAssertEqual(obj(10), 4)
        XCTAssertEqual(obj(0), 0)
        XCTAssertEqual(obj(1), 0)
    }
    
    func testSStringToInteger() {
        let obj = StringToInteger()
        XCTAssertEqual(obj.myAtoi("42"), 42)
        XCTAssertEqual(obj.myAtoi("342"), 342)
        XCTAssertEqual(obj.myAtoi("-42"), -42)
        XCTAssertEqual(obj.myAtoi("4193 with words"), 4193)
        XCTAssertEqual(obj.myAtoi("words and 987"), 0)
    }
    
    func testPowXN() {
        let obj = PowXN()
        XCTAssertEqual(obj(2.0000, 10), 1024.0000)
        XCTAssertEqual(obj(2.10000, 3), 9.261000000000001)
        XCTAssertEqual(obj(2.0000, -2), 0.25000)
    }
    
    func testPow2() {
        let obj = Pow2()
        XCTAssertEqual(obj(1), true)
        XCTAssertEqual(obj(16), true)
        XCTAssertEqual(obj(3), false)
        XCTAssertEqual(obj(4), true)
        XCTAssertEqual(obj(5), false)
    }
    
    func testPow3() {
        let obj = Pow3()
        XCTAssertEqual(obj(27), true)
        XCTAssertEqual(obj(0), false)
        XCTAssertEqual(obj(9), true)
        XCTAssertEqual(obj(45), false)
    }
    
    func testFractionToDecimal() {
        let obj = FractionToDecimal()
        XCTAssertEqual(obj(1, 2), "0.5")
        XCTAssertEqual(obj(2, 1), "2")
        XCTAssertEqual(obj(2, 3), "0.(6)")
        XCTAssertEqual(obj(4, 333), "0.(012)")
        XCTAssertEqual(obj(1, 5), "0.2")
    }
    
    func testTrappingRainWater() {
        let obj = TrappingRainWater()
        XCTAssertEqual(obj([0,1,0,2,1,0,1,3,2,1,2,1]), 6)
        XCTAssertEqual(obj([4,2,0,3,2,5]), 9)
    }
    
    func testCountingBits() {
        let obj = CountingBits()
        XCTAssertEqual(obj(2),  [0,1,1])
        XCTAssertEqual(obj(5),  [0,1,1,2,1,2])
    }
    
    func testGrayCode() {
        let obj = GrayCode()
        XCTAssertEqual(obj.grayCode(2), [0,1,3,2])
        XCTAssertEqual(obj.grayCode(1), [0,1])
    }
    
    func createLL(_ arr: [Int]) -> ListNode {
        let dummy = ListNode(0)
        var current = dummy
        for num in arr {
            current.next = ListNode(num)
            current = current.next!
        }
        return dummy.next!
    }
}
