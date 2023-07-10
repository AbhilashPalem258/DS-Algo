//
//  MathLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 16/08/21.
//

import Foundation
import CoreVideo

/*
 Bits understanding:
 Convert Number to Bits and viceversa: https://www.youtube.com/watch?v=rsxT4FfRBaM
 
 Understanding of Bitwise inverted(~), AND(&), OR(|), XOR(^) operators and understanding of Bit Shift operators: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/advancedoperators
 
 Bitwise,
 1. Inverted(~): Unary prefix operator: Flips all bits
 2. AND(&): Infix operator: If Both of the bit is 1, it results in 1 or else 0
 3. OR(|): Infix operator: either or both of the bit is 1, it results in 1
 4. XOR(^): Infix operator: either of the bit should be 1, Both of the bit to be 1 results in 0
 
 
 Bit Shifting Operators:
 1. <<: Left Shifting operator: increase power of 2 by 1
    2 << 1 == 2 * 2(pow 1) == 4
    2 << 3 == 2 * 2(pow 3) == 16
 2. >>: Right Shifting Operator:  decrease power of 2 by 1
    128 >> 1 == 128 / 2(pow 1) == 64
    64 >> 3 == 64 / 2(pow 3) ==
 More understanding: https://stackoverflow.com/questions/30332724/what-does-shift-left-actually-do-in-swift
 */

class PalindromeNumber {
    func callAsFunction(_ x: Int) -> Bool  {
        var xArr = Array(String(x))
        
        var l = 0, r = xArr.count - 1
        while l < r {
            if xArr[l] != xArr[r] {
                return false
            }
            l += 1
            r -= 1
        }
        return true
    }
}

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

class DivideTwoIntegers {
    func callAsFunction(_ dividend: Int, _ divisor: Int) -> Int {
        if dividend == 1 << 31 && divisor < 0 {
            return Int.max - 1
        }
        
        let sign = (dividend < 0) == (divisor < 0) ? 1 : -1
        var dividend = abs(dividend)
        let divisor = abs(divisor)
        
        var result = 0
        while dividend - divisor >= 0 {
            var count = 0
            var incrementalVal = divisor
            while dividend - (incrementalVal << 1) >= 0 {
                count += 1
                incrementalVal <<= 1
            }
            result += 1 << count
            dividend -= incrementalVal
        }
        
        return sign * result
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
 The complement of an integer is the integer you get when you flip all the 0's to 1's and all the 1's to 0's in its binary representation.

 For example, The integer 5 is "101" in binary and its complement is "010" which is the integer 2.
 Given an integer num, return its complement.
 
 Testcases:
 Input: num = 5
 Output: 2
 Explanation: The binary representation of 5 is 101 (no leading zero bits), and its complement is 010. So you need to output 2.
 
 Input: num = 1
 Output: 0
 Explanation: The binary representation of 1 is 1 (no leading zero bits), and its complement is 0. So you need to output 0.
 
 Constraints:
 1 <= num < 231
 
 link: https://leetcode.com/problems/number-complement/
 explanation: https://www.youtube.com/watch?v=oURSuMY4zSc
 primary idea:
 - Convert Bit by Bit and if it is 1 multiply it by its position power
 Time Complexity: O(n)
 Space Complexity: O(1)
 */
class NumberComplement {
    func callAsFunction(_ num: Int) -> Int {
        var result = 0, num = num
        var power = 1
        
        while num > 0 {
            result += ((num % 2) ^ 1) * power
            power <<= 1
            num >>= 1
        }
        
        return result
    }
}

/*
 problem:
 The Hamming distance between two integers is the number of positions at which the corresponding bits are different.

 Given two integers x and y, return the Hamming distance between them.
 
 Testcases:
 Input: x = 1, y = 4
 Output: 2
 Explanation:
 1   (0 0 0 1)
 4   (0 1 0 0)
        ↑   ↑
 The above arrows point to positions where the corresponding bits are different.
 
 Input: x = 3, y = 1
 Output: 1
 
 Constraints:
 0 <= x, y <= 231 - 1
 
 link: https://leetcode.com/problems/hamming-distance/
 explanation: https://www.youtube.com/watch?v=oGU1At1GFvc
 primary idea:
 - Iterate through each and every bit and check if it's different
 Time Complexity:
 Space Complexity:
 */
class HammingDistance {
    func callAsFunction(_ x: Int, _ y: Int) -> Int {
        var x = x, y = y, distance = 0
        while x > 0 || y > 0 {
            distance += (x % 2) ^ (y % 2)
            x >>= 1
            y >>= 1
        }
        return distance
    }
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
 - k >= 2. it means the input number should be broken. like 4 = 2+2. But 2 here need not necessarily be broken in to 1 + 1, so we stay with 2.
 - cache[num] = num == n ? 0 : num. This line denotes num should be compulsory broken for input and not necessaary for sub numbers.
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
 explanation: https://www.youtube.com/watch?v=IJ1u9iHXH8w, For why we are multiplying a by 5, watch at 4: 21 https://www.youtube.com/watch?v=nnmS7PEnvy8&t=302s
 primary idea:
 - zeros can be formed by multiples of 10 and 10 can even be divded in to 2 and 5.
 - In a factorial 2 occurs every alternate number and 5 occurs every fifth number. If we are able to find the count of 5, that is equal to count of trailing zeros
 - For example, for n = 25, 25!
 5 * 10 * 15 * 20 * 25
 (1 * 5) * (2 * 5) * (3 * 5) * (4 * 5) * (5 * 5)
 here n/a i.e 25/5 gives only 5, but we have 6.
 diving by 5 gives first set 5 count = 5
 diving by 25 gives second set 5 count = 1
 
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
 Write an algorithm to determine if a number n is happy.

 A happy number is a number defined by the following process:

 Starting with any positive integer, replace the number by the sum of the squares of its digits.
 Repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1.
 Those numbers for which this process ends in 1 are happy.
 Return true if n is a happy number, and false if not.
 
 Testcases:
 Input: n = 19
 Output: true
 Explanation:
 12 + 92 = 82
 82 + 22 = 68
 62 + 82 = 100
 12 + 02 + 02 = 1
 
 Input: n = 2
 Output: false
 
 Constraints:
 1 <= n <= 231 - 1
 
 link: https://leetcode.com/problems/happy-number/
 explanation: https://www.youtube.com/watch?v=ljz85bxOYJ0
 primary idea:
 - We should maintain a set to track if we are encountering a cycle or not. If we encounter a cycle we break and return false
 - In case of input n == 2, there is a cycle. in the process it encounter 37 again and again.
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

/*
 problem:
 Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.

 You must implement a solution with a linear runtime complexity and use only constant extra space.
 
 Testcases:
 Input: nums = [2,2,1]
 Output: 1
 
 Input: nums = [4,1,2,1,2]
 Output: 4
 
 Input: nums = [1]
 Output: 1
 
 Constraints:
 1 <= nums.length <= 3 * 104
 -3 * 104 <= nums[i] <= 3 * 104
 Each element in the array appears twice except for one element which appears only once.
 
 link: https://leetcode.com/problems/single-number/
 explanation: 
 primary idea:
 - SET: We can use set to store a value and if we encounter again we will remove that element. After loop set will remain with element which doesnot appeared twice
 - XOR: if we use a XOR operator for two same numbers, it results Zero. If we Xor with all elements in array, it remain with only number which appeared only once.
 Time Complexity:
 Space Complexity:
 */
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

/*
 problem:
 Given an integer n, return the number of prime numbers that are strictly less than n.
 
 Example 1:
 Input: n = 10
 Output: 4
 Explanation: There are 4 prime numbers less than 10, they are 2, 3, 5, 7.
 Example 2:

 Input: n = 0
 Output: 0
 Example 3:

 Input: n = 1
 Output: 0

 Constraints:
 0 <= n <= 5 * 106
 
 link: https://leetcode.com/problems/count-primes/
 explanation video: https://www.youtube.com/watch?v=5LMkddl2NCk&t=326s
 Notes:
 - Create a array of count n named compositeMap, which will let us know if the number is prime or composite. if the value is true then its composite and if the value if false then the index/number is prime.
 - We start iterating from 2 to Sqrt(n) where compositeMap[i] == false or in other words prime number and map every mutiple of i to false as it's concluded it's composite and divisible by i
 - Why Sqrt(n) as upper limit of iteration?
    * The first index that was needed to be changed to true would be starting fro i * i
    * The last prime for which the composite values needs to be calculated is sqrt(n)
 - Iterate again through the composite array and calculate count of prime numbers
 */
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
        var number = 0
        var sign = 0
        var foundFirstChar = false
        
        for c in s {
            if c == " " {
                if foundFirstChar { break }
                continue
            }
            
            if ["+", "-"].contains(c) {
                if sign != 0 { break }
                if foundFirstChar == false {
                    foundFirstChar = true
                }
                sign = c == "+" ? 1 : -1
                continue
            }
            
            if c >= "0" && c <= "9" {
                if foundFirstChar == false {
                    foundFirstChar = true
                }
                if sign == 0 {
                    sign = 1
                }
                
                number *= 10
                number += Int(c.asciiValue! - Character("0").asciiValue!)
                
                if (number * sign) >= Int32.max {
                   return Int(Int32.max)
                } else if (number * sign) <= Int32.min {
                   return Int(Int32.min)
                }
                
                continue
            }
            break
        }
        
        number *= sign
        number = min(Int(Int32.max), number)
        number = max(Int(Int32.min), number)
        return number
    }
}

/*
 problem:
 
 link:
 explanation video:
 Notes:
 Lets evaluate 2^10
 * 2 ^ 10 = 2^5 * 2^5
 * 2^5 = 2^2 * 2^2 * 2
 * 2^2 = 2 * 2
 * 2^1 = 2^0 * 2^0 * 2 == 1 * 1 * 2 = 2
 
 Base cases:
 * n^0 = n
 * 0^n = 0
 * 2^-n = 1/(2^n)
 
 */
class PowXN {
    func callAsFunction(_ x: Double, _ n: Int) -> Double {
        func helper(val: Double, exp: Int) -> Double {
            if val == 0 { return 0 }
            if exp == 0 { return 1 }
            
            var res = helper(val: val, exp: exp/2)
            res *= res
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

/*
 problem:
 Given two integers a and b, return the sum of the two integers without using the operators + and -.

 Testcases:
 Input: a = 1, b = 2
 Output: 3
 
 Input: a = 2, b = 3
 Output: 5
 
 Constraints:
 -1000 <= a, b <= 1000
 
 link: https://leetcode.com/problems/sum-of-two-integers/
 explanation: https://www.youtube.com/watch?v=gVUrDV4tZfY
 primary idea:
 - XOR operation gives result except for carry
 - We get carry 1 only if both bits are 1. so, we and it and left shift as carry moves to left.
 Time Complexity: Mostly O(1), because -1000 <= a, b <= 1000. If the values are even larger it would have been O(N)
 Space Complexity: O(1)
 */
class SumOfTwoIntegers {
    func callAsFunction(_ a: Int, _ b: Int) -> Int {
        var a = a, b = b
        while b != 0 {
            (a, b) = (a ^ b, (a & b) << 1)
        }
        return a
    }
}


/*
 problem:
 Given a signed 32-bit integer x, return x with its digits reversed. If reversing x causes the value to go outside the signed 32-bit integer range [-231, 231 - 1], then return 0.

 Assume the environment does not allow you to store 64-bit integers (signed or unsigned).
 
 Testcases:
 Input: x = 123
 Output: 321
 
 Input: x = -123
 Output: -321
 
 Input: x = 120
 Output: 21
 
 Input: x = 0
 Output: 0
 
 Constraints:
 -231 <= x <= 231 - 1
 
 link: https://leetcode.com/problems/reverse-integer/
 explanation: https://www.youtube.com/watch?v=HAgLH58IgJQ&t=693s
 primary idea:
 - We use % operator finding out last digit and / operator for left out number
 - (res * 10) + digit for proper reversing
 Time Complexity: O(N)
 Space Complexity: O(1)
 */
class ReverseInteger {
    func callAsFunction(_ x: Int) -> Int {
        let sign = x < 0 ? -1 : 1
        var x = x, res = 0
        let max = Int(Int32.max)
        let min = Int(Int32.min)
        
        while x > 0 {
            let digit = x % 10
            x = x / 10
            
            
            // https://www.youtube.com/watch?v=HAgLH58IgJQ&t=693s Time: 4:30 for understanding below condition
            if (res > max/10) || (res == max/10 && digit > max%10) {
                return 0
            } else if (res < min/10) || (res == min/10 && digit < min%10) {
                return 0
            }
            
            res = (res * 10) + digit
        }
        return res * sign
    }
}

class ExcelSheetColumnNumber {
    func callAsFunction(_ columnTitle: String) -> Int {
        var res = 0
        for char in columnTitle {
            res = (res * 26) + Int((char.asciiValue! - Character("A").asciiValue!) + 1)
        }
        return res
    }
}

/*
 problem:
 Given a roman numeral, convert it to an integer.

 
 Testcases:
 Input: s = "III"
 Output: 3
 
 Input: s = "IV"
 Output: 4
 
 Input: s = "IX"
 Output: 9
 
 Input: s = "LVIII"
 Output: 58
 Explanation: L = 50, V= 5, III = 3.
 
 Input: s = "MCMXCIV"
 Output: 1994
 Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.
 
 Constraints:
 1 <= s.length <= 15
 s contains only the characters ('I', 'V', 'X', 'L', 'C', 'D', 'M').
 It is guaranteed that s is a valid roman numeral in the range [1, 3999].
 
 link: https://leetcode.com/problems/roman-to-integer/
 explanation: https://www.youtube.com/watch?v=3jdxYj3DD98
 primary idea:
 - Check if the value that comess after current roman is greater or lower. If it lower the value should be minus from result (IV == 4). If it is greater the value shoyld be add to result.
 Time Complexity: O(n)
 Space Complexity: O(n), for romans variable
 */
class RomanToInteger {
    func callAsFunction(_ s: String) -> Int {
        var romans = Array(s).map{ String($0) }, res = 0
        let map = [
            "M": 1000,
            "D": 500,
            "C": 100,
            "L": 50,
            "X": 10,
            "V": 5,
            "I": 1
        ]
        
        for i in 0..<s.count {
            if i + 1 < s.count && map[romans[i]]! < map[romans[i + 1]]! {
                res -= map[romans[i]]!
            } else {
                res += map[romans[i]]!
            }
        }
        return res
    }
}

/*
 problem:
 Given an integer, convert it to a roman numeral.

 Testcases:
 Input: num = 3
 Output: "III"
 
 Input: num = 4
 Output: "IV"
 
 Input: num = 9
 Output: "IX"
 
 Input: num = 58
 Output: "LVIII"
 Explanation: L = 50, V = 5, III = 3.
 
 Input: num = 1994
 Output: "MCMXCIV"
 Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.
 
 Constraints:
 1 <= num <= 3999
 
 link: https://leetcode.com/problems/integer-to-roman/
 explanation: https://www.youtube.com/watch?v=ohBNdSJyLh8&t=33s
 primary idea:
 - count how many romans present higher order wise.
 Time Complexity: O(n)
 Space Complexity: O(1)
 */
class IntegerToRoman {
    func callAsFunction(_ num: Int) -> String {
        var num = num
        var result = ""
        
        let symList = [
            ["I", 1],
            ["IV", 4],
            ["V", 5],
            ["IX", 9],
            ["X", 10],
            ["XL", 40],
            ["L", 50],
            ["XC", 90],
            ["C", 100],
            ["CD", 400],
            ["D", 500],
            ["CM", 900],
            ["M", 1000]
        ]
        
        for item in symList.reversed() {
            let val = item[1] as! Int
            let sym = item[0] as! String
            let count = num/val
            if count > 0 {
                for _ in 0..<count {
                    result += sym
                }
                num = num % val
            }
        }
        
        return result
    }
}


/*
 problem:
 Convert a non-negative integer num to its English words representation.
 
 Testcases:
 Input: num = 123
 Output: "One Hundred Twenty Three"
 
 Input: num = 12345
 Output: "Twelve Thousand Three Hundred Forty Five"
 
 Input: num = 1234567
 Output: "One Million Two Hundred Thirty Four Thousand Five Hundred Sixty Seven"
 
 Input: num = 1234567891
 Output: "One Billion Two Hundred Thirty Four Million Five Hundred Sixty Seven Thousand Eight Hundred Ninety One"
 
 Constraints:
 0 <= num <= 231 - 1
 
 link: https://leetcode.com/problems/integer-to-english-words/
 explanation:
 primary idea:
 - One Trillion has 12 zeros, One Billion has 9 zeros, One Million has 6 zeros, One Thousand has 3 zeros
 - if a large number divided by 1 trillion, it gives number of trillion and if it mod by 1000 gives 3 digit trillion number. Same with Billion, Million as well.
 - For more clarity, debug last test case.
 Time Complexity:
 Space Complexity:
 */
class IntegerToEnglish {
    
    let numOnes = [
        1: "One",
        2: "Two",
        3: "Three",
        4: "Four",
        5: "Five",
        6: "Six",
        7: "Seven",
        8: "Eight",
        9: "Nine",
        10: "Ten"
    ]
    
    let numsTeens = [
        1: "Eleven",
        2: "Twelve",
        3: "Thirteen",
        4: "Fourteen",
        5: "Fifteen",
        6: "Sixteen",
        7: "Seventeen",
        8: "Eighteen",
        9: "Nineteen"
    ]
    
    let numsTens = [
        2: "Twenty",
        3: "Thirty",
        4: "Forty",
        5: "Fifty",
        6: "Sixty",
        7: "Seventy",
        8: "Eighty",
        9: "Ninety"
    ]
    
    func numberToWords(_ num: Int) -> String {
        if num == 0 {
            return "Zero"
        }
        
        var result = ""
        if num >= 1000000000000 {
            result += convertChunk(num: (num/1000000000000) % 1000, suffix: "Trillion")
        }
        if num >= 1000000000 {
            result += convertChunk(num: (num/1000000000) % 1000, suffix: "Billion")
        }
        if num >= 1000000 {
            result += convertChunk(num: (num/1000000) % 1000, suffix: "Million")
        }
        if num >= 1000 {
            result += convertChunk(num: (num/1000) % 1000, suffix: "Thousand")
        }
        result += convertChunk(num: num % 1000, suffix: "")
        while result.hasSuffix(" ") {
            result.removeLast()
        }
        return result
    }
    
    func convertChunk(num: Int, suffix: String) -> String {
        var number = num
        var result = ""
        if number >= 100 {
            result += numOnes[number/100]! + " Hundred "
        }
        number = number % 100
        if number >= 20 {
            result += numsTens[number/10]! + " "
            number = number % 10
            if number > 0 {
                result += numOnes[number]! + " "
            }
        } else if number > 10 {
            number = number % 10
            result += numsTeens[number]! + " "
        } else if number > 0 {
            result += numOnes[number]! + " "
        }
        
        if !suffix.isEmpty && result.count > 0 {
            result += suffix + " "
        }
        return result
    }
}

/*
 problem:
 Given two integers representing the numerator and denominator of a fraction, return the fraction in string format.

 If the fractional part is repeating, enclose the repeating part in parentheses.

 If multiple answers are possible, return any of them.

 It is guaranteed that the length of the answer string is less than 104 for all the given inputs.

 Example 1:
 
 Input: numerator = 1, denominator = 2
 Output: "0.5"
 Example 2:

 Input: numerator = 2, denominator = 1
 Output: "2"
 Example 3:

 Input: numerator = 4, denominator = 333
 Output: "0.(012)"
  

 Constraints:

 -231 <= numerator, denominator <= 231 - 1
 denominator != 0
 
 link: https://leetcode.com/problems/fraction-to-recurring-decimal/
 explanation video: No video
 Notes:
 - if numerator or denominator is < 0, append - sign to result at first position
 - we use map here to check if there is any number repetition in decimals, the value of that map will be index where repition started so that we can append ( at that index and follwed by appending ) to result.
 - After Dot(.), that value will be 10's place , 100's place, 1000's place...
 */
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

class RectangleArea {
    func computeArea(_ ax1: Int, _ ay1: Int, _ ax2: Int, _ ay2: Int, _ bx1: Int, _ by1: Int, _ bx2: Int, _ by2: Int) -> Int {
        let ox1 = max(ax1, bx1)
        let ox2 = min(ax2, bx2)
        let oy1 = max(ay1, by1)
        let oy2 = min(ay2, by2)

        return area(ax1, ay1, ax2, ay2) + area(bx1, by1, bx2, by2) - area(ox1, oy1, ox2, oy2)
    }

    private func area(_ x1: Int, _ y1: Int, _ x2: Int, _ y2: Int) -> Int {
        let width = x2 - x1
        let height = y2 - y1

        guard width > 0 else { return 0 }
        guard height > 0 else { return 0 }
        return width * height
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

/*
 problem:
 A city's skyline is the outer contour of the silhouette formed by all the buildings in that city when viewed from a distance. Given the locations and heights of all the buildings, return the skyline formed by these buildings collectively.

 The geometric information of each building is given in the array buildings where buildings[i] = [lefti, righti, heighti]:

 lefti is the x coordinate of the left edge of the ith building.
 righti is the x coordinate of the right edge of the ith building.
 heighti is the height of the ith building.
 You may assume all buildings are perfect rectangles grounded on an absolutely flat surface at height 0.

 The skyline should be represented as a list of "key points" sorted by their x-coordinate in the form [[x1,y1],[x2,y2],...]. Each key point is the left endpoint of some horizontal segment in the skyline except the last point in the list, which always has a y-coordinate 0 and is used to mark the skyline's termination where the rightmost building ends. Any ground between the leftmost and rightmost buildings should be part of the skyline's contour.

 Note: There must be no consecutive horizontal lines of equal height in the output skyline. For instance, [...,[2 3],[4 5],[7 5],[11 5],[12 7],...] is not acceptable; the three lines of height 5 should be merged into one in the final output as such: [...,[2 3],[4 5],[12 7],...]
 
 Testcases:
 Input: buildings = [[2,9,10],[3,7,15],[5,12,12],[15,20,10],[19,24,8]]
 Output: [[2,10],[3,15],[7,12],[12,0],[15,10],[20,8],[24,0]]
 Explanation:
 Figure A shows the buildings of the input.
 Figure B shows the skyline formed by those buildings. The red points in figure B represent the key points in the output list.
 
 Input: buildings = [[0,2,3],[2,5,3]]
 Output: [[0,3],[5,0]]
 
 
 Constraints:
 1 <= buildings.length <= 104
 0 <= lefti < righti <= 231 - 1
 1 <= heighti <= 231 - 1
 buildings is sorted by lefti in non-decreasing order.
 
 
 link: https://leetcode.com/problems/the-skyline-problem/
 explanation:
 primary idea:
 - Divide and Conquer with merge sort
 - For a single building skylines will be [x, height], [y, 0]
 - While merging skylines, we should maintain leftHeight, rightHeight and maxHeight at everystep
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class SkylineProblem {
    func getSkyline(_ buildings: [[Int]]) -> [[Int]] {
        getSkyline(buildings, left: 0, right: buildings.count - 1)
    }
    
    func getSkyline(_ buildings: [[Int]], left: Int, right: Int) -> [[Int]] {
        if left == right {
            return [[buildings[left][0], buildings[left][2]], [buildings[left][1], 0]]
        }
        
        let mid = left + (right - left)/2
        let leftSkylines = getSkyline(buildings, left: left, right: mid)
        let rightSkylines = getSkyline(buildings, left: mid+1, right: right)
        return mergeSkylines(left: leftSkylines, right: rightSkylines)
    }
    
    func mergeSkylines(left: [[Int]], right: [[Int]]) -> [[Int]] {
        var i = 0, j = 0
        var leftHeight = 0, rightHeight = 0, maxHeight = 0
        var results = [[Int]]()
        
        while i < left.count || j < right.count {
            if (i < left.count && j < right.count && left[i][0] < right[j][0]) || (i < left.count && j == right.count) {
                leftHeight = left[i][1]
                let newMaxHeight = max(leftHeight, rightHeight)
                if maxHeight != newMaxHeight {
                    maxHeight = newMaxHeight
                    results.append([left[i][0], maxHeight])
                }
                i += 1
            } else if (i < left.count && j < right.count && left[i][0] > right[j][0]) || (j < right.count && i == left.count) {
                rightHeight = right[j][1]
                let newMaxHeight = max(leftHeight, rightHeight)
                if maxHeight != newMaxHeight {
                    maxHeight = newMaxHeight
                    results.append([right[j][0], maxHeight])
                }
                j += 1
            } else if i < left.count && j < right.count && left[i][0] == right[j][0] {
                leftHeight = left[i][1]
                rightHeight = right[j][1]
                let newMaxHeight = max(leftHeight, rightHeight)
                if maxHeight != newMaxHeight {
                    maxHeight = newMaxHeight
                    results.append([left[i][0], maxHeight])
                }
                i += 1
                j += 1
            }
        }
        return results
    }
}
class BasicCalculatorII {
    func calculate(_ s: String) -> Int {
        var stack = [Int]()
        var current = 0
        var op = "+"
        
        for ch in s+"+" {
            switch ch {
                case "+", "-", "*", "/":
                    if op == "+" || op == "-" {
                        stack.append(op == "+" ? current : -current)
                    } else if op == "*" {
                        assert(stack.count > 0)
                        stack[stack.count-1] = stack.last! * current
                    } else if op == "/" {
                        assert(stack.count > 0)
                        stack[stack.count-1] = stack.last! / current
                    }
                    current = 0
                    op = String(ch)
                default:
                    if let n = Int(String(ch)) { current = current*10 + n }
            }
        }
//
//        if op == "+" || op == "-" {
//            stack.append(op == "+" ? current : -current)
//        } else if op == "*" {
//            assert(stack.count > 0)
//            stack[stack.count-1] = stack.last! * current
//        } else if op == "/" {
//            assert(stack.count > 0)
//            stack[stack.count-1] = stack.last! / current
//        }
        
        return stack.reduce(0, +)
    }
}
