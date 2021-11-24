//
//  SearchLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 11/07/21.
//

import Foundation
import Darwin

/*
 problem:
 There is an integer array nums sorted in ascending order (with distinct values).

 Prior to being passed to your function, nums is rotated at an unknown pivot index k (0 <= k < nums.length) such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed). For example, [0,1,2,4,5,6,7] might be rotated at pivot index 3 and become [4,5,6,7,0,1,2].

 Given the array nums after the rotation and an integer target, return the index of target if it is in nums, or -1 if it is not in nums.

 You must write an algorithm with O(log n) runtime complexity.
 
 Testcases:
 Input: nums = [4,5,6,7,0,1,2], target = 0
 Output: 4

 Input: nums = [4,5,6,7,0,1,2], target = 3
 Output: -1

 Input: nums = [1], target = 0
 Output: -1
 
 Constraints:
 1 <= nums.length <= 5000
 -104 <= nums[i] <= 104
 All values of nums are unique.
 nums is guaranteed to be rotated at some pivot.
 -104 <= target <= 104
 
 link: https://leetcode.com/problems/search-in-rotated-sorted-array/
 explanation: https://www.youtube.com/watch?v=U8XENwh8Oy8
 primary idea:
 - Binary search
 - Check if mid is equal to target
 - else whether mid is in left sorted portion or right and update bounds.
 Time Complexity: O(log n)
 Space Complexity: O(1)
 */
struct SearchRotatedSortedArr {
    func callAsFunction(_ nums: [Int], _ target: Int) -> Int {
        var lower = 0, upper = nums.count-1
        
        while lower <= upper {
            let midId = (lower + upper)/2
            if target == nums[midId] {
                return midId
            }
            
            if nums[lower] <= nums[midId] {
                if target > nums[midId] || target < nums[lower] {
                    lower = midId + 1
                } else {
                    upper = midId - 1
                }
            } else {
                if target > nums[upper] || target < nums[midId] {
                    upper = midId - 1
                } else {
                    lower = midId + 1
                }
            }
        }
        
        return -1
    }
}

/*
 problem:
 There is an integer array nums sorted in non-decreasing order (not necessarily with distinct values).

 Before being passed to your function, nums is rotated at an unknown pivot index k (0 <= k < nums.length) such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed). For example, [0,1,2,4,4,4,5,6,6,7] might be rotated at pivot index 5 and become [4,5,6,6,7,0,1,2,4,4].

 Given the array nums after the rotation and an integer target, return true if target is in nums, or false if it is not in nums.

 You must decrease the overall operation steps as much as possible.
 
 Testcases:
 Input: nums = [2,5,6,0,0,1,2], target = 0
 Output: true

 Input: nums = [2,5,6,0,0,1,2], target = 3
 Output: false
 
 Constraints:
 1 <= nums.length <= 5000
 -104 <= nums[i] <= 104
 nums is guaranteed to be rotated at some pivot.
 -104 <= target <= 104
 
 link: https://leetcode.com/problems/search-in-rotated-sorted-array-ii/
 explanation: https://www.youtube.com/watch?v=U8XENwh8Oy8
 primary idea:
     - Binary search
     - Skip Duplicates from left and right
     - Check if mid is equal to target
     - else whether mid is in left sorted portion or right and update bounds.
 Time Complexity: O(log n)
 Space Complexity: O(1)
 */
struct SearchRotatedSortedArrII {
    func callAsFunction(_ nums: [Int], _ target: Int) -> Bool {
        var lower = 0, upper = nums.count-1
        
        while lower <= upper {
            
            //fastForward pointer Duplicates
            while lower < upper && nums[lower] == nums[lower + 1] {
                lower += 1
            }
            while lower < upper && nums[upper] == nums[upper - 1] {
                upper -= 1
            }
            
            let midId = (lower + upper)/2
            if target == nums[midId] {
                return true
            }
            
            if nums[lower] <= nums[midId] {
                if target > nums[midId] || target < nums[lower] {
                    lower = midId + 1
                } else {
                    upper = midId - 1
                }
            } else {
                if target > nums[upper] || target < nums[midId] {
                    upper = midId - 1
                } else {
                    lower = midId + 1
                }
            }
        }
        
        return false
    }
}
/*
 problem:
 Suppose an array of length n sorted in ascending order is rotated between 1 and n times. For example, the array nums = [0,1,2,4,5,6,7] might become:

 [4,5,6,7,0,1,2] if it was rotated 4 times.
 [0,1,2,4,5,6,7] if it was rotated 7 times.
 Notice that rotating an array [a[0], a[1], a[2], ..., a[n-1]] 1 time results in the array [a[n-1], a[0], a[1], a[2], ..., a[n-2]].

 Given the sorted rotated array nums of unique elements, return the minimum element of this array.

 You must write an algorithm that runs in O(log n) time.
 
 Testcases:
 Input: nums = [3,4,5,1,2]
 Output: 1
 Explanation: The original array was [1,2,3,4,5] rotated 3 times.

 Input: nums = [4,5,6,7,0,1,2]
 Output: 0
 Explanation: The original array was [0,1,2,4,5,6,7] and it was rotated 4 times.

 Input: nums = [11,13,15,17]
 Output: 11
 Explanation: The original array was [11,13,15,17] and it was rotated 4 times.
 
 Constraints:
 n == nums.length
 1 <= n <= 5000
 -5000 <= nums[i] <= 5000
 All the integers of nums are unique.
 nums is sorted and rotated between 1 and n times.
 
 link: https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/
 explanation: https://www.youtube.com/watch?v=nIVW4P8b1VA
 primary idea:
 - Binary search
 - Check if arr is sorted from left to right, then left value will be minimum
 - Check if mid value is minimum. if yes update minimum val variable.
 - else whether mid is in left sorted portion or right. If the mid is in left Sorted portion, search right and if mid is in right sorted portion, search left
 Time Complexity: O(logn)
 Space Complexity: O(1)
 */
class MinimumInRotatedSortedArr {
    func callAsFunction(_ nums: [Int]) -> Int {
        var minVal = nums[0]
        var l = 0, r = nums.count - 1
        
        while l <= r {
            if nums[l] < nums[r] {
                minVal = min(minVal, nums[l])
                break
            }
            
            let midId = (l + r)/2
            minVal = min(minVal, nums[midId])
            
            if nums[l] <= nums[midId] {
                l = midId + 1
            } else {
                r = midId - 1
            }
        }
        return minVal
    }
}

/*
 problem:
 Suppose an array of length n sorted in ascending order is rotated between 1 and n times. For example, the array nums = [0,1,4,4,5,6,7] might become:

 [4,5,6,7,0,1,4] if it was rotated 4 times.
 [0,1,4,4,5,6,7] if it was rotated 7 times.
 Notice that rotating an array [a[0], a[1], a[2], ..., a[n-1]] 1 time results in the array [a[n-1], a[0], a[1], a[2], ..., a[n-2]].

 Given the sorted rotated array nums that may contain duplicates, return the minimum element of this array.

 You must decrease the overall operation steps as much as possible.
 
 Testcases:
 Input: nums = [1,3,5]
 Output: 1

 Input: nums = [2,2,2,0,1]
 Output: 0
 
 Constraints:
 n == nums.length
 1 <= n <= 5000
 -5000 <= nums[i] <= 5000
 nums is sorted and rotated between 1 and n times.
 
 link: https://leetcode.com/problems/find-minimum-in-rotated-sorted-array-ii/
 explanation: https://www.youtube.com/watch?v=nIVW4P8b1VA
 primary idea:
 - Binary search
 - Skip duplicates from left and right
 - Check if arr is sorted from left to right, then left value will be minimum
 - Check if mid value is minimum. if yes update minimum val variable.
 - else whether mid is in left sorted portion or right. If the mid is in left Sorted portion, search right and if mid is in right sorted portion, search left
 Time Complexity: O(logn)
 Space Complexity: O(1)
 */
class MinimumInRotatedSortedArrII {
    func callAsFunction(_ nums: [Int]) -> Int {
        var minVal = nums[0]
        var l = 0, r = nums.count - 1
        
        while l <= r {
            
            //fastForward pointer Duplicates
            while l < r && nums[l] == nums[l + 1] {
                l += 1
            }
            while l < r && nums[r] == nums[r - 1] {
                r -= 1
            }
            
            if nums[l] < nums[r] {
                minVal = min(minVal, nums[l])
                break
            }
            
            let midId = (l + r)/2
            minVal = min(minVal, nums[midId])
            
            if nums[l] <= nums[midId] {
                l = midId + 1
            } else {
                r = midId - 1
            }
        }
        return minVal
    }
}

/*
 problem:
 Write an efficient algorithm that searches for a value in an m x n matrix. This matrix has the following properties:

 Integers in each row are sorted from left to right.
 The first integer of each row is greater than the last integer of the previous row.
 
 Testcases:
 Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
 Output: true
 
 Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 13
 Output: false
 
 Constraints:
 m == matrix.length
 n == matrix[i].length
 1 <= m, n <= 100
 -104 <= matrix[i][j], target <= 104
 
 link: https://leetcode.com/problems/search-a-2d-matrix/
 primary idea:
 - Binary search
 - Consider it as single array and fetch value based on it index
 - Skip duplicates from left and right
 - Check if target is same as midVal, then found
 Time Complexity: O(log(m*n))
 Space Complexity: O(1)
 */
class SearchMatrix {
    func callAsFunction(_ matrix: [[Int]], _ target: Int) -> Bool {
        let m = matrix.count, n = matrix[0].count
        var l = 0, r = (m * n) - 1
        
        func getValue(_ index: Int) -> Int {
            let row = index/n
            let column = index % n
            return matrix[row][column]
        }
        
        while l <= r {
            
            //fastForward pointer Duplicates
            while l < r && getValue(l) == getValue(l + 1) {
                l += 1
            }
            while l < r && getValue(r) == getValue(r - 1) {
                r -= 1
            }
            
            let midId = (l + r)/2
            if target == getValue(midId) {
                return true
            } else if target < getValue(midId) {
                r = midId - 1
            } else {
                l = midId + 1
            }
        }
        
        return false
    }
}

/*
 problem:
 Write an efficient algorithm that searches for a target value in an m x n integer matrix. The matrix has the following properties:

 Integers in each row are sorted in ascending from left to right.
 Integers in each column are sorted in ascending from top to bottom.
 
 Testcases:
 Input: matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 5
 Output: true
 
 Input: matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 20
 Output: false
 
 Constraints:
 m == matrix.length
 n == matrix[i].length
 1 <= n, m <= 300
 -109 <= matix[i][j] <= 109
 All the integers in each row are sorted in ascending order.
 All the integers in each column are sorted in ascending order.
 -109 <= target <= 109
 
 link: https://leetcode.com/problems/search-a-2d-matrix-ii/
 explanation: https://www.youtube.com/watch?v=dcTJRw1704w
 primary idea:
 - Binary search
 - Traverse from top right of matrix to bottom left of matrix
 Time Complexity: O(R+C)
 Space Complexity: O(1)
 */
struct SearchMatrixII {
    func callAsFunction(_ matrix: [[Int]], _ target: Int) -> Bool {
        var rowPivot = 0, colPivot = matrix[0].count - 1
        
        while rowPivot < matrix.count && colPivot >= 0 {
            let element = matrix[rowPivot][colPivot]
            if target > element {
                rowPivot += 1
            } else if target < element {
                colPivot -= 1
            } else {
                return true
            }
        }
        
        return false
    }
}

/*
 problem:
 Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

 You must write an algorithm with O(log n) runtime complexity.
 
 Testcases:
 Input: nums = [1,3,5,6], target = 5
 Output: 2

 Input: nums = [1,3,5,6], target = 2
 Output: 1

 Input: nums = [1,3,5,6], target = 7
 Output: 4

 Input: nums = [1,3,5,6], target = 0
 Output: 0

 Input: nums = [1], target = 0
 Output: 0
 
 Constraints:
 1 <= nums.length <= 104
 -104 <= nums[i] <= 104
 nums contains distinct values sorted in ascending order.
 -104 <= target <= 104
 
 link: https://leetcode.com/problems/find-first-and-last-position-of-element-in-sorted-array/
 explanation: https://www.youtube.com/watch?v=4sQL7R5ySUU&list=PLot-Xpze53leNZQd0iINpD-MAhMOMzWvO&index=5
 primary idea:
 - Binary search
 - For left range value, continue to search to left even if target is found
 - For right range value, continue to search to right even if target is found
 Time Complexity:O(2 * logn)
 Space Complexity: O(1)
 */
class SearchRange {
    func callAsFunction(_ nums: [Int], _ target: Int) -> [Int] {
        if nums.isEmpty { return [-1,-1] }
        
        func helper(_ leftBias: Bool) -> Int {
            var l = 0, r = nums.count - 1
            var i = -1
            
            while l <= r {
                let midId = (l+r)/2
                if target == nums[midId] {
                    i = midId
                    if leftBias {
                        r = midId - 1
                    } else {
                        l = midId + 1
                    }
                } else if target < nums[midId] {
                    r = midId - 1
                } else {
                    l = midId + 1
                }
            }
            
            return i
        }
        
        return [helper(true), helper(false)]
    }
}

/*
 problem:
 Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

 You must write an algorithm with O(log n) runtime complexity.
 
 Testcases:
 Input: nums = [1,3,5,6], target = 5
 Output: 2

 Input: nums = [1,3,5,6], target = 2
 Output: 1

 Input: nums = [1,3,5,6], target = 7
 Output: 4

 Input: nums = [1,3,5,6], target = 0
 Output: 0

 Input: nums = [1], target = 0
 Output: 0
 
 Constraints:
 1 <= nums.length <= 104
 -104 <= nums[i] <= 104
 nums contains distinct values sorted in ascending order.
 -104 <= target <= 104
 
 link: https://leetcode.com/problems/search-insert-position/
 explanation: https://www.youtube.com/watch?v=4sQL7R5ySUU&list=PLot-Xpze53leNZQd0iINpD-MAhMOMzWvO&index=5
 primary idea:
 - Binary search
 - For left boundary value, continue to search to left even if target is found
 Time Complexity: O(logn)
 Space Complexity: O(1)
 */
class SearchInsert {
    func callAsFunction(_ nums: [Int], _ target: Int) -> Int {
        var l = 0, r = nums.count - 1
        
        while l <= r {
            let midId = (l+r)/2
            if nums[midId] == target {
                return midId
            } else if nums[midId] < target {
                l = midId + 1
            } else {
                r = midId - 1
            }
        }
        
        return l
    }
}


struct FindMedianSortedArrays {
    func callAsFunction(_ nums1: [Int], _ nums2: [Int]) -> Double {
        var A = nums1, B = nums2
        let total = nums1.count + nums2.count, half = total/2
        
        if B.count < A.count {
            (A,B)=(B,A)
        }
        
        var l = 0, r = A.count - 1
        while true {
            let i = Int(floor((Double(l)+Double(r))/2.0))
            let j = half - i - 2
            
            let ALeft = i >= 0 ? A[i] : Int.min
            let ARight = i+1 < A.count ? A[i+1] : Int.max
            let BLeft = j >= 0 ? B[j] : Int.min
            let BRight = j+1 < B.count ? B[j+1] : Int.max
            
            if ALeft <= BRight && BLeft <= ARight {
                if total % 2 == 1 {
                    return Double(min(ARight, BRight))
                } else {
                    return (Double(max(ALeft, BLeft)) + Double(min(ARight, BRight)))/2
                }
            } else if ALeft > BRight {
                r = i - 1
            } else {
                l = i + 1
            }
        }
    }
}


/*
 problem:
 Koko loves to eat bananas. There are n piles of bananas, the ith pile has piles[i] bananas. The guards have gone and will come back in h hours.

 Koko can decide her bananas-per-hour eating speed of k. Each hour, she chooses some pile of bananas and eats k bananas from that pile. If the pile has less than k bananas, she eats all of them instead and will not eat any more bananas during this hour.

 Koko likes to eat slowly but still wants to finish eating all the bananas before the guards return.

 Return the minimum integer k such that she can eat all the bananas within h hours.
 
 Testcases:
 Input: piles = [3,6,7,11], h = 8
 Output: 4

 Input: piles = [30,11,23,4,20], h = 5
 Output: 30

 Input: piles = [30,11,23,4,20], h = 6
 Output: 23
 
 Constraints:
 1 <= piles.length <= 104
 piles.length <= h <= 109
 1 <= piles[i] <= 109
 
 link: https://leetcode.com/problems/koko-eating-bananas/
 explanation: https://www.youtube.com/watch?v=U2SozAs9RzA
 primary idea:
 -
 Time Complexity: O(log(max(p))*p)
 Space Complexity: O(1)
 */
class KokoEatingBananas {
    func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
        var l = 1, r = piles.max()!
        var res = piles.max()!
        
        func canEatbananas(k: Int) -> Bool {
            var kHours = 0
            for pile in piles {
                var div = pile/k
                if pile%k > 0 { div += 1 }
                kHours += div
                if kHours > h {
                    return false
                }
            }
            return true
        }
        
        while l <= r {
            let k = (l+r)/2
            if canEatbananas(k: k) {
                res = min(res, k)
                r = k - 1
            } else {
                l = k + 1
            }
        }
        
        return res
    }
}

/*
 problem:
 A peak element is an element that is strictly greater than its neighbors.

 Given an integer array nums, find a peak element, and return its index. If the array contains multiple peaks, return the index to any of the peaks.

 You may imagine that nums[-1] = nums[n] = -∞.

 You must write an algorithm that runs in O(log n) time.
 
 Testcases:
 Input: nums = [1,2,3,1]
 Output: 2
 Explanation: 3 is a peak element and your function should return the index number 2.

 Input: nums = [1,2,1,3,5,6,4]
 Output: 5
 Explanation: Your function can return either index number 1 where the peak element is 2, or index number 5 where the peak element is 6.
 
 Constraints:
 1 <= nums.length <= 1000
 -231 <= nums[i] <= 231 - 1
 nums[i] != nums[i + 1] for all valid i
 
 link: https://leetcode.com/problems/peak-index-in-a-mountain-array/
 explanation: https://www.youtube.com/watch?v=LHfS7bA6dCA
 primary idea:
 - Binary search
 - check for element greater than its previous and next
 Time Complexity: O(logn)
 Space Complexity: O(1)
 */
struct PeakIndexMountainArray {
    func callAsFunction(_ A: [Int]) -> Int {
        var l = 0, r = A.count - 1
        while l <= r {
            let midId = (l+r)/2
            if A[midId] > A[midId + 1], A[midId - 1] < A[midId]  {
                return midId
            } else if A[midId] < A[midId + 1] {
                l = midId + 1
            } else {
                r = midId - 1
            }
        }
        return -1
    }
}

/*
 problem:
 You are given an array of positive integers w where w[i] describes the weight of ith index (0-indexed).

 We need to call the function pickIndex() which randomly returns an integer in the range [0, w.length - 1]. pickIndex() should return the integer proportional to its weight in the w array. For example, for w = [1, 3], the probability of picking the index 0 is 1 / (1 + 3) = 0.25 (i.e 25%) while the probability of picking the index 1 is 3 / (1 + 3) = 0.75 (i.e 75%).

 More formally, the probability of picking index i is w[i] / sum(w).
 
 Testcases:
 Input
 ["Solution","pickIndex"]
 [[[1]],[]]
 Output
 [null,0]
 
 Input
 ["Solution","pickIndex","pickIndex","pickIndex","pickIndex","pickIndex"]
 [[[1,3]],[],[],[],[],[]]
 Output
 [null,1,1,1,1,0]
 Explanation
 Solution solution = new Solution([1, 3]);
 solution.pickIndex(); // return 1. It's returning the second element (index = 1) that has probability of 3/4.
 solution.pickIndex(); // return 1
 solution.pickIndex(); // return 1
 solution.pickIndex(); // return 1
 solution.pickIndex(); // return 0. It's returning the first element (index = 0) that has probability of 1/4.

 Since this is a randomization problem, multiple answers are allowed so the following outputs can be considered correct :
 [null,1,1,1,1,0]
 [null,1,1,1,1,1]
 [null,1,1,1,0,0]
 [null,1,1,1,0,1]
 [null,1,0,1,0,0]
 ......
 and so on.
 
 Constraints:
 1 <= w.length <= 10000
 1 <= w[i] <= 10^5
 pickIndex will be called at most 10000 times.
 
 link: https://leetcode.com/problems/course-schedule/
 explanation: https://www.youtube.com/watch?v=EgI5nU9etnU
 primary idea:
 - create Adj list, map from course to its prerequisite courses
 - perform classic DFS on Adj list
 - once we get to know that specific course is completable, mark it's adj list value as empty which helps reduce redundant operations #44
 - Given prerequites may contain un connected graphs, better to loops through evey course so that we don miss any course #67
 Time Complexity:
 Space Complexity:
 */
class RndomPickWeight {
    let weights: [Int]
    init(_ w: [Int]) {
        var w = w
        for i in 1..<w.count {
            w[i] = w[i] + w[i - 1]
        }
        weights = w
    }
    
    func pickIndex() -> Int {
        var l = 0, r = weights.count - 1
        let target = Int.random(in: 0..<weights[weights.count - 1]) + 1
        while l <= r {
            let midId = (l+r)/2
            let midWeight = weights[midId]
            if midWeight == target {
                return midId
            } else if midWeight < target {
                l = midId + 1
            } else {
                r = midId - 1
            }
        }
        return l
    }
}

/*
 problem:
 A peak element is an element that is strictly greater than its neighbors.

 Given an integer array nums, find a peak element, and return its index. If the array contains multiple peaks, return the index to any of the peaks.

 You may imagine that nums[-1] = nums[n] = -∞.

 You must write an algorithm that runs in O(log n) time.
 
 Testcases:
 Input: nums = [1,2,3,1]
 Output: 2
 Explanation: 3 is a peak element and your function should return the index number 2.

 Input: nums = [1,2,1,3,5,6,4]
 Output: 5
 Explanation: Your function can return either index number 1 where the peak element is 2, or index number 5 where the peak element is 6.
 
 Constraints:
 
 
 link: https://leetcode.com/problems/find-peak-element/
 primary idea:
 - Binary search
 - check for element greater than its previous
 - Once l == r then we know that it is the result index
 Time Complexity: O(logn)
 Space Complexity: O(1)
 */
struct FindPeakElement {
    func callAsFunction(_ nums: [Int]) -> Int {
        var l = 0, r = nums.count - 1
        while l < r {
            let midId = (l+r)/2
            if  nums[midId] < nums[midId + 1] {
                l = midId + 1
            } else {
                r = midId
            }
        }
        return l
    }
}

/*
 link: https://leetcode.com/problems/container-with-most-water/
 explanation: https://www.youtube.com/watch?v=UuiTKBwPgAo
 Primary Idea:
     - Two Pointer
     - --> L , R <--
 */
struct ContainerWithMaxWater {
    func callAsFunction(_ height: [Int]) -> Int {
        var l = 0, r = height.count - 1
        var maxArea = 0
        
        while l < r {
            let h = min(height[l], height[r])
            let w = r - l
            maxArea = max(h * w, maxArea)
            if height[l] < height[r] {
                l += 1
            } else if height[l] == height[r] {
                if height[l+1] < height[r-1] {
                    l += 1
                } else {
                    r -= 1
                }
            } else {
                r -= 1
            }
        }
        
        return maxArea
    }
}

/*
 problem:
 Given a non-negative integer x, compute and return the square root of x.

 Since the return type is an integer, the decimal digits are truncated, and only the integer part of the result is returned.

 Note: You are not allowed to use any built-in exponent function or operator, such as pow(x, 0.5) or x ** 0.5.
 
 Testcases:
 Input: x = 4
 Output: 2

 Input: x = 8
 Output: 2
 Explanation: The square root of 8 is 2.82842..., and since the decimal part is truncated, 2 is returned.
 
 Constraints:
 0 <= x <= 2^31 - 1
 
 link: https://leetcode.com/problems/sqrtx/
 primary idea:
 - Binary search
 Time Complexity: O(logn)
 Space Complexity: O(1)
 */
class Sqrtx {
    func mySqrt(_ x: Int) -> Int {
        guard x > 0 else {
            return 0
        }
        var l = 0, r = (x/2) + 1
        while l <= r {
            let midVal = (l+r)/2
            let midSquared = midVal * midVal
            if midSquared == x {
                return midVal
            } else if midSquared < x {
                l = midVal + 1
            } else {
                r = midVal - 1
            }
        }
        return r
    }
}

/*
 problem:
 You are given two strings s and p where p is a subsequence of s. You are also given a distinct 0-indexed integer array removable containing a subset of indices of s (s is also 0-indexed).

 You want to choose an integer k (0 <= k <= removable.length) such that, after removing k characters from s using the first k indices in removable, p is still a subsequence of s. More formally, you will mark the character at s[removable[i]] for each 0 <= i < k, then remove all marked characters and check if p is still a subsequence.

 Return the maximum k you can choose such that p is still a subsequence of s after the removals.

 A subsequence of a string is a new string generated from the original string with some characters (can be none) deleted without changing the relative order of the remaining characters
 
 Testcases:
 Input: s = "abcacb", p = "ab", removable = [3,1,0]
 Output: 2
 Explanation: After removing the characters at indices 3 and 1, "abcacb" becomes "accb".
 "ab" is a subsequence of "accb".
 If we remove the characters at indices 3, 1, and 0, "abcacb" becomes "ccb", and "ab" is no longer a subsequence.
 Hence, the maximum k is 2.

 Input: s = "abcbddddd", p = "abcd", removable = [3,2,1,4,5,6]
 Output: 1
 Explanation: After removing the character at index 3, "abcbddddd" becomes "abcddddd".
 "abcd" is a subsequence of "abcddddd".

 Input: s = "abcab", p = "abc", removable = [0,1,2,3,4]
 Output: 0
 Explanation: If you remove the first index in the array removable, "abc" is no longer a subsequence.
 
 Constraints:
 1 <= p.length <= s.length <= 105
 0 <= removable.length < s.length
 0 <= removable[i] < s.length
 p is a subsequence of s.
 s and p both consist of lowercase English letters.
 The elements in removable are distinct.
 
 link: https://leetcode.com/problems/maximum-number-of-removable-characters/
 explanation: https://www.youtube.com/watch?v=NMP3nRPyX5g&list=PLot-Xpze53leNZQd0iINpD-MAhMOMzWvO&index=3
 primary idea:
 - Binary search on removable array
 - update res max value, as we find it's still subsequence
 Time Complexity:
 Space Complexity:
 */
class MaximumRemovals {
    func callAsFunction(_ s: String, _ p: String, _ removable: [Int]) -> Int {
        guard p.count < s.count else {
            return 0
        }
        let s = Array(s), p = Array(p), sCount = s.count, pCount = p.count
        
        func isSubSequence(k: Int) -> Bool {
            let removable = removable[0..<k].reduce(into: [Bool](repeating: false, count: sCount), { $0[$1] = true })
            var s1 = 0, p1 = 0
            while s1 < sCount, p1 < pCount {
                
                if removable[s1] || s[s1] != p[p1] {
                    s1 += 1
                    continue
                }
                s1 += 1
                p1 += 1
            }
            return p1 == pCount
        }
        
        var l = 0, r = removable.count - 1, res = 0
        while l <= r {
            
            let midId = (l+r)/2
            
            if isSubSequence(k: midId+1) {
                res = max(res, midId+1)
                l = midId + 1
            } else {
                r = midId - 1
            }
        }
        
        return res
    }
}
