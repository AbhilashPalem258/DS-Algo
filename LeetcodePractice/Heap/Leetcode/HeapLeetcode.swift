//
//  HeapLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 24/02/22.
//

import Foundation

class LongestHappyString {
    func callAsFunction(_ a: Int, _ b: Int, _ c: Int) -> String {
        var heap = RHeap(array: [("a", a), ("b", b), ("c", c)].filter{$0.1 > 0}, sort: {$0.1 > $1.1})
        var res = [String]()
        
        while !heap.isEmpty {
            var (char1, count1) = heap.remove()!
            if res.count > 1 && res[res.count - 1] == char1 && res[res.count - 2] == char1 {
                if heap.isEmpty {
                    break
                }
                var (char2, count2) = heap.remove()!
                res.append(char2)
                count2 -= 1
                if count2 != 0 {
                    heap.insert((char2, count2))
                }
            } else {
                res.append(char1)
                count1 -= 1
            }
            if count1 > 0 {
                heap.insert((char1, count1))
            }
        }
        return res.joined()
    }
}

//https://www.youtube.com/watch?v=hOjcdrqMoQ8
class KthLargestElementInAStream {
    var minheap: RHeap<Int>
    let k: Int
    init(_ k: Int, _ nums: [Int]) {
        self.k = k
        minheap = RHeap(array: nums, sort: <)
        while minheap.count > k {
            minheap.remove()
        }
    }
    
    func add(_ val: Int) -> Int {
        minheap.insert(val)
        if minheap.count > k {
            minheap.remove()
        }
        return minheap.peek()!
    }
}

class SortCharactersByFrequency {
    func callAsFunction(_ s: String) -> String {
        var sMap = [Character: Int]()
        for char in s {
            sMap[char, default: 0] += 1
        }
        
        var arr = [(character: Character, frequency: Int)]()
        for (char, freq) in sMap {
            arr.append((char, freq))
        }
        
        var maxHeap = RHeap(array: arr, sort: {$0.frequency > $1.frequency})
        
        var result = ""
        while !maxHeap.isEmpty {
            let (char, freq) = maxHeap.remove()!
            for _ in 0..<freq {
                result.append(char)
            }
        }
        return result
    }
}

class KclosestPointsToOrigin {
    func callAsFunction(_ points: [[Int]], _ k: Int) -> [[Int]] {
        var maxHeap = RHeap<(point: [Int], distance: Double)>(array: [], sort: {$0.distance > $1.distance})
        for point in points {
            let distance = sqrt(Double(point[0] * point[0]) + Double(point[1] * point[1]))
            maxHeap.insert((point, distance))
        }
        
        while maxHeap.count > k {
            maxHeap.remove()
        }
        
        var result = [[Int]]()
        while !maxHeap.isEmpty {
            result.append(maxHeap.remove()!.point)
        }
        return result
    }
    
    //self wrote. More efficient
    func solution2(_ points: [[Int]], _ k: Int) -> [[Int]] {
        var minHeap = RHeap(array: points) { point1, point2 in
            let point1dist = sqrt(Double((point1[0] * point1[0]) + (point1[1] * point1[1])))
            let point2dist = sqrt(Double((point2[0] * point2[0]) + (point2[1] * point2[1])))
            return point1dist < point2dist
        }
        
        var result = [[Int]]()
        for _ in 0..<k {
            result.append(minHeap.remove()!)
        }
        
        return result
    }
}

//TimeComplexity: O(2n + 2(nlogn)) == O(nlogn)
class ReorganizeString {
    func callAsFunction(_ s: String) -> String {
        var sMap = [Character: Int]()
        for char in s {
            sMap[char, default: 0] += 1
        }
        
        var maxHeap = RHeap<(character: Character, freq: Int)>(array: [], sort: {$0.freq > $1.freq})
        for (char, count) in sMap {
            maxHeap.insert((char, count))
        }
        
        var result = [Character]()
        while !maxHeap.isEmpty {
            var (char1, count1) = maxHeap.remove()!
            if !result.isEmpty && result.last! == char1 {
                if maxHeap.isEmpty {
                    return ""
                }
                var (char2, count2) = maxHeap.remove()!
                result.append(char2)
                count2 -= 1
                if count2 != 0 {
                    maxHeap.insert((char2, count2))
                }
            } else {
                result.append(char1)
                count1 -= 1
            }
            if count1 > 0 {
                maxHeap.insert((char1, count1))
            }
        }
        return String(result)
    }
}


class DesignTwitter {

    private var followMap: [Int: Set<Int>]
    private var userToTweetMap: [Int: [(timestamp: Int, tweetId: Int)]]
    private var count = 0
    
    init() {
        followMap = [:]
        userToTweetMap = [:]
    }
    
    //O(1)
    func postTweet(_ userId: Int, _ tweetId: Int) {
        userToTweetMap[userId, default: []].append((count, tweetId))
        count += 1
    }
    
    func getNewsFeed(_ userId: Int) -> [Int] {
        var res = [Int]()
        var maxHeap = RHeap<(timestamp: Int, tweetId: Int, followee: Int, index: Int)>(array: [], sort: >)
        self.followMap[userId, default: Set()].insert(userId)
        for followee in followMap[userId]! where userToTweetMap[followee] != nil {
            let index = userToTweetMap[followee]!.count - 1
            let (timestamp, tweetid) = userToTweetMap[followee]![index]
            maxHeap.insert((timestamp, tweetid, followee, index - 1))
        }
        
        while !maxHeap.isEmpty && res.count < 10 {
            var (timestamp, tweetid, followee, index) = maxHeap.remove()!
            res.append(tweetid)
            if index >= 0 {
                (timestamp, tweetid) = userToTweetMap[followee]![index]
                maxHeap.insert((timestamp, tweetid, followee, index - 1))
            }
        }
        return res
    }
    
    //O(1)
    func follow(_ followerId: Int, _ followeeId: Int) {
        self.followMap[followerId, default: Set()].insert(followeeId)
    }
    
    //O(n)
    func unfollow(_ followerId: Int, _ followeeId: Int) {
        if let followees = self.followMap[followerId] {
            self.followMap[followerId] = followees.filter{$0 != followeeId}
        }
    }
}

class MinimumNumberOfRefuelingStops {
    func callAsFunction(_ target: Int, _ startFuel: Int, _ stations: [[Int]]) -> Int {
        var result = 0, fuel = startFuel
        var maxheap = RHeap<Int>(array: [], sort: >)
        let stations = stations + [[target, 0]]
        
        for station in stations {
            while fuel < station[0] {
                if maxheap.isEmpty {
                    return -1
                } else {
                    fuel += maxheap.remove()!
                    result += 1
                }
            }
            maxheap.insert(station[1])
        }
        return result
    }
}

/*
 problem:
 You are given two integer arrays nums1 and nums2 sorted in ascending order and an integer k.

 Define a pair (u, v) which consists of one element from the first array and one element from the second array.

 Return the k pairs (u1, v1), (u2, v2), ..., (uk, vk) with the smallest sums.
 
 Testcases:
 Example 1:
 Input: nums1 = [1,7,11], nums2 = [2,4,6], k = 3
 Output: [[1,2],[1,4],[1,6]]
 Explanation: The first 3 pairs are returned from the sequence: [1,2],[1,4],[1,6],[7,2],[7,4],[11,2],[7,6],[11,4],[11,6]
 
 Example 2:
 Input: nums1 = [1,1,2], nums2 = [1,2,3], k = 2
 Output: [[1,1],[1,1]]
 Explanation: The first 2 pairs are returned from the sequence: [1,1],[1,1],[1,2],[2,1],[1,2],[2,2],[1,3],[1,3],[2,3]
 
 Example 3:
 Input: nums1 = [1,2], nums2 = [3], k = 3
 Output: [[1,3],[2,3]]
 Explanation: All possible pairs are returned from the sequence: [1,3],[2,3]
 
 Constraints:
 1 <= nums1.length, nums2.length <= 105
 -109 <= nums1[i], nums2[i] <= 109
 nums1 and nums2 both are sorted in ascending order.
 1 <= k <= 104
 
 link: https://leetcode.com/problems/find-k-pairs-with-smallest-sums/
 explanation:
 primary idea:
 - https://leetcode.com/problems/find-k-pairs-with-smallest-sums/discuss/1788922/Python-O(k-log-k)
 - First visit (0, 0), then insert (0, 1), (1, 0) to heap
 Time Complexity: O(K log k)
 Space Complexity: O(n)
 */

class FindKSmallestPairs {
    func callAsFunction(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [[Int]] {
        if !(nums1.count > 0 && nums2.count > 0) {
            return []
        }
        var used_indice_pairs = Set<[Int]>()
        var minHeap = RHeap<(pair: (Int, Int), sum: Int)>(array: [], sort: {$0.sum<$1.sum})
        minHeap.insert(((0, 0), nums1[0] + nums2[0]))
        
        var res = [[Int]]()
        while res.count < k && !minHeap.isEmpty {
            let indicesPair = minHeap.remove()!.pair
            res.append([nums1[indicesPair.0], nums2[indicesPair.1]])
            for nextPair in [(indicesPair.0 + 1, indicesPair.1), (indicesPair.0, indicesPair.1 + 1)] {
                if nextPair.0 < nums1.count && nextPair.1 < nums2.count  && !used_indice_pairs.contains([nextPair.0, nextPair.1]) {
                    minHeap.insert((nextPair, nums1[nextPair.0] + nums2[nextPair.1]))
                    used_indice_pairs.insert([nextPair.0, nextPair.1])
                }
            }
        }
        return res
    }
}

//https://leetcode.com/problems/find-median-from-data-stream/
class MedianFinder {
    var smallHeap = RHeap<Int>(array: [], sort: {$0>$1})
    var largeHeap = RHeap<Int>(array: [], sort: {$0<$1})
    
    init() {}
    
    func addNum(_ num: Int) {
        smallHeap.insert(num)
        
        if !smallHeap.isEmpty && !largeHeap.isEmpty && smallHeap.peek()! > largeHeap.peek()! {
            let popedVal = smallHeap.remove()!
            largeHeap.insert(popedVal)
        }
        
        if abs(smallHeap.count - largeHeap.count) > 1 {
            if smallHeap.count > largeHeap.count {
                if let popedVal = smallHeap.remove() {
                    largeHeap.insert(popedVal)
                }
            } else {
                if let popedVal = largeHeap.remove() {
                    smallHeap.insert(popedVal)
                }
            }
        }
    }
    
    func findMedian() -> Double {
        if smallHeap.count > largeHeap.count {
            return Double(smallHeap.peek()!)
        }
        if largeHeap.count > smallHeap.count {
            return Double(largeHeap.peek()!)
        }
        return Double(smallHeap.peek()! + largeHeap.peek()!)/2
    }
}
