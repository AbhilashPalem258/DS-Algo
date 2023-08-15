//
//  SimplifyPath.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 19/06/21.
//

import Foundation

class MinStack {

    var minStack: [Int]
    var stack: [Int]
    
    init() {
        self.minStack = []
        self.stack = []
    }
    
    func push(_ val: Int) {
        self.stack.append(val)
        if minStack.isEmpty || val <= minStack.last! {
            self.minStack.append(val)
        }
    }
    
    func pop() {
        guard !stack.isEmpty else {
            return
        }
        let popVal = stack.removeLast()
        if let last = minStack.last, last == popVal {
            minStack.removeLast()
        }
    }
    
    func top() -> Int {
        return stack.isEmpty ? -1 : stack.last!
    }
    
    func getMin() -> Int {
        return minStack.isEmpty ? -1 : minStack.last!
    }
}

/*
 problem:
 Design a max stack that supports push, pop, top, peekMax and popMax.

 push(x) -- Push element x onto stack.
 pop() -- Remove the element on top of the stack and return it.
 top() -- Get the element on the top.
 peekMax() -- Retrieve the maximum element in the stack.
 popMax() -- Retrieve the maximum element in the stack, and remove it. If you find more than one maximum elements, only remove the top-most one.
 Example 1:

 MaxStack stack = new MaxStack();
 stack.push(5);
 stack.push(1);
 stack.push(5);
 stack.top(); -> 5
 stack.popMax(); -> 5
 stack.top(); -> 1
 stack.peekMax(); -> 5
 stack.pop(); -> 1
 stack.top(); -> 5
 Note: -1e7 <= x <= 1e7 Number of operations won't exceed 10000. The last four operations won't be called when stack is empty.
 
 
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
class MaxStack {
    var stack: [Int]
    var maxStack: [Int]

    /** initialize your data structure here. */
    init() {
        stack = [Int]()
        maxStack = [Int]()
    }
    
    func push(_ x: Int) {
        stack.append(x)
        maxStack.append(maxStack.isEmpty ? x : max(x, maxStack.last!))
    }
    
    @discardableResult
    func pop() -> Int {
        maxStack.removeLast()
        return stack.removeLast()
    }
    
    func top() -> Int {
        return stack.last!
    }
    
    func peekMax() -> Int {
        return maxStack.last!
    }
    
    func popMax() -> Int {
        let maxVal = peekMax()
        
        // remove max from stack
        var buffer = [Int]()
        while top() != maxVal {
            buffer.append(pop())
        }
        pop()
        while !buffer.isEmpty {
            push(buffer.removeLast())
        }
        
        return maxVal
    }
}


//Link: https://leetcode.com/problems/valid-parentheses/
struct ValidParentheses {
    func callAsFunction(_ s: String) -> Bool {
        let rule = "()[]{}"
        var ruleMap = [Character: Int]()
        for (i, element) in rule.enumerated() {
            ruleMap[element] = i
        }
        var stack = [Character]()
        for char in s {
            if ruleMap[char]! % 2 == 0 {
                stack.append(char)
            } else {
                if stack.isEmpty {
                    return false
                } else {
                    if ruleMap[char]! - ruleMap[stack.last!]! == 1 {
                        stack.removeLast()
                    } else {
                        return false
                    }
                }
            }
        }
        return stack.isEmpty ? true : false
    }
}


struct SimplifyPath {
    func simplifyPath(_ path: String) -> String {
        var components = [String]()
        let pathComponents = path.components(separatedBy: "/")
        for pathComponent in pathComponents {
            switch pathComponent {
            case "", ".":
                break
            case "..":
                _ = components.popLast()
            default:
                components.append(pathComponent)
            }
        }
        return "/" + components.joined(separator: "/")
    }
}

struct RemoveKDigits {
    func callAsFunction(_ num: String, _ k: Int) -> String {
        var stack = [String](), k = k
        var num = Array(num)
        let size = num.count - k

        if num.count == k {
            return "0"
        }

        for char in num {
            while k > 0, !stack.isEmpty, let last = Int(stack.last!), let current = Int(String(char)), last > current {
                stack.removeLast()
                k -= 1
            }
            stack.append(String(char))
        }
        stack = Array(stack[0..<size])
        for num in stack {
            if num != "0" {
                break
            }
            stack.removeFirst()
        }
        return stack.isEmpty ? "0" : stack.joined()
    }
}
/*
 Given a string representing arbitrarily nested ternary expressions, calculate the result of the expression. You can always assume that the given expression is valid and only consists of digits 0-9, ?, :, T and F (T and F represent True and False respectively).
 
 Note:
 The length of the given string is ≤ 10000.
 Each number will contain only one digit.
 The conditional expressions group right-to-left (as usual in most languages).
 The condition will always be either T or F. That is, the condition will never be a digit.
 The result of the expression will always evaluate to either a digit 0-9, T or F.
 
 
 Example 1:
 Input: "T?2:3"

 Output: "2"

 Explanation: If true, then result is 2; otherwise result is 3.
 
 
 Example 2:
 Input: "F?1:T?4:5"

 Output: "4"

 Explanation: The conditional expressions group right-to-left. Using parenthesis, it is read/evaluated as:

              "(F ? 1 : (T ? 4 : 5))"                   "(F ? 1 : (T ? 4 : 5))"
           -> "(F ? 1 : 4)"                 or       -> "(T ? 4 : 5)"
           -> "4"                                    -> "4"
 
 
 Example 3:
 Input: "T?T?F:5:3"

 Output: "F"

 Explanation: The conditional expressions group right-to-left. Using parenthesis, it is read/evaluated as:

              "(T ? (T ? F : 5) : 3)"                   "(T ? (T ? F : 5) : 3)"
           -> "(T ? F : 3)"                 or       -> "(T ? F : 5)"
           -> "F"                                    -> "F"
 */
struct TernaryExpressionParser {
    func callAsFunction(_ expression: String) -> String  {
        var stack = [Character]()
         
         for char in expression.reversed() {
             if !stack.isEmpty && stack.last! == "?" {
                 stack.removeLast()
                 let first = stack.removeLast()
                 stack.removeLast()
                 let second = stack.removeLast()
                 
                 if char == "T" {
                     stack.append(first)
                 } else {
                     stack.append(second)
                 }
             } else {
                 stack.append(char)
             }
         }
         
         return stack.isEmpty ? "" : String(stack.last!)
    }
}

fileprivate extension StringProtocol {
    subscript(offset: Int) -> Character {
        return self[index(startIndex, offsetBy: offset)]
    }
}

struct DecodeString {
    func callAsFunction(_ s: String) -> String {
        var res = "", strStack = [String](), intStack = [Int]()
        var i = 0
        while i < s.count {
            if s[i].isNumber {
                var count = 0
                while s[i].isNumber {
                    count = (count * 10) + Int(String(s[i]))!
                    i += 1
                }
                intStack.append(count)
            } else if s[i] == "[" {
                strStack.append(res)
                res = ""
                i += 1
            } else if s[i] == "]" {
                let count = intStack.removeLast()
                var crStr = strStack.removeLast()
                for _ in 1...count {
                    crStr += res
                }
                res = crStr
                i += 1
            } else {
                res += String(s[i])
                i += 1
            }
        }
        return res
    }
}

struct BasicCalculator {
    func callAsFunction(_ s: String) -> Int {
        var result = 0, operand = 0, sign = 1, stack = [Int]()
        for char in s {
            if char.isNumber {
                operand = (operand * 10) + char.wholeNumberValue!
            } else if char == "+" {
                result += operand * sign
                sign = 1
                operand = 0
            } else if char == "-" {
                result += operand * sign
                sign = -1
                operand = 0
            } else if char == "(" {
                stack.append(result)
                stack.append(sign)
                sign = 1
                result = 0
            } else if char == ")" {
                result += operand * sign
                result *= stack.removeLast()
                result += stack.removeLast()
                operand = 0
            }
        }
        return result + (operand * sign)
    }
}


//Link: https://leetcode.com/problems/longest-valid-parentheses/
struct LongestValidParenthesesII {
    func callAsFunction(_ s: String) -> Int {
        var stack = [Int](), start = 0, longest = 0
        for (i, element) in s.enumerated() {
            if element == "(" {
                stack.append(i)
            } else {
                if stack.isEmpty {
                    start = i + 1
                } else {
                    stack.removeLast()
                    
                    if let last = stack.last {
                        longest = i - last
                    } else {
                        longest = i - start + 1
                    }
                }
            }
        }
        return longest
    }
}

//Link: https://leetcode.com/problems/evaluate-reverse-polish-notation/
struct EvaluateReversePolishNotation {
    func callAsFunction(_ tokens: [String]) -> Int {
        var stack = [Int]()
        
        for token in tokens {
            if let num = Int(token) {
                stack.append(num)
            } else {
                if let prev = stack.popLast(), let postPrev = stack.popLast() {
                    stack.append(operate(token, prev, postPrev))
                }
            }
        }
        if let last = stack.last {
            return last
        } else {
            fatalError("Invalid Result")
        }
    }
    
    private func operate(_ token: String, _ prevNum: Int, _ postPrevNum: Int) -> Int {        
        switch token {
        case "+":
            return prevNum + postPrevNum
        case "-":
            return prevNum - postPrevNum
        case "*":
            return prevNum * postPrevNum
        case "/":
            return prevNum / postPrevNum
        default:
            fatalError("Invalid Input")
        }
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
