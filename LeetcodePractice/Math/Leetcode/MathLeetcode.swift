//
//  MathLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 16/08/21.
//

import Foundation

class AddBinary {
    //Time & space: O(a + b)
    func callAsFunction(_ a: String, _ b: String) -> String {
        let a = Array(a), b = Array(b)
        let count = max(a.count, b.count)
        var res = "", carry = 0
        
        for i in 0..<count {
            let aDigit = i < a.count ? a[a.count - 1 - i].wholeNumberValue! : 0
            let bDigit = i < b.count ? b[b.count - 1 - i].wholeNumberValue! : 0
            
            let sum = aDigit + bDigit + carry
            let char = String(sum % 2)
            res = char + res
            carry = sum/2
        }
        
        if carry == 1 {
            res = "1" + res
        }
        
        return res
    }
}

/*
 problem:
 You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

 You may assume the two numbers do not contain any leading zero, except the number 0 itself.
 
 Testcases:
 Input: l1 = [2,4,3], l2 = [5,6,4]
 Output: [7,0,8]
 Explanation: 342 + 465 = 807.
 
 Input: l1 = [0], l2 = [0]
 Output: [0]
 
 Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
 Output: [8,9,9,9,0,0,0,1]
 
 Constraints:
 The number of nodes in each linked list is in the range [1, 100].
 0 <= Node.val <= 9
 It is guaranteed that the list represents a number that does not have leading zeros.
 
 link: https://leetcode.com/problems/plus-one/
 explanation: https://www.youtube.com/watch?v=wgFPrzTjm7s
 primary idea:
 - create a dummy node, update the carry and addd the result node to dummy linked list
 Time Complexity: O(MAX(N, M)) where N and M are the lengths of l1 and l2
 Space Complexity: O(MAX(N, M)) for the length of the new list
 */

class AddTwoNumbers {
    func callAsFunction(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let dummy = ListNode(0)
        var current = dummy
        var firstLNode = l1, secondLNode = l2, carry = 0
        
        while firstLNode != nil || secondLNode != nil {
            
            let firstVal = firstLNode?.val ?? 0, secondVal = secondLNode?.val ?? 0
            let sum = firstVal + secondVal + carry

            current.next = ListNode(sum%10)
            current = current.next!
            carry = sum/10
            
            firstLNode = firstLNode?.next
            secondLNode = secondLNode?.next
        }
        if carry > 0 {
            current.next = ListNode(carry)
        }
        return dummy.next
    }
}

class AddDigits {
    func callAsFunction(_ num: Int) -> Int {
        if num <= 9 {
            return num
        }
        var num = num
        func calculateSum() {
            var sum = 0
            while num > 0 {
                sum += num%10
                num = num/10
            }
            num = sum
        }
        
        while num > 9 {
            calculateSum()
        }
        return num
    }
}

class PlusOne {
    func callAsFunction(_ digits: [Int]) -> [Int] {
        var digits = digits, carry = 0
        for i in 0..<digits.count {
            let sum = digits[digits.count - 1 - i] + 1
            digits[digits.count - 1 - i] = sum % 10
            carry = sum/10
            if carry == 0 {
                break
            }
        }
        if carry > 0 {
            digits = [carry] + digits
        }
        return digits
    }
}

class MissingNumber {
    func callAsFunction(_ nums: [Int]) -> Int {
        var sum = 0
        for num in nums {
            sum += num
        }
        
        let n = nums.count
        //formula for addition from 1 to N
        let total = n * (n + 1)/2
        return total - sum
    }
}

func divide(_ dividend: Int, _ divisor: Int) -> Int {

    var mutableDividend = dividend
    var mutableDivisor = divisor

    let lowerbound = Int32.min
    let upperbound = Int32.max

    if divisor == -1 {
        if dividend == lowerbound || dividend == upperbound {
            return Int(upperbound)
        }
    }
    var negatives = 2

    if mutableDividend > 0 {
      mutableDividend = -mutableDividend
      negatives -= 1
    }

    if mutableDivisor > 0 {
      mutableDivisor = -mutableDivisor
      negatives -= 1
    }

    var quotient = 0

    while mutableDivisor >= mutableDividend {
      var value = mutableDivisor
      var power = -1
      while (value >= Int32.min/2 && value + value >= mutableDividend) {
          value += value
          power += power
        }
        quotient += power
        mutableDividend = mutableDividend - value
     }

    if negatives != 1 {
      return -quotient
    }
    return quotient
}

/*
 problem:
 Given an integer n, break it into the sum of k positive integers, where k >= 2, and maximize the product of those integers.

 Return the maximum product you can get.

 Testcases:
 
 Example 1:

 Input: n = 2
 Output: 1
 Explanation: 2 = 1 + 1, 1 × 1 = 1.
 
 Example 2:

 Input: n = 10
 Output: 36
 Explanation: 10 = 3 + 3 + 4, 3 × 3 × 4 = 36.
 
 Constraints:
 2 <= n <= 58
 
 link: https://leetcode.com/problems/integer-break/
 explanation: https://www.youtube.com/watch?v=in6QbUPMJ3I&t=524s
 primary idea:
 - Tabular DP Approach
 Time Complexity:
 Space Complexity:
 */
class IntegerBreak {
    func callAsFunction(_ n: Int) -> Int {
        var cache = [1: 1]
        
        for num in 2..<n+1 {
            cache[num] = num == n ? 0 : num
            
            for i in 1..<num {
                let product = cache[i]! * cache[num - i]!
                cache[num] = max(cache[num]!, product)
            }
        }
        
        return cache[n] ?? -1
    }
}


/*
 problem:
 Given an integer n, return the number of trailing zeroes in n!.

 Testcases:
 Input: n = 3
 Output: 0
 Explanation: 3! = 6, no trailing zero.
 
 Input: n = 5
 Output: 1
 Explanation: 5! = 120, one trailing zero.
 
 Input: n = 0
 Output: 0
 
 Constraints:
 0 <= n <= 104
 
 link: https://leetcode.com/problems/factorial-trailing-zeroes/
 explanation: https://www.youtube.com/watch?v=IJ1u9iHXH8w
 primary idea:
 - zeros can be formed by multiples of 10 and 10 can even be divded in to 2 and 5.
 - In a factorial 2 occurs every alternate number and 5 occurs every fifth number. If we are able to find the count of 5, that is equal to count of trailing zeros
 
 Time Complexity: O(logN)
 Space Complexity: O(1)
 */
class FactorialTrailingZeros {
    func callAsFunction(_ n: Int) -> Int {
        var a = 5
        var zeros = 0
        
        while a <= n {
            zeros += n/a
            a *= 5
        }
        
        return zeros
    }
}

/*
 problem:
 
 Testcases:
 
 Constraints:
 
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
class HappyNumber {
    func callAsFunction(_ n: Int) -> Bool {
        var set = Set<Int>(), num = n
        
        while !set.contains(num) {
            set.insert(num)
            let squarednum = sumOfSquares(num: num)
            
            if squarednum == 1 {
                return true
            }
            num = squarednum
        }
        
        return false
    }
    
    func sumOfSquares(num: Int) -> Int {
        var res = 0, num = num
        
        while num > 0 {
            let digit = num % 10
            let square = digit * digit
            res += square
            
            num = num/10
        }
        
        return res
    }
}

class SingleNumber {
    func callAsFunction(_ nums: [Int]) -> Int {
        var set = Set<Int>()
        
        for num in nums {
            if set.contains(num) {
                set.remove(num)
            } else {
                set.insert(num)
            }
        }
        
        return set.first ?? -1
    }
    
    //Recommended
    func usingXOR(_ nums: [Int]) -> Int {
        var res = 0
        
        for num in nums {
            res ^= num
        }
        
        return res
    }
    
}

/*
 problem:
 An ugly number is a positive integer whose prime factors are limited to 2, 3, and 5.

 Given an integer n, return true if n is an ugly number.
 
 Testcases:
 Input: n = 6
 Output: true
 Explanation: 6 = 2 × 3
 
 Input: n = 8
 Output: true
 Explanation: 8 = 2 × 2 × 2
 
 Input: n = 14
 Output: false
 Explanation: 14 is not ugly since it includes the prime factor 7.
 
 Input: n = 1
 Output: true
 Explanation: 1 has no prime factors, therefore all of its prime factors are limited to 2, 3, and 5.
 
 Constraints:
 -231 <= n <= 231 - 1
 
 link: https://leetcode.com/problems/ugly-number/
 explanation: https://www.youtube.com/watch?v=M0Zay1Qr9ws&t=309s
 primary idea:
 - Iterate through each prime factor and divide number by sspecific prime factor.
 - If at the end number remains 1 then it is a ugly number or else it is not
 Time Complexity: O(log^2^N)
 Space Complexity: O(n)
 */
class UglyNumber {
    func callAsFunction(_ n: Int) -> Bool {
        if n <= 0 {
            return false
        }
        
        var n = n
        for pFactor in [2,3,5] {
            while n % pFactor == 0 {
                n /= pFactor
            }
        }
        
        return n == 1
    }
}

/*
 problem:
 An ugly number is a positive integer whose prime factors are limited to 2, 3, and 5.

 Given an integer n, return the nth ugly number.
 
 Testcases:
 Input: n = 10
 Output: 12
 Explanation: [1, 2, 3, 4, 5, 6, 8, 9, 10, 12] is the sequence of the first 10 ugly numbers.
 
 Input: n = 1
 Output: 1
 Explanation: 1 has no prime factors, therefore all of its prime factors are limited to 2, 3, and 5.
 
 Constraints:
 1 <= n <= 1690
 
 link: https://leetcode.com/problems/ugly-number-ii/
 explanation: https://www.youtube.com/watch?v=Mjnku18C-VM
 primary idea:
 - DP Tabulation approach
 Time Complexity: O(n)
 Space Complexity: O(n)
 */
class UglyNumberII {
    func callAsFunction(_ n: Int) -> Int {
        var result = Array(repeating: -1, count: n)
        result[0] = 1
        
        var p2 = 0, p3 = 0, p5 = 0
        
        for i in 1..<n {
            let factor2 = result[p2] * 2
            let factor3 = result[p3] * 3
            let factor5 = result[p5] * 5

            let minVal = min(factor2, factor3, factor5)
            result[i] = minVal
            
            if minVal == factor2 { p2 += 1 }
            if minVal == factor3 { p3 += 1 }
            if minVal == factor5 { p5 += 1 }
        }
        return result[n - 1]
    }
}

class SuperUglyNumber {
    func callAsFunction(_ n: Int, _ primes: [Int]) -> Int {
        var result = Array(repeating: -1, count: n)
        result[0] = 1
        
        var indexArr = Array(repeating: 0, count: primes.count)
        
        for i in 1..<n {
            var minVal = Int.max
            
            for j in 0..<primes.count {
                let factorVal = result[indexArr[j]] * primes[j]
                
                if factorVal < minVal {
                    minVal = factorVal
                }
            }
            
            result[i] = minVal
            
            for j in 0..<primes.count {
                if minVal == result[indexArr[j]] * primes[j] {
                    indexArr[j] += 1
                }
            }
        }
        
        return result[n - 1]
    }
}

class CountPrimes {
    func callAsFunction(_ n: Int) -> Int {
        if n <= 2 {
            return 0
        }
        
        var compositeMap = Array(repeating: false, count: n)
        compositeMap[0] = true
        compositeMap[1] = true
        
        let limit = Int(sqrt(Double(n)))
        for i in 2..<limit+1 where compositeMap[i] == false {
            var j = i*i
            while j < n {
                compositeMap[j] = true
                j += i
            }
        }
        
        var count = 0
        for i in 2..<n where compositeMap[i] == false {
            count += 1
        }
        
        return count
    }
}

class StringToInteger {
    func myAtoi(_ s: String) -> Int {
        var result = 0, sign = 1
        
        for (i, val) in s.utf8.enumerated() {
            let value = Int(val)
            if i == 0 && value == 45 {
                sign = -1
            } else {
                let number = value - Int("0".unicodeScalars.first!.value)
                if number >= 0 && number <= 9 {
                    result = (result * 10) + number
                }
            }
        }

        return result * sign
    }
}
fileprivate extension String {
    subscript(_ i: Int) -> Character? {
        self[self.index(startIndex, offsetBy: i)]
    }
}

class PowXN {
    func callAsFunction(_ x: Double, _ n: Int) -> Double {
        func helper(val: Double, exp: Int) -> Double {
            if val == 0 { return 0 }
            if exp == 0 { return 1 }
            
            let res = helper(val: val * val, exp: exp/2)
            return exp % 2 == 0 ? res : res * val
        }
        
        let res = helper(val: x, exp: abs(n))
        return n < 0 ? 1/res : res
    }
}

class Pow2 {
    func callAsFunction(_ n: Int) -> Bool {
        var val = 1
        while val < n {
            val *= 2
        }
        return val == n
    }
}

class Pow3 {
    func callAsFunction(_ n: Int) -> Bool {
        var val = 1
        while val < n {
            val *= 3
        }
        return val == n
    }
}

class SumOfTwoIntegers {
    func callAsFunction(_ a: Int, _ b: Int) -> Int {
        
    }
}

class FractionToDecimal {
    func callAsFunction(_ numerator: Int, _ denominator: Int) -> String {
        if numerator == 0 {
            return "\(numerator)"
        }
        var output: [String] = []
        if (numerator < 0 && denominator > 0) || (numerator > 0 && denominator < 0) {
            output.append("-")
        }
        
        let numerator = abs(numerator), denominator = abs(denominator)
        
        output.append("\(numerator/denominator)")
        if numerator % denominator == 0 {
            return output.joined()
        }
        
        output.append(".")
        var num = numerator % denominator
        
        var map = [Int: Int]()
        map[num] = output.count
        
        while num != 0 {
            num *= 10
            output.append("\(num/denominator)")
            num = num % denominator
            
            if let index = map[num] {
                output.insert("(", at: index)
                output.append(")")
                break
            } else {
                map[num] = output.count
            }
        }
        return output.joined()
    }
}

/*
 problem:
 Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can trap after raining.
 
 Testcases:
 Input: height = [0,1,0,2,1,0,1,3,2,1,2,1]
 Output: 6
 Explanation: The above elevation map (black section) is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped.
 
 Input: height = [4,2,0,3,2,5]
 Output: 9
 
 Constraints:
 n == height.length
 1 <= n <= 2 * 104
 0 <= height[i] <= 105
 
 link: https://leetcode.com/problems/trapping-rain-water/
 explanation: https://www.youtube.com/watch?v=ZI2z5pq0TqA&t=213s (Only check explanation part, coding part is wrong in video)
 primary idea:
 - Two pointer, l is left pointer starts at start of arr and r is right pointer, starts at end of arr.
 Time Complexity: O(n)
 Space Complexity: O(1)
 */

class TrappingRainWater {
    func callAsFunction(_ height: [Int]) -> Int {
        var l = 0, r = height.count - 1
        var maxLeft = height[0], maxRight = height[height.count - 1]
        
        var result = 0
        
        while l < r {
            if maxLeft <= maxRight {
                l += 1
                result += max(0, maxLeft - height[l])
                maxLeft = max(maxLeft, height[l])
            } else {
                r -= 1
                result += max(0, maxRight - height[r])
                maxRight = max(maxRight, height[r])
            }
        }
        
        return result
    }
}

class CountingBits {
    func callAsFunction(_ n: Int) -> [Int] {
        var dp = [Int](repeating: 0, count: n + 1)
        var offset = 1
        
        for i in 1..<n+1 {
            if offset * 2 == i {
                offset = i
            }
            dp[i] = 1 + dp[i - offset]
        }
        
        return dp
    }
}

class GrayCode {
    func grayCode(_ n: Int) -> [Int] {
        if n == 1 { return [0, 1] }
        
        let sequence = grayCode(n - 1)
        var result = sequence
        
        for val in sequence.reversed() {
            result.append(val | 1 << (n - 1))
        }
        
        return result
    }
}
