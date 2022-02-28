//
//  BFSLeetcode.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 24/07/21.
//

import XCTest
@testable import LeetcodePractice

class BFSLeetcode: XCTestCase {

    func testWordLadder() {
        let obj = WordLadder()
        XCTAssertEqual(obj("hit", "cog",  ["hot","dot","dog","lot","log","cog"]), 5)
        XCTAssertEqual(obj("hit", "cog",  ["hot","dot","dog","lot","log"]), 0)
    }

    func testEvaluateDivision() {
        let obj = EvaluateDivision()
        XCTAssertEqual(obj.calcEquation([["a","b"],["b","c"]], [2.0,3.0], [["a","c"],["b","a"],["a","e"],["a","a"],["x","x"]]), [6.00000,0.50000,-1.00000,1.00000,-1.00000])
        XCTAssertEqual(obj.calcEquation([["a","b"],["c","d"]], [1.0,1.0], [["a","c"],["b","d"],["b","a"],["d","c"]]), [-1.00000,-1.00000,1.00000,1.00000])
    }
    
    func testShortestDistanceAllBuildings() {
        let obj = ShortestDistanceAllBuildings()
        XCTAssertEqual(obj.shortestDistance([[1,0,2,0,1],[0,0,0,0,0],[0,0,1,0,0]]), 7)
    }
    
    func testShortestPathBinaryMatrix() {
        let obj = ShortestPathBinaryMatrix()
        XCTAssertEqual(obj([[0,1],[1,0]]), 2)
        XCTAssertEqual(obj([[0,0,0],[1,1,0],[1,1,0]]), 4)
        XCTAssertEqual(obj([[1,0,0],[1,1,0],[1,1,0]]), -1)
    }
    
    func testAsFarFromLandAsPossible() {
        let obj = AsFarFromLandAsPossible()
        XCTAssertEqual(obj([[1,0,1],[0,0,0],[1,0,1]]), 2)
        XCTAssertEqual(obj([[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]), -1)
        
        XCTAssertEqual(obj.maxDistance([[1,0,1],[0,0,0],[1,0,1]]), 2)
        XCTAssertEqual(obj.maxDistance([[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]), -1)
    }
    
    func testRottingOranges() {
        let obj = RottingOranges()
        XCTAssertEqual(obj([[2,1,1],[1,1,0],[0,1,1]]), 4)
        XCTAssertEqual(obj([[2,1,1],[0,1,1],[1,0,1]]), -1)
        XCTAssertEqual(obj([[0,2]]), 0)
    }
    
    func testOpenTheLock() {
        let obj = OpenTheLock()
        XCTAssertEqual(obj(["0201","0101","0102","1212","2002"], "0202"), 6)
        XCTAssertEqual(obj(["8888"], "0009"), 1)
        XCTAssertEqual(obj(["8887","8889","8878","8898","8788","8988","7888","9888"], "8888"), -1)
    }
    
    func testSnakesAndLadders() {
        let obj = SnakesAndLadders()
        XCTAssertEqual(obj([[-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1],[-1,35,-1,-1,13,-1],[-1,-1,-1,-1,-1,-1],[-1,15,-1,-1,-1,-1]]), 4)
        XCTAssertEqual(obj([[-1,-1],[-1,3]]), 1)
//        XCTAssertEqual(obj(["8888"], "0009"), 1)
//        XCTAssertEqual(obj(["8887","8889","8878","8898","8788","8988","7888","9888"], "8888"), -1)
    }
    
    func testCutOffTreesForAGolfEvent() {
        let obj = CutOffTreesForAGolfEvent()
        XCTAssertEqual(obj([[1,2,3],[0,0,4],[7,6,5]]), 6)
        XCTAssertEqual(obj([[1,2,3],[0,0,0],[7,6,5]]), -1)
        XCTAssertEqual(obj([[56617,47231,24237,22280,3005,10630,79562,90622,41623,96953,49499,22104,17942,85468,71607,80196,0,19359,57729,10524,0,16264,92606,86811,88220,50916,51862,75190,68322,68225,76182,65038,10568,99985,13666,44829,35086,8875,69000,67012],[39118,77960,38396,66408,75433,31501,76594,71328,0,72890,70316,59280,11955,0,58342,52935,56468,96413,0,0,0,65835,72685,27593,0,0,44940,80743,49690,96146,22671,35997,86551,8144,15615,44281,31649,30011,11009,98473],[17431,98660,14736,13227,99325,43277,25481,55181,73205,38327,90752,26489,26837,77293,64694,16839,0,11577,45516,94677,0,66331,87943,24759,65064,0,60642,48599,742,38053,0,93955,38154,79089,93314,26822,94919,64059,93134,0],[81575,96701,14011,31751,84906,67676,33565,44406,11000,66642,36772,93971,44369,89750,78813,99396,80249,0,22531,0,41009,64547,0,4958,68638,65300,58221,74384,15925,98842,92817,15560,85571,10938,77779,34798,0,85231,54405,6808],[46458,72404,98061,5779,54901,15010,64514,33715,0,96018,58533,12090,0,69143,64483,74090,49430,74003,37900,8960,48670,8708,42415,44604,75290,11736,86367,98527,21526,54807,37040,54407,15866,8326,29623,14570,30453,90589,60563,87278],[1148,98611,18967,47309,23697,61630,24469,0,0,56481,67253,31395,34800,30270,97478,67104,43770,7145,87219,70561,38292,35885,83475,36700,87317,99436,47376,96501,20654,58233,83624,98364,0,55811,37887,64461,91359,48140,94241,19261],[81343,23420,81010,62236,97990,8529,0,39505,5238,90359,71949,76447,17455,58571,80822,99268,90434,20548,8352,50243,47532,17441,98153,69459,54712,50091,32061,67319,24741,64162,32592,80872,84779,94065,60478,35167,63241,17204,45036,81085],[73063,21341,50047,1927,35779,87151,54520,0,4089,74814,24515,27239,37370,0,70395,29610,13331,59797,99222,35396,27207,43232,15330,0,0,81836,0,66707,2509,51487,83203,0,97001,67081,62448,48774,81933,0,15198,59436],[11917,93710,13127,57696,14604,46362,55927,31255,71865,43570,18266,39446,60802,2330,93689,9609,0,81057,51759,86188,92999,56247,4610,81084,1722,18158,31966,0,47551,8927,26448,53919,76270,41641,63218,10867,70660,55295,0,7227]]), 5577)
    }
    
    func testGetWatchedVideosbyYourFriends() {
        let obj = GetWatchedVideosbyYourFriends()
        XCTAssertEqual(obj([["A","B"],["C"],["B","C"],["D"]], [[1,2],[0,3],[0,3],[1,2]], 0, 1), ["B","C"])
        XCTAssertEqual(obj([["A","B"],["C"],["B","C"],["D"]], [[1,2],[0,3],[0,3],[1,2]], 0, 2), ["D"])
    }
    
    func testZeroOneMatrix() {
        let obj = ZeroOneMatrix()
        XCTAssertEqual(obj([[0,0,0],[0,1,0],[0,0,0]]), [[0,0,0],[0,1,0],[0,0,0]])
        XCTAssertEqual(obj([[0,0,0],[0,1,0],[1,1,1]]), [[0,0,0],[0,1,0],[1,2,1]])
    }
    
    func testEmployeeImportance() {
        let obj = EmployeeImportance()
        XCTAssertEqual(obj.getImportance([
            .init(1,5,[2,3]),
            .init(2,3,[]),
            .init(3,3,[]),
        ], id: 1), 11)
    }
    
    func testTimeNeededToInformAllEmployees() {
        let obj = TimeNeededToInformAllEmployees()
        XCTAssertEqual(obj.bfs(1, 0, [-1], [0]), 0)
        XCTAssertEqual(obj.bfs(6, 2, [2,2,-1,2,2,2], [0,0,1,0,0,0]), 1)
        
        XCTAssertEqual(obj.dfs(1, 0, [-1], [0]), 0)
        XCTAssertEqual(obj.dfs(6, 2, [2,2,-1,2,2,2], [0,0,1,0,0,0]), 1)
    }
    
    func testShortestPathInAGridWithObstacles() {
        let obj = ShortestPathInAGridWithObstacles()
        XCTAssertEqual(obj([[0,0,0],[1,1,0],[0,0,0],[0,1,1],[0,0,0]], 1), 6)
        XCTAssertEqual(obj([[0,1,1],[1,1,1],[1,0,0]], 1), -1)
        XCTAssertEqual(obj([
            [0,0],
            [1,0],
            [1,0],
            [1,0],
            [1,0],
            [1,0],
            [0,0],
            [0,1],
            [0,1],
            [0,1],
            [0,0],
            [1,0],
            [1,0],
            [0,0]
        ], 4), 14)
    }
}
