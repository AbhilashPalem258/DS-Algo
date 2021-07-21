//
//  DFSLeetcode.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 19/07/21.
//

import XCTest
@testable import LeetcodePractice

class DFSLeetcode: XCTestCase {

    func testNumberOfIslands() {
        let obj = NumberOfIslands()
        
        XCTAssertEqual(obj.depthFirst([
            ["1","1","1","1","0"],
            ["1","1","0","1","0"],
            ["1","1","0","0","0"],
            ["0","0","0","0","0"]
        ]), 1)
        
        XCTAssertEqual(obj.depthFirst([
            ["1","1","0","0","0"],
            ["1","1","0","0","0"],
            ["0","0","1","0","0"],
            ["0","0","0","1","1"]
          ]), 3)
    }
    
    func testPermutations() {
        let obj = Permutation()
        XCTAssertEqual(obj.permute([1,2,3]).count,  [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]].count)
        XCTAssertEqual(obj.permute([1,1,2]), [[1,1,2],
                                                    [1,2,1],
                                                    [2,1,1]])
    }
    
    func testWordSearch() {
        let obj = WordSearch()
        XCTAssertEqual(obj.exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "ABCCED"), true)
        XCTAssertEqual(obj.exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "SEE"), true)
        XCTAssertEqual(obj.exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "ABCB"), false)
    }
    
    func testWordSearchII() {
        let obj = WordSearchII()
        XCTAssertEqual(obj.findWords([["o","a","a","n"],["e","t","a","e"],["i","h","k","r"],["i","f","l","v"]], ["oath","pea","eat","rain"]), ["oath", "eat"])
        XCTAssertEqual(obj.findWords([["a","b"],["c","d"]], ["abcb"]), [])
    }
    
    func testSubsets() {
        let obj = Subsets()
        XCTAssertEqual(obj.subsets([1,2,3]), [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]])
    }
    
    func testSubsetsII() {
        let obj = Subsets()
        XCTAssertEqual(obj.subsetsWithDup([1,2,2]),  [[],[1],[1,2],[1,2,2],[2],[2,2]])
    }
    
    func testCombinations() {
        let obj = Combinations()
        XCTAssertEqual(obj(4, 2).count, [[2,4],[3,4],[2,3],[1,2],[1,3],[1,4]].count)
        XCTAssertEqual(obj(1, 1), [[1]])
    }
    
    func testCombinationSum() {
        let obj = CombinationSum()
        XCTAssertEqual(obj([2,3,6,7], 7), [[2,2,3],[7]])
    }
    
    func testCombinationSumII() {
        let obj = CombinationSumII()
        XCTAssertEqual(obj([2,5,2,1,2], 8), [[1,2,2],[5]])
    }
    
    func testCombinationSumIII() {
        let obj = CombinationSumIII()
        XCTAssertEqual(obj.combinationSum3(3, 7), [[1,2,4]])
        XCTAssertEqual(obj.combinationSum3(3, 9),  [[1,2,6],[1,3,5],[2,3,4]])
        XCTAssertEqual(obj.combinationSum3(4, 1), [])
        XCTAssertEqual(obj.combinationSum3(3, 2), [])
    }
    
    func testLetterCombinationsPhoneNumber() {
        let obj = LetterCombinationsPhoneNumber()
        XCTAssertEqual(obj("23"), ["ad","ae","af","bd","be","bf","cd","ce","cf"])
        XCTAssertEqual(obj(""), [])
        XCTAssertEqual(obj("2"), ["a","b","c"])
    }
    
    func testFactorCombinations() {
        let obj = FactorCombinations()
        XCTAssertEqual(obj.getFactors(12), [
        [2, 2, 3],
        [2, 6],
        [3, 4]
      ])
    }
    
    func testPalindromePartioning() {
        let obj = PalindromePartioning()
        XCTAssertEqual(obj("aab"), [["a","a","b"],["aa","b"]])
        XCTAssertEqual(obj("a"), [["a"]])
    }
    
    func testIsGraphBipartite() {
        let obj = IsGraphBipartite()
        XCTAssertEqual(obj([[1,2,3],[0,2],[0,1,3],[0,2]]), false)
        XCTAssertEqual(obj([[1,3],[0,2],[1,3],[0,2]]), true)
    }
    
    func testWallsGates() {
        let obj = WallsGates()
        
        var arr1 = [[2147483647,-1,0,2147483647],[2147483647,2147483647,2147483647,-1],[2147483647,-1,2147483647,-1],[0,-1,2147483647,2147483647]]
        obj(&arr1)
        XCTAssertEqual(arr1, [[3,-1,0,1],[2,2,1,-1],[1,-1,2,-1],[0,-1,3,4]])
        
        var arr2 = [[0,-1],[2147483647,2147483647]]
        obj(&arr2)
        XCTAssertEqual(arr2, [[0,-1],[1,2]])
    }
    
    func testNQueens() {
        let obj = NQueens()
        XCTAssertEqual(obj(4), [[".Q..","...Q","Q...","..Q."],["..Q.","Q...","...Q",".Q.."]])
        XCTAssertEqual(obj(1), [["Q"]])
    }
    
    func testNQueensII() {
        let obj = NQueensII()
        XCTAssertEqual(obj(4), 2)
        XCTAssertEqual(obj(1), 1)
    }
}
