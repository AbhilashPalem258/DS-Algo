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
        XCTAssertEqual(obj.findRadius([1,2,3], [2]), 1)
        XCTAssertEqual(obj.findRadius([1,5], [2]), 3)
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
    
    func testMaxDistToClosest() {
        let obj = MaxDistToClosest()
        XCTAssertEqual(obj([1,0,0,0,1,0,1]), 2)
    }
    
    func testExamRoom() {
        let obj = ExamRoom(10)
        XCTAssertEqual(obj.seat(), 0)
        XCTAssertEqual(obj.seat(), 9)
        XCTAssertEqual(obj.seat(), 4)
        XCTAssertEqual(obj.seat(), 2)
        obj.leave(4)
        XCTAssertEqual(obj.seat(), 5)
    }
    
    func testShortestWordDistance() {
        let obj = ShortestWordDistance()
        XCTAssertEqual(obj(["can", "this", "problem", "be", "solved", "problem"], "can", "solved"), 4)
        XCTAssertEqual(obj(["can", "this", "problem", "be", "solved", "problem"], "problem", "solved"), 1)
        
        XCTAssertEqual(obj(["practice", "makes", "perfect", "coding", "makes"], "coding", "practice"), 3)
    }
    
    func testShortestWordDistanceII() {
        let obj = ShortestWordDistanceII(["can", "this", "problem", "be", "solved", "problem"])
        XCTAssertEqual(obj.shortest("can", "solved"), 4)
        XCTAssertEqual(obj.shortest("problem", "solved"), 1)
        
        let obj1 = ShortestWordDistanceII(["practice", "makes", "perfect", "coding", "makes"])
        XCTAssertEqual(obj1.shortest("coding", "practice"), 3)
    }
    
    func testShortestWordDistanceIII() {
        let obj = ShortestWordDistanceIII()
        XCTAssertEqual(obj.shortestWordDistance(["practice", "makes", "perfect", "coding", "makes"], "coding", "practice"), 3)
        XCTAssertEqual(obj.shortestWordDistance(["practice", "makes", "perfect", "coding", "makes"], "makes", "makes"), 3)
    }
    
    func testMinimumSizeSubarraySum() {
        let obj = MinimumSizeSubarraySum()
        XCTAssertEqual(obj(7, [2,3,1,2,4,3]), 2)
        XCTAssertEqual(obj(4, [1,4,4]), 1)
        XCTAssertEqual(obj(11, [1,1,1,1,1,1,1,1]), 0)
    }
    
    func testMaximumSizeSubarraySumEqualsK() {
        let obj = MaximumSizeSubarraySumEqualsK()
        XCTAssertEqual(obj([1, -1, 5, -2, 3], 3), 4)
    }
    
    func testProductExceptSelf() {
        let obj = ProductExceptSelf()
        XCTAssertEqual(obj([1,2,3,4]), [24,12,8,6])
        XCTAssertEqual(obj([1,2,3,4]), [24,12,8,6])
    }
    
    func testRotateArray() {
        let obj = RotateArray()
        
        var arr1 = [1,2,3,4,5,6,7]
        obj.rotate(&arr1, 3)
        XCTAssertEqual(arr1, [5,6,7,1,2,3,4])
        
        var arr2 = [-1,-100,3,99]
        obj.rotate(&arr2, 2)
        XCTAssertEqual(arr2, [3,99,-1,-100])
    }
    
    func testRotateImage() {
        let obj = RotateImage()
        
        var arr1 = [[1,2,3],[4,5,6],[7,8,9]]
        obj.rotate(&arr1)
        XCTAssertEqual(arr1, [[7,4,1],[8,5,2],[9,6,3]])
        
        var arr2 = [[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]
        obj.rotate(&arr2)
        XCTAssertEqual(arr2, [[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]])
    }
    
    func testSpiralOrder() {
        let obj = SprialOrder()
        XCTAssertEqual(obj([[1,2,3],[4,5,6],[7,8,9]]), [1,2,3,6,9,8,7,4,5])
        XCTAssertEqual(obj([[1,2,3,4],[5,6,7,8],[9,10,11,12]]), [1,2,3,4,8,12,11,10,9,5,6,7])
    }
    
    func testSpiralMatrixII() {
        let obj = SpiralMatrixII()
        XCTAssertEqual(obj.generateMatrix(3), [[1,2,3],[8,9,4],[7,6,5]])
        XCTAssertEqual(obj.generateMatrix(1), [[1]])
    }
    
    func testDiagonalTraverse() {
        let obj = DiagonalOrder()
        XCTAssertEqual(obj([[1,2,3],[4,5,6],[7,8,9]]), [1,2,4,7,5,3,6,8,9])
    }
    
    func testValidSudoku() {
        let obj = ValidSudoku()
        XCTAssertEqual(obj.isValidSudoku([["5","3",".",".","7",".",".",".","."]
                                       ,["6",".",".","1","9","5",".",".","."]
                                       ,[".","9","8",".",".",".",".","6","."]
                                       ,["8",".",".",".","6",".",".",".","3"]
                                       ,["4",".",".","8",".","3",".",".","1"]
                                       ,["7",".",".",".","2",".",".",".","6"]
                                       ,[".","6",".",".",".",".","2","8","."]
                                       ,[".",".",".","4","1","9",".",".","5"]
                                       ,[".",".",".",".","8",".",".","7","9"]]), true)
        XCTAssertEqual(obj.isValidSudoku([["8","3",".",".","7",".",".",".","."]
                                          ,["6",".",".","1","9","5",".",".","."]
                                          ,[".","9","8",".",".",".",".","6","."]
                                          ,["8",".",".",".","6",".",".",".","3"]
                                          ,["4",".",".","8",".","3",".",".","1"]
                                          ,["7",".",".",".","2",".",".",".","6"]
                                          ,[".","6",".",".",".",".","2","8","."]
                                          ,[".",".",".","4","1","9",".",".","5"]
                                          ,[".",".",".",".","8",".",".","7","9"]]), false)
    }
    
    func testSetMatrixZero() {
        let obj = SetZeroes()
        
        var arr1 = [[1,1,1],[1,0,1],[1,1,1]]
        obj(&arr1)
        XCTAssertEqual(arr1, [[1,0,1],[0,0,0],[1,0,1]])
        
        var arr2 = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]
        obj(&arr2)
        XCTAssertEqual(arr2, [[0,0,0,0],[0,4,5,0],[0,3,1,0]])
    }
    
    func testGasStation() {
        let obj = GasStation()
        XCTAssertEqual(obj.canCompleteCircuit([2,3,4],[3,4,3]), -1)
        XCTAssertEqual(obj.canCompleteCircuit([1,2,3,4,5], [3,4,5,1,2]), 3)
    }
    
    func testGameOfLife() {
        let obj = GameOfLife()
        
        var arr1 = [[0,1,0],[0,0,1],[1,1,1],[0,0,0]]
        obj(&arr1)
        XCTAssertEqual(arr1, [[0,0,0],[1,0,1],[0,1,1],[0,1,0]])
        
        var arr2 = [[1,1],[1,0]]
        obj(&arr2)
        XCTAssertEqual(arr2, [[1,1],[1,1]])
    }
    
    func testTaskScheduler() {
        let obj = TaskScheduler()
        obj(["A","A","A","B","B","B"], 2)
    }
    
    func testLongestConsecutiveSeq() {
        let obj = LongestConsecutiveSeq()
        XCTAssertEqual(obj([1,2,0,1]), 3)
        XCTAssertEqual(obj([100,4,200,1,3,2]), 4)
        XCTAssertEqual(obj([0,3,7,2,5,8,4,6,0,1]), 9)
    }
    
    func testFindDisappearedNumbers() {
        let obj = FindDisappearedNumbers()
        XCTAssertEqual(obj([4,3,2,7,8,2,3,1]), [5,6])
        XCTAssertEqual(obj([1,1]), [2])
    }
    
    func testSurroundedRegions() {
        let obj = SurroundedRegions()
        
        var board1: [[Character]] = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]
        obj(&board1)
        XCTAssertEqual(board1, [["X","X","X","X"],["X","X","X","X"],["X","X","X","X"],["X","O","X","X"]])
        
        var board2: [[Character]] = [["O","O"],["O","O"]]
        obj(&board2)
        XCTAssertEqual(board2, [["O","O"],["O","O"]])
    }
    
    func testSubarraySumEqualsK() {
        let obj = SubarraySumEqualsK()
        XCTAssertEqual(obj([1,1,1], 2), 2)
        XCTAssertEqual(obj([1,2,3], 3), 2)
    }
    
    func testDailyTemperatures() {
        let obj = DailyTemperatures()
        XCTAssertEqual(obj([89,62,70,58,47,47,46,76,100,70]), [8,1,5,4,3,2,1,1,0,0])
        XCTAssertEqual(obj([73,74,75,71,69,72,76,73]), [1,1,4,2,1,1,0,0])
        XCTAssertEqual(obj([30,40,50,60]), [1,1,1,0])
        XCTAssertEqual(obj([30,60,90]), [1,1,0])
    }
    
    func testBrickWall() {
        let obj = BrickWall()
        XCTAssertEqual(obj([[1,2,2,1],[3,1,2],[1,3,2],[2,4],[3,1,2],[1,3,1,1]]), 2)
        XCTAssertEqual(obj([[1],[1],[1]]), 3)
    }
    
    func testFindVehiclenumber() {
        let obj = FindVehiclenumber()
        var input = Array(4657...5656)
        input.append(0074)
        input.append(contentsOf: Array(183...185))
        input.append(0187)
        input.append(0190)
        input.append(0192)
        input.append(0193)
        input.append(0194)
        input.append(0197)
        input.append(4839)
        input.append(8978)
        input.append(2876)
        input.append(0314)
        input.append(3800)
        input.append(6164)
        input.append(8331)
        input.append(1785)
        input.append(7556)
        input.append(6065)
        input.append(8331)
        input.append(3224)
        input.append(contentsOf: [
            2014, 5851,
            1396, 3253,
            4379, 5032,
            3507, 5987, 6047, 7709,
            0265, 8814,
            5122,
            7512, 7811, 8632,
            0190, 0637, 3034, 3524, 3596, 3624, 3705, 3713, 3806, 5511, 5597,
            3386, 5124, 7187,
            0240, 0415, 1308, 4557, 5035, 8208, 9700
        ])
        debugPrint(obj(input))
    }
}

//2,3,4,5,6,7
