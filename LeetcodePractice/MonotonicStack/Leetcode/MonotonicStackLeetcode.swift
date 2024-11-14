//
//  MonotonicStackLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 07/05/24.
//

import Foundation

/*
 problem: https://leetcode.com/problems/next-greater-element-i/
 explanation: Monotonic decreasing stack, as soon as it find a invalid condition, we found next greater element of that index
 primary idea:
 Time Complexity: O(n)
 Space Complexity: O(n)
 */
class NextGreaterElementI {
    func callAsFunction(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var greaterMap = [Int: Int]()
        var stack = [Int]()
        
        for (_, num) in nums2.enumerated() {
            while let last = stack.last, last < num {
                stack.removeLast()
                greaterMap[last] = num
            }
            stack.append(num)
        }
        
        return nums1.map{ greaterMap[$0] ??  -1}
    }
}

/*
 problem: https://leetcode.com/problems/next-greater-element-ii/
 explanation: Refer above problem. As the array is circular, create a array nums + nums
 primary idea:
 Time Complexity: O(n)
 Space Complexity: O(n)
 */
class NextGreaterElementII {
    func callAsFunction(_ nums: [Int]) -> [Int] {
        let count = nums.count
        var result = [Int](repeating: -1, count: nums.count)
        var nums = nums + nums
        var stack = [Int]()
        
        for (index,num) in nums.enumerated() {
            while let last = stack.last, nums[last] < num {
                 stack.removeLast()
                 result[last % count] = num
            }
            stack.append(index)
        }
        return result
    }
}

/*
 problem:
 Design an algorithm that collects daily price quotes for some stock and returns the span of that stock's price for the current day.

 The span of the stock's price today is defined as the maximum number of consecutive days (starting from today and going backward) for which the stock price was less than or equal to today's price.

 For example, if the price of a stock over the next 7 days were [100,80,60,70,60,75,85], then the stock spans would be [1,1,1,2,1,4,6].
 Implement the StockSpanner class:

 StockSpanner() Initializes the object of the class.
 int next(int price) Returns the span of the stock's price given that today's price is price.
 
 Testcases:
 Input
 ["StockSpanner", "next", "next", "next", "next", "next", "next", "next"]
 [[], [100], [80], [60], [70], [60], [75], [85]]
 Output
 [null, 1, 1, 1, 2, 1, 4, 6]

 Explanation
 StockSpanner stockSpanner = new StockSpanner();
 stockSpanner.next(100); // return 1
 stockSpanner.next(80);  // return 1
 stockSpanner.next(60);  // return 1
 stockSpanner.next(70);  // return 2
 stockSpanner.next(60);  // return 1
 stockSpanner.next(75);  // return 4, because the last 4 prices (including today's price of 75) were less than or equal to today's price.
 stockSpanner.next(85);  // return 6
 
 Constraints:
 1 <= price <= 105
 At most 104 calls will be made to next
 
 link: https://leetcode.com/problems/online-stock-span/
 explanation:
 primary idea:
 -  Use stack to keep record of last element with it span. last elements span itself let us know how many decreeasing elements exists prevuous to it
 - Figure to understand, all these elements will be in stack
    *
        *           *
            *
                *
                    
 Time Complexity: O(n)
 Space Complexity: O(n)
 */
class StockSpanner {
    
    var stack: [(price: Int, span: Int)]

    init() {
        stack = []
    }
    
    func next(_ price: Int) -> Int {
        var span = 1
        while let last = stack.last, last.price <= price {
            span += last.span
            _ = stack.popLast()
        }
        stack.append((price, span))
        return span
    }
}

/*
 problem:
 There are n cars going to the same destination along a one-lane road. The destination is target miles away.

 You are given two integer array position and speed, both of length n, where position[i] is the position of the ith car and speed[i] is the speed of the ith car (in miles per hour).

 A car can never pass another car ahead of it, but it can catch up to it and drive bumper to bumper at the same speed. The faster car will slow down to match the slower car's speed. The distance between these two cars is ignored (i.e., they are assumed to have the same position).

 A car fleet is some non-empty set of cars driving at the same position and same speed. Note that a single car is also a car fleet.

 If a car catches up to a car fleet right at the destination point, it will still be considered as one car fleet.

 Return the number of car fleets that will arrive at the destination.
 
 Testcases:
 
 Example 1:
 Input: target = 12, position = [10,8,0,5,3], speed = [2,4,1,1,3]
 Output: 3
 Explanation:
 The cars starting at 10 (speed 2) and 8 (speed 4) become a fleet, meeting each other at 12.
 The car starting at 0 does not catch up to any other car, so it is a fleet by itself.
 The cars starting at 5 (speed 1) and 3 (speed 3) become a fleet, meeting each other at 6. The fleet moves at speed 1 until it reaches target.
 Note that no other cars meet these fleets before the destination, so the answer is 3.
 
 Example 2:
 Input: target = 10, position = [3], speed = [3]
 Output: 1
 Explanation: There is only one car, hence there is only one fleet.
 
 Example 3:
 Input: target = 100, position = [0,2,4], speed = [4,2,1]
 Output: 1
 Explanation:
 The cars starting at 0 (speed 4) and 2 (speed 2) become a fleet, meeting each other at 4. The fleet moves at speed 2.
 Then, the fleet (speed 2) and the car starting at 4 (speed 1) become one fleet, meeting each other at 6. The fleet moves at speed 1 until it reaches target.
 
 
 Constraints:
 n == position.length == speed.length
 1 <= n <= 105
 0 < target <= 106
 0 <= position[i] < target
 All the values of position are unique.
 0 < speed[i] <= 106
 
 
 link: https://leetcode.com/problems/car-fleet/
 explanation: https://www.youtube.com/watch?v=Pr6T-3yB9RM
 primary idea:
 - Sort the input
 - Caluclate time to reach destination for each car and if it's time is less than or equal to previous car then it travels along with previous car, thus both cars forming one car fleet.
 Time Complexity: O(nlogn)
 Space Complexity: O(n)
 */
class CarFleet {
    func callAsFunction(_ target: Int, _ position: [Int], _ speed: [Int]) -> Int {
        let target: Double = Double(target)
        var pairs = [(position: Double, speed: Double)]()
        for i in 0..<position.count {
            let pos = position[i]
            let speed = speed[i]
            pairs.append((Double(pos), Double(speed)))
        }
        
        pairs.sort{$0.position > $1.position}
        
        var stack = [Double]()
        for pair in pairs {
            let currentCartimeToReach: Double = (Double(target) - pair.position)/pair.speed
            if stack.isEmpty || !(currentCartimeToReach <= stack.last!) {
                stack.append(currentCartimeToReach)
            }
        }
        return stack.count
    }
}


/*
 problem:
 Given an array of integers heights representing the histogram's bar height where the width of each bar is 1, return the area of the largest rectangle in the histogram.
 
 Testcases:
 Input: heights = [2,1,5,6,2,3]
 Output: 10
 Explanation: The above is a histogram where width of each bar is 1.
 The largest rectangle is shown in the red area, which has an area = 10 units.
 
 Input: heights = [2,4]
 Output: 4

 
 Constraints:
 1 <= heights.length <= 105
 0 <= heights[i] <= 104

 
 link: https://leetcode.com/problems/largest-rectangle-in-histogram/
 explanation: https://www.youtube.com/watch?v=zx5Sw9130L0&list=PLot-Xpze53letfIu9dMzIIO7na_sqvl0w&index=5
 primary idea:
 - Use stack and as soon as the current height is lower than earlier, pop all last height's in stack which are higher than current one. calculate area and modify maxArea if needed. After Iteration, check if stack is empty. if not calculate maxArea with all stack elementss
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
struct LargestRectangleHistogram {
    func callAsFunction(_ heights: [Int]) -> Int {
        var maxArea = 0, stack = [(index: Int, height: Int)]()
        
        var i = 0
        for height in heights {
            var start = i
            while !stack.isEmpty && stack.last!.height > height {
                let prev = stack.popLast()!
                maxArea = max(maxArea, prev.height * (i - prev.index))
                start = prev.index
            }
            stack.append((start, height))
            i += 1
        }
        
        for (index, height) in stack {
            maxArea = max(maxArea, height * (heights.count - index))
        }
        
        return maxArea
    }
}
