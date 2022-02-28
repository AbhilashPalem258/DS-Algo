//
//  LeetcodeSort.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 13/07/21.
//

import Foundation

struct MergeSortedArrays {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var i = m-1, j = n-1
        while i >= 0 || j >= 0 {
            if j < 0 || (i>=0 && nums1[i] > nums2[j]){
                nums1[i + j + 1] = nums1[i]
                i -= 1
            } else {
                nums1[i + j + 1] = nums2[j]
                j -= 1
            }
        }
    }
}


/*
 link: https://leetcode.com/problems/sort-colors/
 explanation: https://www.youtube.com/watch?v=4xbWSRZHqac
 Time Complexity: O(n)
 Space Complexity: O(1)
 Primary Idea:
     - Two Pointer
     - --> L , R <--
     - Can also be solved with Bucket sort with complexities [O(n), O(n)]
 */
struct SortColors {
    func callAsFunction(_ nums: inout [Int]) {
        var red = 0, blue = nums.count - 1, i = 0
        
        while i < blue {
            if nums[i] == 0 {
                (nums[red], nums[i]) = (nums[i], nums[red])
                i += 1
                red += 1
            } else if nums[i] == 1 {
                i += 1
            } else {
                (nums[blue], nums[i]) = (nums[i], nums[blue])
                blue -= 1
            }
        }
    }
}

/*
 Given an unsorted array nums, reorder it in-place such that nums[0] <= nums[1] >= nums[2] <= nums[3]....

 For example, given nums = [3, 5, 2, 1, 6, 4], one possible answer is [1, 6, 2, 5, 3, 4].

 the pattern is number in odd position is peak.
 
 First try to solve it without in-place:
 - sort the array in increasing order.
 - create a result array of the same size.
 - keep 2 pointers, one from the beginning, one from the middle(notice odd/even of array).
 - put beginning first, then the middle pointer, into the result array.
 
 Solve it in-place.
 */
struct WiggleSort {
    func callAsFunction(_ nums: inout [Int]) {
        for i in 0..<nums.count where i % 2 == 0 {
            if i > 0, nums[i] > nums[i - 1] {
                (nums[i], nums[i - 1]) = (nums[i-1], nums[i])
            }
            if i+1 < nums.count, nums[i] > nums[i+1] {
                (nums[i], nums[i + 1]) = (nums[i+1], nums[i])
            }
        }
    }
    
    //Preferred
    func oddPositionSort(_ nums: inout [Int]) {
        for i in 0..<nums.count where i % 2 == 1 {
            if nums[i - 1] > nums[i] {
                (nums[i - 1], nums[i]) = (nums[i], nums[i - 1])
            }
            
            if i + 1 < nums.count && nums[i + 1] > nums[i] {
                (nums[i + 1], nums[i]) = (nums[i], nums[i + 1])
            }
        }
    }
}

struct WiggleSortII {
    func callAsFunction(_ nums: inout [Int]) {
        let temp = nums.sorted()
        var m = nums.count, n = (m+1)/2
        for i in 0..<nums.count {
            if i % 2 == 0 {
                n = n - 1
                nums[i] = temp[n]
            } else {
                m = m - 1
                nums[i] = temp[m]
            }
        }
    }
}

/*
 link: https://leetcode.com/problems/squares-of-a-sorted-array/
 */
struct SortedSquaresArr {
    func callAsFunction(_ nums: [Int]) -> [Int] {
        func getSquaredVal(_ i: Int) -> Int {
            return nums[i] * nums[i]
        }
        
        var res = [Int](repeating: 0, count: nums.count)
        var l = 0, r = nums.count - 1, index = res.count - 1
        while l <= r {
            if getSquaredVal(l) >= getSquaredVal(r) {
                res[index] = getSquaredVal(l)
                l += 1
            } else {
                res[index] = getSquaredVal(r)
                r -= 1
            }
            index -= 1
        }
        
        return res
    }
}

struct SortTransformedArr {
    func callAsFunction(_ nums: [Int], _ a: Int, _ b: Int, _ c: Int) -> [Int] {
        func getTransformedVal(_ i: Int) -> Int {
            return (a * nums[i] * nums[i]) + (b * nums[i]) + c
        }
        var res = [Int](repeating: 0, count: nums.count)
        var l = 0, r = nums.count - 1
        var index = (a >= 0) ? res.count - 1 : 0
        while l <= r {
            let lVal = getTransformedVal(l), rVal = getTransformedVal(r)
            
            if a >= 0 {
                if lVal >= rVal {
                    res[index] = lVal
                    l += 1
                } else {
                    res[index] = rVal
                    r -= 1
                }
                index -= 1
            } else {
                if lVal <= rVal {
                    res[index] = lVal
                    l += 1
                } else {
                    res[index] = rVal
                    r -= 1
                }
                index += 1
            }
        }
        return res
    }
}


//link: https://www.lintcode.com/problem/920/
struct MeetingRooms {
    
    public class Interval {
      public var start: Int
      public var end: Int
      public init(_ start: Int, _ end: Int) {
       self.start = start
       self.end = end
      }
    }
    
    func callAsFunction(intervals: [Interval]) -> Bool {
        guard intervals.count > 1 else {
            return true
        }
        
        let intervals = intervals.sorted() {
            if $0.start != $1.start {
                return $0.start < $1.start
            } else {
                return $0.end < $1.end
            }
        }
        
        for i in 0..<intervals.count - 1 {
            if intervals[i].end > intervals[i+1].start {
                return false
            }
        }
        return true
    }
}

/*
 link: https://www.lintcode.com/problem/919/
 */
struct MeetingRoomII {
    
    public class Interval {
      public var start: Int
      public var end: Int
      public init(_ start: Int, _ end: Int) {
       self.start = start
       self.end = end
      }
    }
    
    func callAsFunction(_ intervals: [[Int]]) -> Int {
        let count = intervals.count
        let startArr = intervals.map { $0[0] }.sorted()
        let endArr = intervals.map { $0[1] }.sorted()
        var meetingRooms = 0
        
        var l = 0, r = 0
        while l < count, r < count  {
            if startArr[l] < endArr[r] {
                meetingRooms += 1
                l += 1
            } else {
                meetingRooms -= 1
                r += 1
            }
        }
        return meetingRooms
    }
}

/*
 link: https://leetcode.com/problems/merge-intervals/
 */
class MergeIntervals {
    func callAsFunction(_ intervals: [[Int]]) -> [[Int]] {
        let intervals = intervals.sorted {
            if $0[0] != $1[0] {
                return $0[0] < $1[0]
            } else {
                return $0[1] < $1[1]
            }
        }
        
        var stack = [intervals[0]]
        for i in 1..<intervals.count {
            let current = intervals[i]
            if let last = stack.last, last[1] >= current[0] {
                stack.removeLast()
                stack.append([last[0], max(last[1] , current[1])])
            } else {
                stack.append(current)
            }
        }
        
        return stack
    }
}


/*
 problem:
 Given an array intervals where intervals[i] = [li, ri] represent the interval [li, ri), remove all intervals that are covered by another interval in the list.

 The interval [a, b) is covered by the interval [c, d) if and only if c <= a and b <= d.

 Return the number of remaining intervals.
 
 Testcases:
 Input: intervals = [[1,4],[3,6],[2,8]]
 Output: 2
 Explanation: Interval [3,6] is covered by [2,8], therefore it is removed.
 
 Input: intervals = [[1,4],[2,3]]
 Output: 1
 
 
 Constraints:
 1 <= intervals.length <= 1000
 intervals[i].length == 2
 0 <= li <= ri <= 105
 All the given intervals are unique.
 
 
 link: https://leetcode.com/problems/remove-covered-intervals/
 explanation: https://www.youtube.com/watch?v=nhAsMabiVkM
 primary idea:
 - Sort intervals in decreasing order such that the largest interval comes first
 - Use stack to evaluate if the prev interval covers current one
 Time Complexity: O(nlogn + n)
 Space Complexity: O(n)
 */
class RemoveCoveredIntervals {
    func callAsFunction(_ intervals: [[Int]]) -> Int {
        let intervals = intervals.sorted {
            if $0[0] == $1[0] {
                return $0[1] < $1[1]
            }
            return $0[0] < $1[0]
        }
        var stack = [[Int]]()
        
        for currentInterval in intervals {
            if let prev = stack.last {
                if prev[0] <= currentInterval[0] && currentInterval[1] <= prev[1] {
                    continue
                }
                stack.append(currentInterval)
            } else {
                stack.append(currentInterval)
            }
        }
        return stack.count
    }
}

class NonOverlappingIntervals {
    func callAsFunction(_ intervals: [[Int]]) -> Int {
        let intervals = intervals.sorted {
            if $0[0] == $1[0] {
                return $0[1] < $1[1]
            }
            return $0[0] < $1[0]
        }
        
        var res = 0
        var prevEnd = intervals[0][1]
        for i in 1..<intervals.count {
            let interval = intervals[i]
            let start = interval[0], end = interval[1]
            if start >= prevEnd {
                prevEnd = end
            } else {
                res += 1
                prevEnd = min(prevEnd, end)
            }
        }
        
        return res
    }
}

struct FindKthLargest {
    func callAsFunction(_ nums: [Int], _ k: Int) -> Int {
        guard nums.count >= k else {
            return -1
        }
        
        var nums = nums
        var l = 0, r = nums.count - 1
        while true {
            let pivotIndex = qs(&nums, l: l, r: r)
            if pivotIndex == (k - 1) {
                return nums[pivotIndex]
            } else if pivotIndex > (k - 1) {
                r = pivotIndex - 1
            } else {
                l = pivotIndex + 1
            }
        }
    }
    
    func qs(_ nums: inout [Int], l: Int, r: Int) -> Int {
        let pivot = nums[r]
        var left = l - 1
        for i in l...r {
            if nums[i] >= pivot {
                left += 1
                (nums[i], nums[left]) = (nums[left], nums[i])
            }
        }
        return left
    }
}

struct ArrayPartitionI {
    func callAsFunction(_ nums: [Int]) -> Int {
        let nums = nums.sorted()
        var sum = 0
        var i = 0
        while i < nums.count {
            sum += min(nums[i], nums[i+1])
            i += 2
        }
        return sum
    }
}
/*
 link: https://leetcode.com/problems/insert-interval/
 */
class InsertInterval {
    func insert(_ intervals: [[Int]], _ newInterval1: [Int]) -> [[Int]] {
        var newInterval = newInterval1, result = [[Int]]()
        var isInserted = false
        for interval in intervals {
            if newInterval[1] < interval[0] {
                if !isInserted {
                    result.append(newInterval)
                    isInserted = true
                }
                result.append(interval)
            } else if interval[1] < newInterval[0] {
                result.append(interval)
            } else {
                newInterval[0] = min(interval[0], newInterval[0])
                newInterval[1] = max(interval[1], newInterval[1])
            }
        }
        if !isInserted {
            result.append(newInterval)
        }
        return result
    }
}

struct LargestNumber {
    /*
    Complexity:
        TC: O(NLOGN)
        SC: O(N)
    */
    func callAsFunction(_ nums: [Int]) -> String {
        var strNums = [String]()
        for num in nums {
            strNums.append("\(num)")
        }
        strNums.sort {
            return $0 + $1 > $1 + $0
        }
        
        var result = ""
        for val in strNums {
            result += val
        }
        
        return result.first == "0" ? "0" : result
    }
}

struct TopKFrequentElements {
    func callAsFunction(_ nums: [Int], _ k: Int) -> [Int] {
        var k = k
        var eleToCountMap = [Int: Int](), topFCount = 0, result = [Int]()
        for num in nums {
            eleToCountMap[num, default: 0] += 1
            topFCount = max(topFCount, eleToCountMap[num, default: 0])
        }
        var countToElementArr = [[Int]](repeating: [], count: topFCount + 1)
        for (element, count) in eleToCountMap {
            countToElementArr[count].append(element)
        }
        var j = topFCount
        outerloop: while j >= 0 {
            for element in countToElementArr[j] {
                result.append(element)
                k -= 1
                if k == 0 {
                    break outerloop
                }
            }
            j -= 1
        }
        return result
    }
}

class TopKFrequentWords {
    func topKFrequent(_ words: [String], _ k: Int) -> [String] {
        var wordMap = [String: Int](), k = k
        var topFCount = 0
        for word in words {
            wordMap[word, default: 0] += 1
            topFCount = max(topFCount, wordMap[word]!)
        }
        
        var countToWordArr = [[String]](repeating: [], count: topFCount+1)
        for (word, count) in wordMap {
            countToWordArr[count].append(word)
        }
        
        var result = [String]()
        var j = topFCount
        outerloop: while j >= 0 {
            for word in countToWordArr[j].sorted() {
                result.append(word)
                k -= 1
                if k == 0 {
                    break outerloop
                }
            }
            j -= 1
        }
        return result
    }
}
