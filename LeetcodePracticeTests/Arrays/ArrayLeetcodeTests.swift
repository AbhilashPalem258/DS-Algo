//
//  ArrayLeetcodeTests.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 01/07/21.
//

import XCTest
@testable import LeetcodePractice

class ArrayLeetcodeTests: XCTestCase {
    
    func testSortArrayByParity() {
        let obj = SortArrayByParity()
//        XCTAssertEqual(obj([1,2,3,4,5,6]), [2,4,6,1,3,5])
//        XCTAssertEqual(obj.solution3([1,2,3,4,5,6]), [2,4,6,1,3,5])
    }

    func testHeaters() {
        let obj = Heaters()
        XCTAssertEqual(obj.findRadius([1,2,3,4], [1,4]), 1)
    }
    
    func testNumberOfBoomerangs() {
        let obj = NumberOfBoomerangs()
        XCTAssertEqual(obj.numberOfBoomerangs([[0,0],[1,0],[2,0]]), 2)
    }
    
    func testMajorityElement() {
        let obj = MajorityElement()
        XCTAssertEqual(obj([3,2,3]), 3)
        XCTAssertEqual(obj([2,2,1,1,1,2,2]), 2)
    }
    
    func testMajorityElementII() {
        let obj = MajorityElementII()
        XCTAssertEqual(obj([1,1,1,2,2,3,3,3]), [1,3])
    }
    
    func testIslandPerimeter() {
        let obj = IslandPerimeter()
        XCTAssertEqual(obj.islandPerimeter([[1]]), 4)
        XCTAssertEqual(obj.islandPerimeter([[0,1,0,0],[1,1,1,0],[0,1,0,0],[1,1,0,0]]), 16)
    }
    
    func testContainsDuplicateII() {
        let obj = ContainsDuplicatesII()
        XCTAssertEqual(obj.containsNearbyDuplicate([1,2,3,1], 3), true)
        XCTAssertEqual(obj.containsNearbyDuplicate([1,0,1,1], 1), true)
        XCTAssertEqual(obj.containsNearbyDuplicate([1,2,3,1,2,3], 2), false)
    }
    
    func testRemoveDuplicatesFromSortedArray() {
        let obj = RemoveDuplicatesFromSortedArray()
        
        var var1 = [1,1,2]
        let val1 = obj(&var1)
        XCTAssertEqual(val1, 2)
        
        var var2 = [0,0,1,1,1,2,2,3,3,4]
        let val2 = obj(&var2)
        XCTAssertEqual(val2, 5)
    }
    
    func testRemoveDuplicatesFromSortedArrayII() {
        let obj = RemoveDuplicatesFromSortedArrayII()
        
        var var1 = [1,1,1,2,2,3]
        let val1 = obj(&var1)
        XCTAssertEqual(val1, 5)
        
        var var2 = [0,0,1,1,1,1,2,3,3]
        let val2 = obj(&var2)
        XCTAssertEqual(val2, 7)
    }
    
    func testMoveZeros() {
        let obj = MoveZeros()
       
        var var1 = [0,1,0,3,12]
        obj(&var1)
        XCTAssertEqual(var1, [1,3,12,0,0])
    }
    
    func testRemoveElementInArr() {
        let obj = RemoveElementInArr()
       
        var var1 = [3,2,2,3]
        let val1 = obj(&var1, 3)
        XCTAssertEqual(val1, 2)
        
        var var2 = [0,1,2,2,3,0,4,2]
        let val2 = obj(&var2, 2)
        XCTAssertEqual(val2, 5)
    }
    
    func testStrobogrammaticNumber() {
        let obj = StrobogrammaticNumber()
        XCTAssertEqual(obj("69"), true)
        XCTAssertEqual(obj("88"), true)
        XCTAssertEqual(obj("818"), true)
        XCTAssertEqual(obj("819"), false)
    }
    
    func testCanPlaceFlowers() {
        let obj = CanPlaceFlowers()
        XCTAssertEqual(obj([1,0,0,0,1], 1), true)
        XCTAssertEqual(obj([1,0,0,0,1], 2), false)
    }
    
    func testTwoSum() {
        let obj = TwoSum()
        XCTAssertEqual(obj([2,7,11,15], 9), [0,1])
        XCTAssertEqual(obj([3,2,4], 6), [1,2])
    }
    
    func testTwoSumII() {
        let obj = TwoSumII()
        XCTAssertEqual(obj([2,7,11,15], 9), [1,2])
        XCTAssertEqual(obj([2,3,4], 6), [1,3])
    }
    
    func testTwoSumLessThanK() {
        let obj = TwoSumLessThanK()
        XCTAssertEqual(obj([34,23,1,24,75,33,54,8], 60), 58)
        XCTAssertEqual(obj([10,20,30], 15), -1)
    }
    
    func testThreeSum() {
        let obj = ThreeSum()
        XCTAssertEqual(obj.threeSum([-1,0,1,2,-1,-4]), [[-1,-1,2],[-1,0,1]])
        XCTAssertEqual(obj.threeSum([]), [])
        XCTAssertEqual(obj.threeSum([0]), [])
    }
    
    func testthreeSumClosest() {
        let obj = ThreeSumClosest()
        XCTAssertEqual(obj([-1,2,1,-4], 1), 2)
    }
    
    func testFourSum() {
        let obj = FourSum()
        XCTAssertEqual(obj.fourSum([1,0,-1,0,-2,2].sorted(), 0), [[-2,-1,1,2],[-2,0,0,2],[-1,0,0,1]])
    }
    
    func testIncreasingTriplet() {
        let obj = IncreasingTriplet()
        XCTAssertEqual(obj([2,1,5,0,4,6]), true)
        XCTAssertEqual(obj([1,1,1,1,1,1]), false)
        XCTAssertEqual(obj([5,4,3,2,1]), false)
        XCTAssertEqual(obj([2,1,5,0,4,6]), true)
    }
    
    func testSummaryRanges() {
        let obj = SummaryRanges()
        XCTAssertEqual(obj([0,1,2,4,5,7]), ["0->2","4->5","7"])
        XCTAssertEqual(obj([0,2,3,4,6,8,9]), ["0","2->4","6","8->9"])
        XCTAssertEqual(obj([-1]), ["-1"])
        XCTAssertEqual(obj([0]), ["0"])
    }
    
    func testMissingRanges() {
        let obj = MissingRanges()
        XCTAssertEqual(obj.findMissingRanges([0, 1, 3, 50, 75], 0 ,99), ["2", "4->49", "51->74", "76->99"])
    }
    
    func testAsteriodsCollisons() {
        let obj = AsteroidCollision()
        XCTAssertEqual(obj([5,10,-5]),  [5,10])
        XCTAssertEqual(obj([8,-8]),  [])
        XCTAssertEqual(obj([10,2,-5]), [10])
        XCTAssertEqual(obj([-2,-1,1,2]), [-2,-1,1,2])
    }
    
    func testNumMatrix() {
        let obj = NumMatrix([[3, 0, 1, 4, 2], [5, 6, 3, 2, 1], [1, 2, 0, 1, 5], [4, 1, 0, 1, 7], [1, 0, 3, 0, 5]])
        XCTAssertEqual(obj.sumRegion(2, 1, 4, 3), 8)
    }
}

//2,3,4,5,6,7
