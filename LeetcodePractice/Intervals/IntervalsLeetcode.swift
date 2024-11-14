//
//  IntervalsLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 27/09/24.
//

import Foundation

/*
 link: https://leetcode.com/problems/insert-interval/description/
 Explanation:
 Primary idea:
 Three conditions to check for
 1. if the new interval ends before the iterating interval start then we should position the new interval there
 2. if the new interval doesn't end before the iterating interval then it might be positioned later
 3. check if the new interval and iterating interval overlaps then just merge and form the new interval
 Time Complexity: O(N)
 Space: Complexity: O(N)
 */
class InsertInterval {
    
    func callAsFunction(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        var result = [[Int]](), newInterval = newInterval
        for i in 0..<intervals.count {
            let currentInterval = intervals[i]
            if newInterval[1] < currentInterval[0] {
                result.append(newInterval)
                result += intervals[i...]
                return result
            } else if currentInterval[1] < newInterval[0] {
                result.append(currentInterval)
            } else {
                newInterval[0] = min(currentInterval[0], newInterval[0])
                newInterval[0] = max(currentInterval[1], newInterval[1])
            }
        }
        result.append(newInterval)
        return result
    }
    
    //Most optimal
    func usingBinarySearch(_ intervals: [[Int]], _ newInterval: [Int]) {
        // To Do
    }
}

/*
 link: https://leetcode.com/problems/insert-interval/description/
 Explanation:
 Primary idea:
 Three conditions to check for
 1. if the new interval ends before the iterating interval start then we should position the new interval there
 2. if the new interval doesn't end before the iterating interval then it might be positioned later
 3. check if the new interval and iterating interval overlaps then just merge and form the new interval
 Time Complexity:
 Space: Complexity:
 */
//class MeetingRoomII {
//    func callAsFunction(_ intervals: [[Int]]) -> Int {
//        var startArr = [Int](), endArr = [Int]()
//        for interval in intervals {
//            startArr.append(interval[0])
//            endArr.append(interval[1])
//        }
//        
//        var startPosition = 0, endPosition = 0
//        var meetingRooms = 0
//        while startPosition < intervals.count, endPosition < intervals.count {
//            if startArr[startPosition] < endArr[endPosition] {
//                meetingRooms += 1
//                startPosition += 1
//            } else {
//                meetingRooms -= 1
//                endPosition += 1
//            }
//        }
//        return meetingRooms
//    }
//}


/*
 link: https://leetcode.com/problems/minimum-number-of-arrows-to-burst-balloons
 Explanation: https://youtu.be/lPmkKnvNPrw
 Primary idea:
 Time Complexity: O(N log N) due to sorting and then going through list of points
 Space: Complexity: O(N)
 */
class MinimumNumberOfArrowsToBurstBalloons {
    func callAsFunction(_ points: [[Int]]) -> Int {
        let points = points.sorted { point1, point2 in
            if point1[0] != point2[1] {
                return point1[0] < point2[0]
            } else {
                return point1[1] < point2[1]
            }
        }
        
        var result = points.count
        var prev = points[0]
        
        for i in 1..<points.count {
            let current = points[i]
            
            if prev[1] >= current[0] {
                result -= 1
                prev = [current[0], min(prev[1], current[1])]
            } else {
                prev = current
            }
        }
        return result
    }
}
