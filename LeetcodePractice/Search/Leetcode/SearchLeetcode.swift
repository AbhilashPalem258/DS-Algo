//
//  SearchLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 11/07/21.
//

import Foundation
import Darwin
/*
 link: https://leetcode.com/problems/search-in-rotated-sorted-array/
 explanation: https://www.youtube.com/watch?v=U8XENwh8Oy8
 Primary Idea:
     - Binary search
     - Check if mid is equal to target
     - else whether mid is in left sorted portion or right and update bounds.
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
 link: https://leetcode.com/problems/search-in-rotated-sorted-array-ii/
 explanation: https://www.youtube.com/watch?v=U8XENwh8Oy8
 Primary Idea:
     - Binary search
     - Skip Duplicates from left and right
     - Check if mid is equal to target
     - else whether mid is in left sorted portion or right and update bounds.
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
 link: https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/
 explanation: https://www.youtube.com/watch?v=nIVW4P8b1VA
 Primary Idea:
     - Binary search
     - Check if arr is sorted from left to right, then left value will be minimum
     - Check if mid value is minimum. if yes update minimum val variable.
     - else whether mid is in left sorted portion or right. If the mid is in left Sorted portion, search right and if mid is in right sorted portion, search left
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
 link: https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/
 explanation: https://www.youtube.com/watch?v=nIVW4P8b1VA
 Primary Idea:
     - Binary search
     - Skip duplicates from left and right
     - Check if arr is sorted from left to right, then left value will be minimum
     - Check if mid value is minimum. if yes update minimum val variable.
     - else whether mid is in left sorted portion or right. If the mid is in left Sorted portion, search right and if mid is in right sorted portion, search left
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
 link: https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/
 Primary Idea:
     - Binary search
     - Consider it as single array and fetch value based on it index
     - Skip duplicates from left and right
     - Check if target is same as midVal, then found
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
 link: https://leetcode.com/problems/search-a-2d-matrix-ii/
 explanation: https://www.youtube.com/watch?v=dcTJRw1704w
 Primary Idea:
     - Binary search
     - Traverse from top right of matrix to bottom left of matrix
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
 link: https://leetcode.com/problems/find-first-and-last-position-of-element-in-sorted-array/
 explanation: https://www.youtube.com/watch?v=4sQL7R5ySUU&list=PLot-Xpze53leNZQd0iINpD-MAhMOMzWvO&index=5
 Primary Idea:
     - Binary search
     - For left range value, continue to search to left even if target is found
     - For right range value, continue to search to right even if target is found
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
 link: https://leetcode.com/problems/search-insert-position/
 explanation: https://www.youtube.com/watch?v=4sQL7R5ySUU&list=PLot-Xpze53leNZQd0iINpD-MAhMOMzWvO&index=5
 Primary Idea:
     - Binary search
     - For left boundary value, continue to search to left even if target is found
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
 link: https://leetcode.com/problems/peak-index-in-a-mountain-array/
 explanation: https://www.youtube.com/watch?v=LHfS7bA6dCA
 Primary Idea:
     - Binary search
     - check for element greater than its previous and next
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
 link: https://leetcode.com/problems/maximum-number-of-removable-characters/
 explanation: https://www.youtube.com/watch?v=NMP3nRPyX5g&list=PLot-Xpze53leNZQd0iINpD-MAhMOMzWvO&index=3
 Primary idea:
    - Binary search on removable array
    - update res max value, as we find it's still subsequence
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
