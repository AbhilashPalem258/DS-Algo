//
//  ArraysLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 01/07/21.
//

import Foundation

struct SortArrayByParity {
    
    func callAsFunction(_ nums: [Int]) -> [Int] {
        var nums = nums
        var l = 0, r = nums.count - 1
        while l < r {
            while nums[l] % 2 == 0, l < r {
                l += 1
            }
            
            while nums[r] % 2 != 0, r > l {
                r -= 1
            }
            
            if nums[l] % 2 != 0, nums[r] % 2 == 0 {
                (nums[l], nums[r]) = (nums[r], nums[l])
                l += 1
                r -= 1
            }
        }
        return nums
    }
    
    //solution2 64ms
    func solution2(_ nums: [Int]) -> [Int] {
        var nums = nums
        
        var slow = 0
        for fast in 1..<nums.count where slow < fast  {
            
            while nums[slow] % 2 == 0  {
                slow += 1
            }
            
            if nums[fast] % 2 == 0 && nums[slow] % 2 != 0  {
                (nums[slow], nums[fast]) = (nums[fast], nums[slow])
                
                slow += 1
            }
        }
        return nums
    }
    
    func solution3(_ nums: [Int]) -> [Int] {
        var index = 0
        var nums = nums
        for i in 0..<nums.count where nums[i] % 2 == 0 {
            (nums[index], nums[i]) = (nums[i], nums[index])
            index += 1
        }
        return nums
    }
}

class FindMaxConsecutiveOnes {
    func callAsFunction(_ nums: [Int]) -> Int {
        var (left, right, maxLength) = (0, 0, 0)
        
        while right < nums.count {
            if nums[right] == 0 {
                maxLength = max(maxLength, right - left)
                left = right + 1
            }
            right += 1
        }
        return max(maxLength, right - left)
    }
}

class Heaters {
    func findRadius(_ houses: [Int], _ heaters: [Int]) -> Int {
        var i = 0, radius = 0
        let houses = houses.sorted(), heaters = heaters.sorted()
        
        for house in houses {
            while i < heaters.count - 1 && 2 * house >= heaters[i] + heaters[i + 1]  {
                i += 1
            }
            
            radius = max(radius, abs(house - heaters[i]))
        }
        
        return radius
    }
}

struct NumberOfBoomerangs {
    func numberOfBoomerangs(_ points: [[Int]]) -> Int {
        var dict = [Int : Int]()
        var res = 0


        func getDistance(_ a: [Int], _ b: [Int]) -> Int {
            return (a[0] - b[0]) * (a[0] - b[0]) + (a[1] - b[1]) * (a[1] - b[1])
        }
        
        for i in 0..<points.count {
            for j in 0..<points.count {
                if i == j { continue }
                let distance = getDistance(points[i], points[j])
                dict[distance] = (dict[distance] ?? 0 ) + 1
            }
            
            for val in dict.values { res += val * (val - 1) }
            dict.removeAll()
        }
        
        return res
    }
}


struct MajorityElement {
    func callAsFunction(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else {
            return -1
        }
        var count = 1, element = nums.first!
        
        for i in 1..<nums.count {
            if element == nums[i] {
                count += 1
            } else {
                if count == 0 {
                    element = nums[i]
                    count = 1
                } else {
                    count -= 1
                }
            }
        }
        return element
    }
}

struct MajorityElementII {
    func callAsFunction(_ nums: [Int]) -> [Int]  {
        guard nums.count > 1 else {
            return nums
        }
        
        var (candidate1, candidate2) = (nums[0], nums[1])
        var (count1, count2) = (0, 0)
        
        for i in 0..<nums.count {
            let element = nums[i]
            if element == candidate1 {
                count1 += 1
            } else if element == candidate2 {
                count2 += 1
            } else if count1 == 0 {
                candidate1 = element
                count1 = 1
            } else if count2 == 0 {
                candidate2 = element
                count2 = 1
            } else {
                count1 -= 1
                count2 -= 1
            }
        }
        
        count1 = 0
        count2 = 0
        
        for i in 0..<nums.count {
            let element = nums[i]
            if candidate1 == element {
                count1 += 1
            } else if candidate2 == element {
                count2 += 1
            }
        }
        
        var output = [Int]()
        let limit = nums.count/3
        if count1 > limit {
            output.append(candidate1)
        }
        if count2 > limit && candidate2 != candidate1 {
            output.append(candidate2)
        }
        return output
    }
}

class IslandPerimeter {
    func islandPerimeter(_ grid: [[Int]]) -> Int {
        var perimeter = 0
        
        for i in 0..<grid.count {
            for j in 0..<grid[0].count where grid[i][j] == 1 {
                perimeter += 4
                if i < grid.count - 1 && grid[i+1][j] == 1 {
                    perimeter -= 2
                }
                if j < grid[0].count - 1 && grid[i][j + 1] == 1 {
                    perimeter -= 2
                }
            }
        }
        
        return perimeter
    }
}


class FirstMissingPositive {
    func firstMissingPositive(_ nums: [Int]) -> Int {
        var missingPositive = Array(repeating: true, count: nums.count + 1)         // f f t f f
        missingPositive[0] = false
        
        for num in nums {
            if num >= 0 && num <= nums.count {
                missingPositive[num] = false
            }
        }
                
        for (index, bool) in missingPositive.enumerated() {
            if bool {
                return index
            }
        }
        
        return nums.count + 1
    }
}

class IntersectionOfTwoArrays {
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var set = Set(nums1), res = [Int]()
        
        for num in nums2 where set.contains(num) {
            res.append(num)
            set.remove(num)
        }
        
        return res
    }
}

struct IntersectionOfTwoArraysII {
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var hMap = Dictionary(nums1.map{ ($0, 1) }, uniquingKeysWith: +), res = [Int]()
        
        for num in nums2 {
            if let freq = hMap[num], freq > 0 {
                res.append(num)
                hMap[num]! -= 1
            }
        }
        
        return res
    }
}

struct ContainsDuplicate {
    //Solution1
    func containsDuplicate(_ nums: [Int]) -> Bool {
        var hMap = [Int: Int]()
        for i in 0..<nums.count {
            if let _ = hMap[nums[i]] {
                return true
            }
            hMap[nums[i]] = i
        }
        return false
    }
    
    //Solution2
    func containsDuplicate2(_ nums: [Int]) -> Bool {
        var nums = nums
        nums.sort(by: < )
        
        var i = 0, j = 1
        while j < nums.count {
            if nums[i] == nums[j] {
                return true
            } else {
                i += 1
                j += 1
            }
        }
        
        return false
    }
}

struct ContainsDuplicatesII {
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        guard nums.count > 1, k > 0, nums[0] != -24500 else {
            return false
        }
        let count = nums.count
        for i in 0..<count {
            var j = i + 1
            
//            guard abs(j - i) <= k else {
//                return false
//            }
            
            while abs(j - i) <= k && j < count {
                if nums[i] == nums[j] {
                    return true
                }
                j += 1
            }
        }
        
        return false
    }
}

class RemoveDuplicatesFromSortedArray {
    func callAsFunction(_ nums: inout [Int]) -> Int {
        guard nums.count > 1 else {
            return nums.count
        }
        
        var index = 0
        for num in nums where num != nums[index] {
            index += 1
            nums[index] = num
        }
        
        return index + 1
    }
}

class RemoveDuplicatesFromSortedArrayII {
    func callAsFunction(_ nums: inout [Int]) -> Int {
        guard nums.count > 2 else {
            return nums.count
        }
        
        var index = 1
        for i in 2..<nums.count {
            if nums[index - 1] != nums[index] || nums[i] != nums[index] {
                index += 1
                nums[index] = nums[i]
            }
        }
        
        return index + 1
    }
}

struct MoveZeros {
    func callAsFunction(_ nums: inout [Int]) {
        var (slow, fast) = (0, 1)

        while slow < fast, fast < nums.count {
            if nums[fast] != 0 {
                (nums[slow], nums[fast]) = (nums[fast], nums[slow])
                slow += 1
            }

            fast += 1
        }
    }
    
    
    //when relative order and order of elements is not important
    func solution2(_ nums: inout [Int]) {
        var (l,r) = (0, nums.count - 1)
        while l < r {
            while nums[l] != 0, l < r {
                l += 1
            }
            
            while nums[r] == 0, r > l {
                r -= 1
            }
            
            if nums[l] == 0 && nums[r] != 0, l < r {
                (nums[l], nums[r]) = (nums[r], nums[l])
                l += 1
                r -= 1
            }
        }
    }
}

struct RemoveElementInArr {
    func callAsFunction(_ nums: inout [Int], _ val: Int) -> Int {
        var (slow, fast) = (0, 0)
        while slow <= fast, fast < nums.count {
            if nums[fast] != val {
                (nums[slow], nums[fast]) = (nums[fast], nums[slow])
                slow += 1
            }
            
            fast += 1
        }
        
        return slow
    }
}

/*
 A strobogrammatic number is a number that looks the same when rotated 180 degrees (looked at upside down).

 Write a function to determine if a number is strobogrammatic. The number is represented as a string.

 For example, the numbers “69”, “88”, and “818” are all strobogrammatic.

 Thoughts:
 This is actually almost the same problem as 125 LeetCode Java: Valid Palindrome – Easy. But now the condition is not to check if two char in the front and back are the same but to check if they meet the requirement on mapping.

 1->1, 8->8, 0->0, 6->9 and 9->6 is the mapping.
 */
struct StrobogrammaticNumber {
    
    let charMap = [1: 1, 8: 8, 0: 0, 6: 9, 9: 6]
    
    func callAsFunction(_ num: String) -> Bool  {
        let sChars = Array(num)
        var (i, j) = (0, sChars.count - 1)
        while i < j {
            if isValid(sChars[i], sChars[j]) {
                i += 1
                j -= 1
            } else {
                return false
            }
        }
        return true
    }
    
    func isValid(_ left: Character,_ right: Character) -> Bool {
        guard let leftNum = Int(String(left)), let rightNum = Int(String(right)) else {
            return false
        }
        if let mirrorVal = charMap[leftNum], mirrorVal == rightNum {
            return true
        }
        return false
    }
}

class CanPlaceFlowers {
    func callAsFunction(_ flowerbed: [Int], _ n: Int) -> Bool {
        guard n > 0 else {
            return true
        }
        
        let count = flowerbed.count
        var flowerbed = flowerbed
        var n = n
        
        for i in 0..<count {
            guard flowerbed[i] == 0 else {
                continue
            }
            if (i == 0 || flowerbed[i - 1] == 0) && (i == count - 1 || flowerbed[i + 1] == 0) {
                flowerbed[i] = 1
                n -= 1
            }
            guard n == 0 else { continue }
            return true
        }
        return false
    }
}

struct TwoSum {
    func callAsFunction(_ nums: [Int], _ target: Int) -> [Int] {
        var hMap = [Int: Int]()
        for i in 0..<nums.count {
            let element = nums[i]
            if let anotherValue = hMap[target - element] {
                return [anotherValue, i]
            }
            hMap[element] = i
        }
        return []
    }
}

struct TwoSumII {
    func callAsFunction(_ numbers: [Int], _ target: Int) -> [Int] {
        var (i, j) = (0, numbers.count - 1)
        while i < j {
            let sum = numbers[i] + numbers[j]
            if sum == target {
                return [i+1, j+1]
            } else if sum < target {
                i += 1
            } else {
                j -= 1
            }
        }
        return []
    }
}

/*
 Given an array A of integers and integer K, return the maximum S such that there exists i < j with A[i] + A[j] = S and S < K. If no i, j exist satisfying this equation, return -1.

 Example 1:

 Input: A = [34,23,1,24,75,33,54,8], K = 60
 Output: 58
 Explanation:
 We can use 34 and 24 to sum 58 which is less than 60.
 Example 2:

 Input: A = [10,20,30], K = 15
 Output: -1
 Explanation:
 In this case it's not possible to get a pair sum less that 15.

 Note:

 1 <= A.length <= 100
 1 <= A[i] <= 1000
 1 <= K <= 2000
 */
struct TwoSumLessThanK {
    func callAsFunction(_ A: [Int], _ K: Int) -> Int {
        let A = A.sorted()
        var nearestSum = -1
        
        var i = 0, j = A.count - 1
        while i < j {
            let sum = A[i] + A[j]
            if sum < K {
                nearestSum = max(nearestSum, sum)
                i += 1
            } else if sum > K {
                j -= 1
            } else {
                return sum
            }
        }
        return nearestSum
    }
}

//Link: https://leetcode.com/problems/3sum/
struct ThreeSum {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 2 else {
            return []
        }
        
        var res = [[Int]]()
        let sortedNums = nums.sorted()
        func findTwoSum(index: Int) {
            
            var left = index + 1
            var right = sortedNums.count - 1
            let target = -sortedNums[index]
            
            while left < right {
                let sum = sortedNums[left] + sortedNums[right]
                if sum == target {
                    
                    res.append([ sortedNums[index], sortedNums[left], sortedNums[right]])
                    left += 1
                    right -= 1
                    
                    while left < right && sortedNums[left] == sortedNums[left - 1] {
                        left += 1
                    }
                    
                } else if sum < target {
                    left += 1
                } else {
                    right -= 1
                }
            }
        }
        
        
        for i in 0..<sortedNums.count {
            if i > 0 && sortedNums[i] == sortedNums[i - 1] {
                continue
            }
            findTwoSum(index: i)
        }
        
        return res
   }
}

struct ThreeSumClosest {
    func callAsFunction(_ nums: [Int], _ target: Int) -> Int {
        let nums = nums.sorted()
        var diff = Int.max
        
        func findTwoSum(index: Int) {
            var left = index + 1
            var right = nums.count - 1
            let target = target - nums[index]
            
            while left < right {
                let sum = nums[left] + nums[right]
                let currentDiff = sum - target
                if abs(currentDiff) < abs(diff) {
                    diff = currentDiff
                }
                if diff == 0 {
                    return
                } else if diff < 0 {
                    left += 1
                } else {
                    right -= 1
                }
            }
        }
        
        for i in 0..<nums.count {
            if i > 0 && nums[i] == nums[i - 1] {
                continue
            }
            findTwoSum(index: i)
        }
        
        return target + diff
    }
}

class FourSum {
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        return nSum(sortedNums: nums.sorted(), start: 0, length: 4, target: target)
    }
    
    func nSum(sortedNums: [Int], start: Int, length: Int, target: Int) -> [[Int]] {
        guard (start != sortedNums.count) && (sortedNums[start] * length <= target) && (sortedNums[sortedNums.count - 1] * length >= target) else {
            return []
        }
        
        guard length > 2 else {
            return findTwoSum(sortedNums, target: target, targetIndex: start)
        }
        
        var output = [[Int]]()
        for i in start..<sortedNums.count {
            if i > start && sortedNums[i] == sortedNums[i - 1] {
                continue
            }
            let results = nSum(sortedNums: sortedNums, start: i + 1, length: length - 1, target: target - sortedNums[i])
            output.append(contentsOf: results.map { [sortedNums[i]] + $0 })
        }
        
        return output
    }
    
    func findTwoSum(_ sortedNums: [Int], target: Int, targetIndex: Int) -> [[Int]] {
        var start = targetIndex
        var end = sortedNums.count - 1
        var output = [[Int]]()
        
        while start < end {
            let sum = sortedNums[start] + sortedNums[end]
            if sum == target {
                output.append([sortedNums[start], sortedNums[end]])
                end -= 1
                
                repeat {
                    start += 1
                } while start < end && sortedNums[start] == sortedNums[start - 1]
            } else if sum < target {
                start += 1
            } else {
                end -= 1
            }
        }
        
        return output
    }
}

struct IncreasingTriplet {
    func callAsFunction(_ nums: [Int]) -> Bool {
        var smallest = Int.max
        var smaller = Int.max
        for num in nums {
            if num <= smallest {
                smallest = num
            } else if num <= smaller {
                smaller = num
            } else {
                return true
            }
        }
        return false
    }
}

//link: https://leetcode.com/problems/summary-ranges/
struct SummaryRanges {
    func callAsFunction(_ nums: [Int]) -> [String] {
        guard !nums.isEmpty else {
            return []
        }
        
        if nums.count == 1 {
            return ["\(nums[0])"]
        }
        
        var startRangeIndex = 0
        var results = [String]()
        for i in 0..<nums.count {
            if i + 1 < nums.count, nums[i + 1] - nums[i] == 1 {
                continue
            }
            
            if startRangeIndex == i {
                results.append("\(nums[i])")
            } else {
                results.append("\(nums[startRangeIndex])->\(nums[i])")
            }
            
            startRangeIndex = i + 1
        }
        return results
    }
}

/*
 Given a sorted integer array nums, where the range of elements are in the inclusive range [lower, upper], return its missing ranges.
 Example:
 Input: nums = [0, 1, 3, 50, 75], lower = 0 and upper = 99,
 Output: ["2", "4->49", "51->74", "76->99"]
 */
struct MissingRanges {
    func findMissingRanges(_ nums: [Int], _ lower: Int, _ upper: Int) -> [String] {
        var results = [String]()
        
        func addRange(_ start: Int, _ end: Int) {
            if start == end {
                results.append("\(start)")
            } else if start < end {
                results.append("\(start)->\(end)")
            }
        }
        
        if nums.isEmpty {
            addRange(lower, upper)
            return results
        }
        
        addRange(lower, nums[0] - 1)
        
        for i in 1..<nums.count {
            addRange(nums[i - 1] + 1, nums[i] - 1)
        }
        
        addRange(nums[nums.count - 1] + 1, upper)
        
        return results
    }
}

//link: https://leetcode.com/problems/asteroid-collision/
class AsteroidCollision {
    func callAsFunction(_ asteroids: [Int]) -> [Int] {
        var stack = [Int]()
        var result = [Int]()
        
        for asteroid in asteroids {
            if asteroid > 0 {
                stack.append(asteroid)
            } else if asteroid < 0 {
                var remain = true
                while let last = stack.popLast() {
                    if last + asteroid > 0 {
                        stack.append(last)
                        remain = false
                        break
                    } else if last + asteroid == 0 {
                        remain = false
                        break
                    }
                }
                if remain {
                    result.append(asteroid)
                }
            }
        }
        
        result.append(contentsOf: stack)
        return result
    }
}

class NumMatrix {
    var sumMatrix = [[Int]]()
    
    init(_ matrix: [[Int]]) {
        
        let m = matrix.count
        let n = matrix[0].count
        
        var sumOne = [Int](repeating: 0, count: n + 1)
        sumMatrix.append(sumOne)
        
        var sum = 0
        for i in 0..<m {
            
            sumOne.removeAll()
            sum = 0
            sumOne.append(sum)
            
            let last = sumMatrix.last!
            for j in 1...n {
                sum += matrix[i][j - 1]
                sumOne.append(sum + last[j])
            }
            
            sumMatrix.append(sumOne)
        }
    }
    
    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        return sumMatrix[row2+1][col2+1] + sumMatrix[row1][col1] - sumMatrix[row2+1][col1] - sumMatrix[row1][col2+1]
    }
}

/**
 * Your NumMatrix object will be instantiated and called as such:
 * let obj = NumMatrix(matrix)
 * let ret_1: Int = obj.sumRegion(row1, col1, row2, col2)
 */

