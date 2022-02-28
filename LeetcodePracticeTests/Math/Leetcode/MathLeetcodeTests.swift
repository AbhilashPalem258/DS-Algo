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
    
    func testDivideTwoIntegers() {
        let obj = DivideTwoIntegers()
        XCTAssertEqual(obj(-2147483648, -1), 2147483647)
//        XCTAssertEqual(obj(10, 3), 3)
    }
    
    func testNumberComplement() {
        let obj = NumberComplement()
        XCTAssertEqual(obj(5), 2)
        XCTAssertEqual(obj(1), 0)
    }
    
    func testHammingDistance() {
        let obj = HammingDistance()
        XCTAssertEqual(obj(1, 4), 2)
        XCTAssertEqual(obj(3, 1), 1)
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
    
    func testStringToInteger() {
        let obj = StringToInteger()
        XCTAssertEqual(obj.myAtoi("42"), 42)
        XCTAssertEqual(obj.myAtoi("-42"), -42)
        XCTAssertEqual(obj.myAtoi("4193 with words"), 4193)
        XCTAssertEqual(obj.myAtoi("words and 987"), 0)
        XCTAssertEqual(obj.myAtoi("-91283472332"), -2147483648)

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
    
    func testSumOfTwoIntegers() {
        let obj = SumOfTwoIntegers()
        XCTAssertEqual(obj(1, 2), 3)
        XCTAssertEqual(obj(2, 3), 5)
    }
    
    func testReverseInteger() {
        let obj = ReverseInteger()
        XCTAssertEqual(obj(123), 321)
        XCTAssertEqual(obj(-123), -321)
        XCTAssertEqual(obj(120), 21)
        XCTAssertEqual(obj(0), 0)
    }
    
    func testExcelSheetColumnNumber() {
        let obj = ExcelSheetColumnNumber()
        XCTAssertEqual(obj("A"), 1)
        XCTAssertEqual(obj("AB"), 28)
        XCTAssertEqual(obj("ZY"), 701)
    }
    
    
    func testRomanToInteger() {
        let obj = RomanToInteger()
        XCTAssertEqual(obj("III"), 3)
        XCTAssertEqual(obj("IV"), 4)
        XCTAssertEqual(obj("IX"), 9)
        XCTAssertEqual(obj("LVIII"), 58)
        XCTAssertEqual(obj("MCMXCIV"), 1994)
    }
    
    func testIntegerToRoman() {
        let obj = IntegerToRoman()
        XCTAssertEqual(obj(3), "III")
        XCTAssertEqual(obj(4), "IV")
        XCTAssertEqual(obj(9), "IX")
        XCTAssertEqual(obj(58), "LVIII")
        XCTAssertEqual(obj(1994), "MCMXCIV")
    }
    
    func testIntegerToEnglishWords() {
        let obj = IntegerToEnglish()
        XCTAssertEqual(obj.numberToWords(1234567891), "One Billion Two Hundred Thirty Four Million Five Hundred Sixty Seven Thousand Eight Hundred Ninety One")
        XCTAssertEqual(obj.numberToWords(123), "One Hundred Twenty Three")
        XCTAssertEqual(obj.numberToWords(12345), "Twelve Thousand Three Hundred Forty Five")
        XCTAssertEqual(obj.numberToWords(1234567), "One Million Two Hundred Thirty Four Thousand Five Hundred Sixty Seven")
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
    
    func testLargestRectangleinHistogram() {
        let obj = LargestRectangleHistogram()
        XCTAssertEqual(obj([2,1,5,6,2,3]), 10)
        XCTAssertEqual(obj([2,4]), 4)
    }
    
    func testSkylineProblem() {
        let obj = SkylineProblem()
        XCTAssertEqual(obj.getSkyline([[2,9,10],[3,7,15],[5,12,12],[15,20,10],[19,24,8]]), [[2,10],[3,15],[7,12],[12,0],[15,10],[20,8],[24,0]])
        XCTAssertEqual(obj.getSkyline([[0,2,3],[2,5,3]]), [[0,3],[5,0]])
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
