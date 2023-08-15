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
        XCTAssertEqual(obj.findWords2([["o","a","a","n"],["e","t","a","e"],["i","h","k","r"],["i","f","l","v"]], ["oath","pea","eat","rain"]), ["oath", "eat"])
//        XCTAssertEqual(obj.findWords([["a","b"],["c","d"]], ["abcb"]), [])
//        XCTAssertEqual(obj.findWords([["o","a","b","n"],["o","t","a","e"],["a","h","k","r"],["a","f","l","v"]], ["oa","oaa"]), ["oa","oaa"])
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
    
    func testFindDiffBinaryStr() {
        let obj = FindDiffBinaryStr()
        XCTAssertEqual(obj(["01","10"]), "00")
        XCTAssertEqual(obj(["00","01"]), "10")
        XCTAssertEqual(obj(["111","011","001"]), "000")
    }
    
    func testMaxLengthOfConcatenatedStrWithUniqChars() {
        let obj = MaxLengthOfConcatenatedStrWithUniqChars()
        XCTAssertEqual(obj(["un","iq","ue"]), 4)
        XCTAssertEqual(obj(["cha","r","act","ers"]), 6)
        XCTAssertEqual(obj(["abcdefghijklmnopqrstuvwxyz"]), 26)
    }
    
    func testSplitStrIntoDescendingConsecutiveVals() {
        let obj = SplitStrIntoDescendingConsecutiveVals()
        XCTAssertEqual(obj("1234"), false)
        XCTAssertEqual(obj("050043"), true)
        XCTAssertEqual(obj("9080701"), false)
    }
    
    func testMatchsticksToSquare() {
        let obj = MatchsticksToSquare()
        XCTAssertEqual(obj([1,1,2,2,2]), true)
        XCTAssertEqual(obj([3,3,3,3,4]), false)
    }
    
    func testRestoreIPAddress() {
        let obj = RestoreIPAddress()
        XCTAssertEqual(obj("101023"), ["1.0.10.23","1.0.102.3","10.1.0.23","10.10.2.3","101.0.2.3"])
        XCTAssertEqual(obj("25525511135"), ["255.255.11.135","255.255.111.35"])
    }
    
    func testFactorCombinations() {
        let obj = FactorCombinations()
        XCTAssertEqual(obj.getFactors(12), [
        [2, 2, 3],
        [2, 6],
        [3, 4]
      ])
    }
    
    func testStrobogrammaticNumberII() {
        let obj = StrobogrammaticNumberII()
        XCTAssertEqual(obj(2).sorted(), ["11","69","88","96"].sorted())
    }
    
    func testGeneralizedAbbreviation() {
        let obj = GeneralizedAbbreviation()
        obj.generateAbbreviations("word")
//        print(obj.generateAbbreviations("word"))
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
    
    func testPossibleBipartition() {
        let obj = PossibleBipartition()
        XCTAssertEqual(obj(4, [[1,2],[1,3],[2,4]]), true)
        XCTAssertEqual(obj(3, [[1,2],[1,3],[2,3]]), false)
        XCTAssertEqual(obj(5, [[1,2],[2,3],[3,4],[4,5],[1,5]]), false)
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
    
    func testSudokuSolver() {
        let obj = SudokuSolver()
        var board: [[Character]] = [["5","3",".",".","7",".",".",".","."],["6",".",".","1","9","5",".",".","."],[".","9","8",".",".",".",".","6","."],["8",".",".",".","6",".",".",".","3"],["4",".",".","8",".","3",".",".","1"],["7",".",".",".","2",".",".",".","6"],[".","6",".",".",".",".","2","8","."],[".",".",".","4","1","9",".",".","5"],[".",".",".",".","8",".",".","7","9"]]
        obj(&board)
        XCTAssertEqual(board, [["5","3","4","6","7","8","9","1","2"],["6","7","2","1","9","5","3","4","8"],["1","9","8","3","4","2","5","6","7"],["8","5","9","7","6","1","4","2","3"],["4","2","6","8","5","3","7","9","1"],["7","1","3","9","2","4","8","5","6"],["9","6","1","5","3","7","2","8","4"],["2","8","7","4","1","9","6","3","5"],["3","4","5","2","8","6","1","7","9"]])
    }
    
    func testRemoveInvalidParentheses() {
        let obj = RemoveInvalidParentheses()
        XCTAssertEqual(obj.removeInvalidParentheses("(())())"), ["(())()","()()()"])
    }
    
    func testExpressionAddOperators() {
        let obj = ExpressionAddOperators()
        XCTAssertEqual(obj.addOperators("123", 6), ["1+2+3", "1*2*3"])
        XCTAssertEqual(obj.addOperators("232", 8), ["2+3*2", "2*3+2"])
    }
    
    func testClimbingStairs() {
        let obj = ClimbingStairs()
       obj(steps: 10, eligibleStep: 2)
    }
    
    func testCanPartitionKSubsets() {
        let obj = CanPartitionKSubsets()
//        XCTAssertEqual(obj.canPartitionKSubsets([4,5,2,3,5,0,1], 4), true)
        XCTAssertEqual(obj.canPartitionKSubsets([10,1,10,9,6,1,9,5,9,10,7,8,5,2,10,8], 11), true)
//        XCTAssertEqual(obj.canPartitionKSubsets([1,2,3,4], 3), false)
    }
    
    func testWordSquares() {
        let obj = WordSquares()
        XCTAssertEqual(obj(wordList: ["ball","area","lead","lady"]), [["ball","area","lead","lady"]])
        XCTAssertEqual(obj(wordList: ["area","lead","wall","lady","ball"]), [["wall","area","lead","lady"],["ball","area","lead","lady"]])
    }
    
    func testWordPatternII() {
        let obj = WordPatternII()
        XCTAssertEqual(obj.wordPatternMatch("abab", "redblueredblue"), true)
        XCTAssertEqual(obj.wordPatternMatch("aaaa", "asdasdasdasd"), true)
        XCTAssertEqual(obj.wordPatternMatch("aabb", "xyzabcxzyabc"), false)
    }
    
    func testFloodFill() {
        let obj = FloodFill()
        XCTAssertEqual(obj([[1,1,1],[1,1,0],[1,0,1]], 1, 1, 2), [[2,2,2],[2,2,0],[2,0,1]])
        XCTAssertEqual(obj([[0,0,0],[0,0,0]], 0, 0, 2), [[2,2,2],[2,2,2]])
    }
    
    func testReconstructItinerary() {
        let obj = ReconstructItinerary()
        XCTAssertEqual(obj([["MUC","LHR"],["JFK","MUC"],["SFO","SJC"],["LHR","SFO"]]), ["JFK","MUC","LHR","SFO","SJC"])
        XCTAssertEqual(obj([["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]), ["JFK","ATL","JFK","SFO","ATL","SFO"])
    }
    
    func testMaxAreaOfIsland() {
        let obj = MaxAreaOfIsland()
        XCTAssertEqual(obj([
            [0,0,1,0,0,0,0,1,0,0,0,0,0],
            [0,0,0,0,0,0,0,1,1,1,0,0,0],
            [0,1,1,0,1,0,0,0,0,0,0,0,0],
            [0,1,0,0,1,1,0,0,1,0,1,0,0],
            [0,1,0,0,1,1,0,0,1,1,1,0,0],
            [0,0,0,0,0,0,0,0,0,0,1,0,0],
            [0,0,0,0,0,0,0,1,1,1,0,0,0],
            [0,0,0,0,0,0,0,1,1,0,0,0,0]
        ]), 6)
        XCTAssertEqual(obj([
            [0,0,0,0,0,0,0,0]
        ]), 0)
    }
    
    func testFindEventualSafeStates() {
        let obj = FindEventualSafeStates()
        XCTAssertEqual(obj([[1,2],[2,3],[5],[0],[5],[],[]]), [2,4,5,6])
    }
    
    func testNumberOfClosedIslands() {
        let obj = NumberOfClosedIslands()
        XCTAssertEqual(obj.dfsWithBitManipulation([[1,1,1,1,1,1,1,0],[1,0,0,0,0,1,1,0],[1,0,1,0,1,1,1,0],[1,0,0,0,0,1,0,1],[1,1,1,1,1,1,1,0]]), 2)
        XCTAssertEqual(obj.dfsWithBitManipulation([[0,0,1,0,0],[0,1,0,1,0],[0,1,1,1,0]]), 1)
        XCTAssertEqual(obj.dfsWithBitManipulation([[0,0,1,1,0,1,0,0,1,0],[1,1,0,1,1,0,1,1,1,0],[1,0,1,1,1,0,0,1,1,0],[0,1,1,0,0,0,0,1,0,1],[0,0,0,0,0,0,1,1,1,0],[0,1,0,1,0,1,0,1,1,1],[1,0,1,0,1,1,0,0,0,1],[1,1,1,1,1,1,0,0,0,0],[1,1,1,0,0,1,0,1,0,1],[1,1,1,0,1,1,0,1,1,0]]), 5)

        XCTAssertEqual(obj.dfs([[1,1,1,1,1,1,1,0],[1,0,0,0,0,1,1,0],[1,0,1,0,1,1,1,0],[1,0,0,0,0,1,0,1],[1,1,1,1,1,1,1,0]]), 2)
        XCTAssertEqual(obj.dfs([[0,0,1,0,0],[0,1,0,1,0],[0,1,1,1,0]]), 1)
        //TODO: check why it's failing
//        XCTAssertEqual(obj.dfs([
//            [0,0,1,1,0,1,0,0,1,0],
//            [1,1,0,1,1,0,1,1,1,0],
//            [1,0,1,1,1,0,0,1,1,0],
//            [0,1,1,0,0,0,0,1,0,1],
//            [0,0,0,0,0,0,1,1,1,0],
//            [0,1,0,1,0,1,0,1,1,1],
//            [1,0,1,0,1,1,0,0,0,1],
//            [1,1,1,1,1,1,0,0,0,0],
//            [1,1,1,0,0,1,0,1,0,1],
//            [1,1,1,0,1,1,0,1,1,0]
//        ]), 5)
    }
    
    func testNumberOfEnclaves() {
        let obj = NumberOfEnclaves()
        XCTAssertEqual(obj([[0,0,0,0],[1,0,1,0],[0,1,1,0],[0,0,0,0]]), 3)
        XCTAssertEqual(obj([[0,1,1,0],[0,0,1,0],[0,0,1,0],[0,0,0,0]]), 0)
    }
    
    func testKeysAndRooms() {
        let obj = KeysAndRooms()
        XCTAssertEqual(obj.dfs([[1],[2],[3],[]]), true)
        XCTAssertEqual(obj.dfs([[1,3],[3,0,1],[2],[0]]), false)
        
        XCTAssertEqual(obj.bfs([[1],[2],[3],[]]), true)
        XCTAssertEqual(obj.bfs([[1,3],[3,0,1],[2],[0]]), false)
    }
    
    func testFindTownJudge() {
        let obj = FindTownJudge()
        XCTAssertEqual(obj(2, [[1,2]]), 2)
    }
    
    func testRegionCutBySlashes() {
        let obj = RegionCutBySlashes()
        XCTAssertEqual(obj.regionsBySlashes([" /","/ "]), 2)
    }
    
    func testFindKSmallestPairs() {
        let obj = FindKSmallestPairs()
        XCTAssertEqual(obj([1,7,11], [2,4,6], 3), [[1,2],[1,4],[1,6]])
    }
}
