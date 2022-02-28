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


/*
 problem:
 Winter is coming! During the contest, your first job is to design a standard heater with a fixed warm radius to warm all the houses.

 Every house can be warmed, as long as the house is within the heater's warm radius range.

 Given the positions of houses and heaters on a horizontal line, return the minimum radius standard of heaters so that those heaters could cover all houses.

 Notice that all the heaters follow your radius standard, and the warm radius will the same.
 
 Testcases:
 Input: houses = [1,2,3], heaters = [2]
 Output: 1
 Explanation: The only heater was placed in the position 2, and if we use the radius 1 standard, then all the houses can be warmed.
 
 Input: houses = [1,2,3,4], heaters = [1,4]
 Output: 1
 Explanation: The two heater was placed in the position 1 and 4. We need to use radius 1 standard, then all the houses can be warmed.
 
 Input: houses = [1,5], heaters = [2]
 Output: 3
 
 Constraints:
 1 <= houses.length, heaters.length <= 3 * 104
 1 <= houses[i], heaters[i] <= 109
 
 
 link: https://leetcode.com/problems/heaters/
 explanation: https://www.youtube.com/watch?v=Ax30Pitp-iM
 primary idea:
 - Make sure houses and heaters input are sorted
 - For each house, calculate distance to left heater and distance to right heater. Min of left and right distance is the radius required for that particular heaters
 - Maintain a variable `radius` and update it whenever we find higher radius
 - i helps to calculate left and right heater distance. For each house before calculating distances, make sure i is at the right heater index.
 Time Complexity: O(n)
 Space Complexity: O(n)
 */
class Heaters {
    func findRadius(_ houses: [Int], _ heaters: [Int]) -> Int {
        let houses = houses.sorted(), heaters = heaters.sorted()
        
        var i = 0
        var left = 0, right = 0
        var radius = 0
        
        for house in houses {
            while i < heaters.count - 1 && heaters[i] <= house {
                i += 1
            }
            
            left = abs(house - (i > 0 ? heaters[i - 1] : heaters[0]))
            right = abs(house - heaters[i])
            
            radius = max(radius, min(left, right))
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
                dict[distance] = 1 + dict[distance, default: 0]
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

/*
 problem:
 You are given row x col grid representing a map where grid[i][j] = 1 represents land and grid[i][j] = 0 represents water.

 Grid cells are connected horizontally/vertically (not diagonally). The grid is completely surrounded by water, and there is exactly one island (i.e., one or more connected land cells).

 The island doesn't have "lakes", meaning the water inside isn't connected to the water around the island. One cell is a square with side length 1. The grid is rectangular, width and height don't exceed 100. Determine the perimeter of the island.
 
 Testcases:
 Input: grid = [[0,1,0,0],[1,1,1,0],[0,1,0,0],[1,1,0,0]]
 Output: 16
 
 Input: grid = [[1]]
 Output: 4
 
 Input: grid = [[1,0]]
 Output: 4
 
 
 Constraints:
 row == grid.length
 col == grid[i].length
 1 <= row, col <= 100
 grid[i][j] is 0 or 1.
 There is exactly one island in grid.
 
 
 link: https://leetcode.com/problems/island-perimeter/
 explanation:
 primary idea:
 - iterate through matrix. For a single island box perimeter is 4 (4 sides) and if there any other island box connected to it, we can reduce perimeter of connected of side. For two island boxes connected, perimeter will be 4 (1st island box) - 
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class IslandPerimeter {
    func islandPerimeter(_ grid: [[Int]]) -> Int {
       var perimeter = 0
        let m = grid.count, n = grid.first!.count
        
        for row in 0..<m {
            for col in 0..<n where grid[row][col] == 1 {
                perimeter += 4
                if row < m - 1 && grid[row+1][col] == 1 {
                    perimeter -= 2
                }
                if col < n - 1 && grid[row][col+1] == 1 {
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
        if nums.isEmpty {
            return []
        }
        if nums.count == 1 {
            return ["\(nums.first!)"]
        }
        
        var res = [String]()
        
        func addRange(start: Int, end: Int) {
            if start == end {
                res.append("\(nums[start])")
            } else if start < end {
                res.append("\(nums[start])->\(nums[end])")
            }
        }
        
        var start = 0
        for i in 0..<nums.count {
            if i+1 < nums.count, nums[i+1] - nums[i] == 1 {
                continue
            }
            addRange(start: start, end: i)
            start = i + 1
        }
        return res
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

class MaxDistToClosest {
    func callAsFunction(_ seats: [Int]) -> Int {
        var last1 = -1
        var res = 0
        
        for i in 0..<seats.count {
            if seats[i] == 1 {
                res = max(res, (i - last1)/2)
                last1 = i
            } else if last1 == -1 {
                res += 1
            }
        }
        if seats[seats.count - 1] == 0 {
            res = max(res, seats.count - 1 - last1)
        }
        
        return res
    }
}

class ExamRoom {
    let n: Int
    var seats = [Int]()
    
    init(_ n: Int) {
        self.n = n
    }
    
    func seat() -> Int {
        if seats.count == 0 {
            seats = [0]
            return 0
        } else {
            // find maximal seat
            var best = (seat: -1, dist: -1, prevIdx: -1)
            
            
            // consider between 0 and firstSeat
            if seats[0] != 0 {
                best = (0, seats[0], 0)
            }
            // consider in between the other seats
            for i in 1..<seats.count {
                let dist = (seats[i] - seats[i - 1]) / 2
                if dist > best.dist {
                    best = (seats[i - 1] + dist, dist, i)
                }
            }
            // consider last seat
            if n - 1 - seats.last! > best.dist {
                //print("last seat is best")
                best = (n - 1, n - 1 - seats.last!, seats.count)
            }
           // print("best seat is #\(best.seat) after idx \(best.prevIdx)")
            seats.insert(best.seat, at: best.prevIdx)
            //print(seats)
            return best.seat
        }
    }
    
    func leave(_ p: Int) {
        // todo: binary search!
        for i in 0..<seats.count {
            if seats[i] == p {
                seats.remove(at: i)
                return
            }
        }
    }
}

/**
 * Your ExamRoom object will be instantiated and called as such:
 * let obj = ExamRoom(n)
 * let ret_1: Int = obj.seat()
 * obj.leave(p)
 */

/*
 Given a list of words and two words word1_and_word2, return the shortest distance between these two words in the list.
 Example:
 Assume that words =["practice", "makes", "perfect", "coding", "makes"].
 Input: word1 = “coding”, word2 = “practice”
 Output: 3
 Input: word1 = "makes", word2 = "coding"
 Output: 1
 Note:
 You may assume that word1 does not equal to word2, and _word1 _and _word2 _are both in the list.
 */
struct ShortestWordDistance {
    func callAsFunction(_ words: [String], _ word1: String, _ word2: String) -> Int {
        var (word1Idx, word2Idx, minDistance) = (-1, -1, Int.max)
        
        for i in 0..<words.count {
            if words[i] == word1 {
                word1Idx = i
            }
            
            if words[i] == word2 {
                word2Idx = i
            }
            
            if (word1Idx != -1 && word2Idx != -1) && (abs(word1Idx - word2Idx) < minDistance) {
                minDistance = abs(word1Idx - word2Idx)
            }
        }
        if minDistance == Int.max {
            return -1
        }
        return minDistance
    }
}
/*
 Design, Hash Map
 Medium
 Design a class which receives a list of words in the constructor, and implements a method that takes two words _word1 _and _word2 _and return the shortest distance between these two words in the list. Your method will be called _repeatedly _many times with different parameters.
 Example:
 Assume that words =["practice", "makes", "perfect", "coding", "makes"]
 */
struct ShortestWordDistanceII {
    
    private var wordMap = [String: [Int]]()
    
    init(_ words: [String]) {
        for i in 0..<words.count {
            self.wordMap[words[i], default: []].append(i)
        }
    }
    
    func shortest(_ word1: String, _ word2: String) -> Int {
        guard let word1Idxs = wordMap[word1], let word2Idxs = wordMap[word2] else {
            return -1
        }
        
        var i = 0, j = 0, minDistance = Int.max
        while i < word1Idxs.count && j < word2Idxs.count  {
            minDistance = min(minDistance, abs(word1Idxs[i] - word2Idxs[j]))
            
            if word1Idxs[i] < word2Idxs[j] {
                i += 1
            } else {
                j += 1
            }
        }
        
        return minDistance
    }
}

struct ShortestWordDistanceIII {
   func shortestWordDistance(_ words: [String], _ word1: String, _ word2: String) -> Int {
        var (idx1, idx2, prev, res) = (-1, -1, -1, Int.max)
        for i in 0..<words.count {
            prev = idx1
            let word = words[i]
            
            if word == word1 {
                idx1 = i
            }
            
            if word == word2 {
                idx2 = i
            }
            
            if idx1 != -1 && idx2 != -1 {
                if word1 == word2 && prev != -1 && prev != idx1 {
                    res = min(res, abs(idx1 - prev))
                } else if idx1 != idx2 {
                    res = min(res, abs(idx1 - idx2))
                }
            }
        }
        return  res
   }
}

struct MinimumSizeSubarraySum {
    func callAsFunction(_ target: Int, _ nums: [Int]) -> Int {
        
        var shortestSubarray = Int.max
        var shortestSubarraySum = 0
        var startOfSubarray = 0
        
        for i in 0..<nums.count {
            shortestSubarraySum = nums[i] + shortestSubarraySum
            
            while shortestSubarraySum >= target {
                shortestSubarray = min(shortestSubarray, i - startOfSubarray + 1)
                shortestSubarraySum -= nums[startOfSubarray]
                startOfSubarray += 1
            }
        }
        
        if shortestSubarray == Int.max {
            return 0
        }
        
        return shortestSubarray
    }
}

/*
 Given an array nums and a target value k, find the maximum length of a subarray that sums to k. If there isn't one, return 0 instead.

 Note:
 The sum of the entire nums array is guaranteed to fit within the 32-bit signed integer range.


 Example 1:
 Given nums = [1, -1, 5, -2, 3], k = 3,
 return 4. (because the subarray [1, -1, 5, -2] sums to 3 and is the longest)
 */
class MaximumSizeSubarraySumEqualsK {
    func callAsFunction(_ nums: [Int], _ k: Int) -> Int {
        var sum = 0, sumToIdx = [Int: Int](), longestSubarraylen = 0
        sumToIdx[0] = -1
        for i in 0..<nums.count {
            let element = nums[i]
            sum += element
            
            if let idx = sumToIdx[sum - k] {
                longestSubarraylen = max(longestSubarraylen, i - idx)
            }
            
            if sumToIdx[sum] == nil {
                sumToIdx[sum] = i
            }
        }
        return longestSubarraylen
    }
}

//link: https://leetcode.com/problems/product-of-array-except-self/
//Explanation: https://www.youtube.com/watch?v=bNvIQI2wAjk
class ProductExceptSelf {
    func callAsFunction(_ nums: [Int]) -> [Int] {
        var output = [Int](repeating: 1, count: nums.count)
        
        var prefixMultiply = 1
        for i in 0..<nums.count {
            output[i] = prefixMultiply
            prefixMultiply *= nums[i]
        }
        
        prefixMultiply = 1
        for i in (0..<nums.count).reversed() {
            output[i] *= prefixMultiply
            prefixMultiply *= nums[i]
        }
        
        return output
    }
}

struct RotateArray {
    func rotate(_ nums: inout [Int], _ k: Int) {
        let k = k % nums.count
        
        func reverse(start: Int, end: Int) {
            var i = start
            var j = end
            while i < j {
                (nums[i], nums[j]) = (nums[j], nums[i])
                i += 1
                j -= 1
            }
        }
        
        reverse(start: 0, end: nums.count - 1)
        reverse(start: 0, end: k - 1)
        reverse(start: k, end: nums.count - 1)
    }
}

struct RotateImage {
    func rotate(_ matrix: inout [[Int]]) {
        let count = matrix.count
        
        for layer in 0..<count/2 {
            let start = layer, end = count - 1 - layer
            for i in start..<end {
                let offset = i - start
                (
                    matrix[start][i],
                    matrix[i][end],
                    matrix[end][end - offset],
                    matrix[end - offset][start]
                ) = (
                    matrix[end - offset][start],
                    matrix[start][i],
                    matrix[i][end],
                    matrix[end][end - offset]
                )
            }
        }
    }
}

//link: https://leetcode.com/problems/spiral-matrix/
//explanation: https://www.youtube.com/watch?v=BJnMZNwUk1M&t=358s
struct SprialOrder {
    func callAsFunction(_ matrix: [[Int]]) -> [Int] {
        var result = [Int]()
        
        var (top, bottom, left, right) = (0, matrix.count, 0, matrix[0].count)
        
        while top < bottom && left < right {
            
            for i in left..<right {
                result.append(matrix[top][i])
            }
            top += 1
            
            for i in top..<bottom {
                result.append(matrix[i][right - 1])
            }
            right -= 1
            
            if !(left < right && top < bottom) {
                break
            }
            
            for i in (left..<right).reversed() {
                result.append(matrix[bottom - 1][i])
            }
            bottom -= 1
            
            for i in (top..<bottom).reversed() {
                result.append(matrix[i][left])
            }
            left += 1
        }
        
        return result
    }
}

struct SpiralMatrixII {
    func generateMatrix(_ n: Int) -> [[Int]] {
        var result = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
        
        var (top, bottom, left, right) = (0, n, 0, n)
        var runningNum = 1
        
        while left < right && top < bottom {
            for i in left..<right {
                result[top][i] = runningNum
                runningNum += 1
            }
            top += 1
            
            for i in top..<bottom {
                result[i][right - 1] = runningNum
                runningNum += 1
            }
            right -= 1
            
            if !(left < right && top < bottom) {
                break
            }
            
            for i in (left..<right).reversed() {
                result[bottom - 1][i] = runningNum
                runningNum += 1
            }
            bottom -= 1
            
            for i in (top..<bottom).reversed() {
                result[i][left] = runningNum
                runningNum += 1
            }
            left += 1
        }
        return result
    }
}

class DiagonalOrder {
    func callAsFunction(_ mat: [[Int]]) -> [Int] {
        var result = [Int]()
        
        let m = mat.count, n = mat[0].count
        
        var row = 0, column = 0
        
        for _ in 0..<m*n {
            result.append(mat[row][column])
            
            if (row + column) % 2 == 0 {
                if column == n - 1{
                    row += 1
                } else if row == 0{
                    column += 1
                } else {
                    row -= 1
                    column += 1
                }
            } else {
                if row == m - 1 {
                    column += 1
                } else if  column == 0 {
                    row += 1
                } else {
                    row += 1
                    column -= 1
                }
            }
        }
        
        return result
    }
}


//link: https://leetcode.com/problems/valid-sudoku/
//explanation: https://www.youtube.com/watch?v=TjFXEUCMqI8
struct ValidSudoku {
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        if board.count != 9 && board[0].count != 9 {
            return false
        }
        
        func validateRange(rowRange: Range<Int>, colRange: Range<Int>) -> Bool {
            var charDuplicateMap = [Character: Bool]()
            for row in rowRange {
                for col in colRange {
                    let digit = board[row][col]
                    if digit == "." {
                        continue
                    } else {
                        if let _ = charDuplicateMap[digit] {
                            return false
                        } else {
                            charDuplicateMap[digit] = false
                        }
                    }
                }
            }
            return true
        }
        
        //validate rows
        for row in 0..<9 {
            if !validateRange(rowRange: row..<row+1, colRange: 0..<9) {
                return false
            }
        }
        
        //validate columns
        for col in 0..<9 {
            if !validateRange(rowRange: 0..<9, colRange: col..<col+1) {
                return false
            }
        }
        
        //3*3
        for row in stride(from: 0, to: 9, by: 3) {
            for col in stride(from: 0, to: 9, by: 3) {
                if !validateRange(rowRange: row..<row+3, colRange: col..<col+3) {
                    return false
                }
            }
        }
        
        return true
    }
}

struct SetZeroes {
    func callAsFunction(_ matrix: inout [[Int]]) {
       
        let m = matrix.count, n = matrix[0].count
        var rowZero = false
        
        for row in 0..<m {
            for column in 0..<n where matrix[row][column] == 0 {
                matrix[0][column] = 0
                
                if row > 0 {
                    matrix[row][0] = 0
                } else {
                    rowZero = true
                }
            }
        }
        
        for row in 1..<m {
            for column in 1..<n where matrix[0][column] == 0 || matrix[row][0] == 0 {
                matrix[row][column] = 0
            }
        }
        
        if matrix[0][0] == 0 {
            for row in 0..<m {
                matrix[row][0] = 0
            }
        }
        
        if rowZero {
            for column in 0..<n {
                matrix[0][column] = 0
            }
        }
    }
}

class GasStation {
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        guard gas.reduce(0, +) >= cost.reduce(0, +) else {
            return -1
        }
        
        var total = 0, start = 0
        
        for i in 0..<gas.count {
            total += (gas[i] - cost[i])
            
            if total < 0 {
                total = 0
                start = i + 1
            }
        }
        
        return start
    }
}

class GameOfLife {
    func callAsFunction(_ board: inout [[Int]]) {
        /*
            Original | New  |  Value
                0    |  0   |  0
                1    |  0   |  1
                0    |  1   |  2
                1    |  1   |  3
         */
        let m = board.count, n = board[0].count
        
        func countNeighbours(_ row: Int,_ col:Int) -> Int {
            var nei = 0
            for i in row-1..<row+2 {
                for j in col-1..<col+2 {
                    if (row == i && col == j) ||  i < 0 || j < 0 || m == i || n == j {
                        continue
                    }
                    if [1,3].contains(board[i][j]) {
                        nei += 1
                    }
                }
            }
            return nei
        }
        
        for row in 0..<m {
            for col in 0..<n {
                let nei = countNeighbours(row, col)
                if board[row][col] == 1 {
                    if [2, 3].contains(nei) {
                        board[row][col] = 3
                    }
                } else if nei == 3 {
                    board[row][col] = 2
                }
            }
        }
        
        for row in 0..<m {
            for col in 0..<n {
                if [2,3].contains(board[row][col]) {
                    board[row][col] = 1
                } else if board[row][col] == 1 {
                    board[row][col] = 0
                }
            }
        }
    }
}

class TaskScheduler {

    // 621. Task Scheduler
    // Given a characters array tasks, representing the tasks a CPU needs to do, where each letter represents a different task. Tasks could be done in any order. Each task is done in one unit of time. For each unit of time, the CPU could complete either one task or just be idle.
    // However, there is a non-negative integer n that represents the cooldown period between two same tasks (the same letter in the array), that is that there must be at least n units of time between any two same tasks.
    // Return the least number of units of times that the CPU will take to finish all the given tasks.

    // Calculates the least number of units of times that the CPU will take to finish all the given tasks.

    // - Parameters:
    //   - tasks: A char array representing tasks CPU needs to do.
    //   - n: The cooldown period between two same tasks.
    // - Returns: The least number of units of time.

    // Example 1:
    // Input: tasks = ["A","A","A","B","B","B"], n = 2
    // Output: 8
    // Explanation:
    // A -> B -> idle -> A -> B -> idle -> A -> B
    // There is at least 2 units of time between any two same tasks.

    // Example 2:
    // Input: tasks = ["A","A","A","B","B","B"], n = 0
    // Output: 6
    // Explanation: On this case any permutation of size 6 would work since n = 0.
    // ["A","A","A","B","B","B"]
    // ["A","B","A","B","A","B"]
    // ["B","B","B","A","A","A"]
    // ...
    // And so on.

    // Example 3:
    // Input: tasks = ["A","A","A","A","A","A","B","C","D","E","F","G"], n = 2
    // Output: 16
    // Explanation:
    // One possible solution is
    // A -> B -> C -> A -> D -> E -> A -> F -> G -> A -> idle -> idle -> A -> idle -> idle -> A

    // Constraints:
    // 1 <= task.length <= 10^4
    // tasks[i] is upper-case English letter.
    // The integer n is in the range [0, 100].

    // - Complexity:
    //   - time: O(n), where n is the length of the tasks.
    //   - space: O(1), only constant space is used.
    
    func callAsFunction(_ tasks: [Character], _ n: Int) -> Int {
        guard !tasks.isEmpty else { return 0 }
        var counter = [Int](repeating: 0, count: 26)
        let offset = "A".utf8.first ?? 0
        var mostFrequency = 0
        var numOfMostFrequency = 0

        for task in String(tasks).utf8 { counter[Int(task - offset)] += 1 }

        for count in counter {
            if count == mostFrequency {
                numOfMostFrequency += 1
            } else if count > mostFrequency {
                mostFrequency = count
                numOfMostFrequency = 1
            }
        }

        return max((n + 1) * (mostFrequency - 1) + numOfMostFrequency, tasks.count)
    }

}

//class SlidingWindowMaximum {
//    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
//        let count = nums.count
//        if count * k == 0 {
//            return []
//        }
//        if k == 1 {
//            return nums
//        }
//
//        var maxIdx = [Int]()
//        var res = [Int]()
//
//        for i in 0..<nums.count {
//            while maxIdx.count > 0 && nums[maxIdx.last!] < nums[i] {
//                maxIdx.removeLast()
//            }
//
//            maxIdx.append(i)
//
//            if i >= k - 1 {
//                if maxIdx.first! + k == i {
//                    maxIdx.removeFirst()
//                }
//
//                res.append(nums[maxIdx.first!])
//            }
//        }
//
//        return res
//    }
//}

class LongestConsecutiveSeq {
    func callAsFunction(_ nums: [Int]) -> Int {
        var set = Set<Int>(nums), longest = 0
        
        for num in nums {
            var currentLength = 1
            dfs(num, &set, &longest, &currentLength)
        }
        
        return longest
    }
    
    private func dfs(_ num: Int, _ set: inout Set<Int>, _ longest: inout Int, _ length: inout Int) {
        if !set.contains(num) {
            return
        }
        
        longest = max(longest, length)
        set.remove(num)
        length += 1
        
        dfs(num + 1, &set, &longest, &length)
        dfs(num - 1, &set, &longest, &length)
    }
}

/*
 problem:
 Given an array nums of n integers where nums[i] is in the range [1, n], return an array of all the integers in the range [1, n] that do not appear in nums.
 
 Testcases:
 Input: nums = [4,3,2,7,8,2,3,1]
 Output: [5,6]
 
 Input: nums = [1,1]
 Output: [2]
 
 
 Constraints:
 n == nums.length
 1 <= n <= 105
 1 <= nums[i] <= n
 
 
 link: https://leetcode.com/problems/find-all-numbers-disappeared-in-an-array/
 explanation: https://www.youtube.com/watch?v=8i-f24YFWC4
 primary idea:
 - We know that all numbers in array are in range 1...nums.count. So we can use that for our advantage
 - Iterating through each element and marking that elements index in array as negative
 - Any element can already be negative. so we take absolute value  and then mark as negative
 - Return indexes of elements which are positive by adding 1 to each.
 Time Complexity: O(2n)
 Space Complexity: O(1)
 */
struct FindDisappearedNumbers {
    func callAsFunction(_ nums: [Int]) -> [Int] {
        var nums = nums
        for n in nums {
            let index = abs(n) - 1
            nums[index] = -1 * abs(nums[index])
        }
        var res = [Int]()
        for i in 0..<nums.count {
            if nums[i] > 0 {
                res.append(i + 1)
            }
        }
        return res
    }
}

/*
 problem:
 Given an array of integers nums and an integer k, return the total number of continuous subarrays whose sum equals to k.
 
 Testcases:
 Input: nums = [1,1,1], k = 2
 Output: 2
 
 Input: nums = [1,2,3], k = 3
 Output: 2
 
 
 Constraints:
 1 <= nums.length <= 2 * 104
 -1000 <= nums[i] <= 1000
 -107 <= k <= 107
 
 
 link: https://leetcode.com/problems/subarray-sum-equals-k/
 explanation: https://www.youtube.com/watch?v=fFVZt-6sgyo
 primary idea:
 - CurrentSum - K = prefixSum, Each iteration
 - At each level we calculate the diff Sum - k. if there is any prefix with that diff, it means there is a subarray that equals k
 - We maintain count of each prefix as it can also include negative numbers and having negative number can lead to multiple prefixsums with same value
 - The value of prefixSum count denotes Number of subarray possible.
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class SubarraySumEqualsK {
    //1,-1,1,1,1,1
    func callAsFunction(_ nums: [Int], _ k: Int) -> Int {
        var currentSum = 0
        var result = 0
        var prefixSums = [0: 1]
        
        for number in nums {
            currentSum += number
            let diff = currentSum - k
            
            result += prefixSums[diff, default: 0]
            prefixSums[currentSum] = 1 + prefixSums[currentSum, default: 0]
        }
        return result
    }
}

/*
 problem:
 Given an array of integers temperatures represents the daily temperatures, return an array answer such that answer[i] is the number of days you have to wait after the ith day to get a warmer temperature. If there is no future day for which this is possible, keep answer[i] == 0 instead.
 
 Testcases:
 Input: temperatures = [73,74,75,71,69,72,76,73]
 Output: [1,1,4,2,1,1,0,0]
 
 Input: temperatures = [30,40,50,60]
 Output: [1,1,1,0]
 
 Input: temperatures = [30,60,90]
 Output: [1,1,0]
 
 
 Constraints:
 1 <= temperatures.length <= 105
 30 <= temperatures[i] <= 100
 
 
 link: https://leetcode.com/problems/daily-temperatures/
 explanation: https://www.youtube.com/watch?v=WGm4Kj3lhRI
 primary idea:
 - Reverse Iteration with Stack for storing high temperatures
 
 Time Complexity: O(n)
 Space Complexity: O(n)
 */
class DailyTemperatures {
    func callAsFunction(_ temperatures: [Int]) -> [Int] {
        var stack = [(day: Int,temp: Int)](), currentDay = temperatures.count - 1
        var result = Array(repeating: 0, count: temperatures.count)
        
        while currentDay >= 0 {
            while !stack.isEmpty && stack.last!.temp <= temperatures[currentDay] {
                stack.removeLast()
            }
            result[currentDay] = stack.isEmpty ? 0 : stack.last!.day - currentDay
            stack.append((currentDay, temperatures[currentDay]))
            currentDay -= 1
        }
        return result
    }
}

/*
 problem:
 There is a rectangular brick wall in front of you with n rows of bricks. The ith row has some number of bricks each of the same height (i.e., one unit) but they can be of different widths. The total width of each row is the same.

 Draw a vertical line from the top to the bottom and cross the least bricks. If your line goes through the edge of a brick, then the brick is not considered as crossed. You cannot draw a line just along one of the two vertical edges of the wall, in which case the line will obviously cross no bricks.

 Given the 2D array wall that contains the information about the wall, return the minimum number of crossed bricks after drawing such a vertical line.
 
 Testcases:
 Input: wall = [[1,2,2,1],[3,1,2],[1,3,2],[2,4],[3,1,2],[1,3,1,1]]
 Output: 2
 
 Input: wall = [[1],[1],[1]]
 Output: 3
 
 
 Constraints:
 n == wall.length
 1 <= n <= 104
 1 <= wall[i].length <= 104
 1 <= sum(wall[i].length) <= 2 * 104
 sum(wall[i]) is the same for each row i.
 1 <= wall[i][j] <= 231 - 1
 
 
 link: https://leetcode.com/problems/brick-wall/
 explanation: https://www.youtube.com/watch?v=Kkmv2h48ekw
 primary idea:
 - Instead of counting how many bricks crossed, we calculate how many gaps left on each vertical line
 - Brick crossed on particular vertical line = Length of wall - Gaps
 - As we should neglect start and end of wall, we iterate only till last second brick in each row
 Time Complexity: O(m * n)
 Space Complexity: O(n)
 */
class BrickWall {
    func callAsFunction(_ wall: [[Int]]) -> Int {
        var leastBricks = [Int: Int]()
        var maxGapCount = -1
        
        for row in wall {
            var weight = 0
            for index in 0..<row.count-1 {
                weight += row[index]
                leastBricks[weight, default: 0] += 1
                maxGapCount = max(maxGapCount, leastBricks[weight, default: 0])
            }
        }
        return maxGapCount != -1 ? wall.count - maxGapCount : wall.count
    }
}

class FindVehiclenumber {
    func callAsFunction(_ numbers: [Int]) -> [Int] {
        var filteredNumbers = [Int]()
        for number in numbers {
            let numberList = convertNumberToList(number: number)
            var addedVal = numberList.reduce(0, {$0 + $1})
            if addedVal > 10 {
                addedVal = convertNumberToList(number: addedVal).reduce(0, +)
            }
            if addedVal == 9 && isNumberLastDigitHigh(numberList) {
                filteredNumbers.append(number)
            }
        }
        return filteredNumbers
    }
    
    func convertNumberToList(number: Int) -> [Int] {
        var result = [Int](), number = number
        while number > 0 {
            let lastDigit = number % 10
            result.append(lastDigit)
            number = number / 10
        }
        return result
    }
    
    func isNumberLastDigitHigh(_ numberList: [Int]) -> Bool {
        let lastnumber = numberList.first!
        
        for i in 1..<numberList.count {
            let current = numberList[i]
            if current > lastnumber {
                return false
            }
        }
        return true
    }
}
