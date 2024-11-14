//
//  SlidingWindowLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 22/02/22.
//

import Foundation
/*
 https://leetcode.com/discuss/interview-question/3722472/mastering-sliding-window-technique-a-comprehensive-guide
 */

/*
 problem:
 Given two strings s and t of lengths m and n respectively, return the minimum window substring of s such that every character in t (including duplicates) is included in the window. If there is no such substring, return the empty string "".

 The testcases will be generated such that the answer is unique.

 A substring is a contiguous sequence of characters within the string.
 
 Testcases:
 Input: s = "ADOBECODEBANC", t = "ABC"
 Output: "BANC"
 Explanation: The minimum window substring "BANC" includes 'A', 'B', and 'C' from string t.
 
 Input: s = "a", t = "a"
 Output: "a"
 Explanation: The entire string s is the minimum window.
 
 Input: s = "a", t = "aa"
 Output: ""
 Explanation: Both 'a's from t must be included in the window.
 Since the largest window of s only has one 'a', return empty string.
 
 Constraints:
 m == s.length
 n == t.length
 1 <= m, n <= 105
 s and t consist of uppercase and lowercase English letters.
 
 
 link: https://leetcode.com/problems/minimum-window-substring/
 explanation: https://www.youtube.com/watch?v=jSto0O4AJbM
 primary idea:
 - WindowMap to keep track of all characters count in window and countT to keep track of what is needed
 - As soon as a character's count in windowMap matches count of that character in countT, we increase `have` variable by 1
 - As we traverse the s String and pick a character,
    - we update character's count in windowMap
    - if that character is present in countT and windowMap[char] count equals countT[char], then we increase `have` variable by 1
    - use a while loop with condition `have` == `need`, if we found new min length we update windowPair and minLength, increase l by l and remove that char from current window
 - (r - l + 1) gives length of window
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class MinWindowSubstring {
    func minWindow(_ s: String, _ t: String) -> String {
        let s = Array(s)
        if t == "" || t.count > s.count {
            return ""
        }
        
        var countT = [Character: Int]()
        for char in t {
            countT[char, default: 0] += 1
        }
        
        var windowMap = [Character: Int]()
        
        var l = 0
        var windowPair = (start: 0, end: 0)
        var minLength = Int.max, have = 0, need = countT.count
        
        for r in 0..<s.count {
            let char = s[r]
            windowMap[char, default: 0] += 1
            
            if countT[char] != nil && windowMap[char] == countT[char] {
                have += 1
            }
            
            while have == need {
                
                let currentWindowLength = (r - l + 1)
                if currentWindowLength < minLength {
                    minLength = currentWindowLength
                    windowPair = (l, r)
                }
                
                let removableChar = s[l]
                windowMap[removableChar]! -= 1
                if countT[removableChar] != nil && windowMap[removableChar]! < countT[removableChar]! {
                    have -= 1
                }
                l += 1
            }
        }
        
        return minLength == Int.max ? "" : String(s[windowPair.start..<windowPair.end+1])
    }
}

/*
 problem:
 You are given a string s and an integer k. You can choose any character of the string and change it to any other uppercase English character. You can perform this operation at most k times.

 Return the length of the longest substring containing the same letter you can get after performing the above operations.
 
 Testcases:
 Input: s = "ABAB", k = 2
 Output: 4
 Explanation: Replace the two 'A's with two 'B's or vice versa.
 
 Input: s = "AABABBA", k = 1
 Output: 4
 Explanation: Replace the one 'A' in the middle with 'B' and form "AABBBBA".
 The substring "BBBB" has the longest repeating letters, which is 4.
 
 
 Constraints:
 1 <= s.length <= 105
 s consists of only uppercase English letters.
 0 <= k <= s.length
 
 
 link: https://leetcode.com/problems/longest-repeating-character-replacement/
 explanation: https://www.youtube.com/watch?v=gqXU1UyA8pk&list=PLot-Xpze53leOBgcVsJBEGrHPd_7x_koV&index=4
 primary idea:
 - Sliding window
 - we use countMap to keep track of the all characters and its frequency of current window
 - if currentWindowLength - numberOfMostFrequencyOfACharacter is <= k, then it is a valid condition to consider it window length for result
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class LongestRepeatingCharacterReplacement {
    func callAsFunction(_ s: String, _ k: Int) -> Int {
        let s = Array(s)
        
        var countMap = [Character: Int]()
        
        func getNumberOfMostOccurences() -> Int {
            var res = 0
            for (_, value) in countMap {
                res = max(res, value)
            }
            return res
        }
        
        var l = 0
        var maxWindowLength = 0
        
        for r in 0..<s.count {
            let char = s[r]
            countMap[char, default: 0] += 1
            
            while (r - l + 1) - getNumberOfMostOccurences() > k {
                let removableChar = s[l]
                countMap[removableChar]! -= 1
                l += 1
            }
            
            maxWindowLength = max(maxWindowLength, r - l + 1)
        }
        return maxWindowLength
    }
}

/*
 problem:
 Given two strings s and p, return an array of all the start indices of p's anagrams in s. You may return the answer in any order.

 An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.
 
 Testcases:
 Example 1:

 Input: s = "cbaebabacd", p = "abc"
 Output: [0,6]
 Explanation:
 The substring with start index = 0 is "cba", which is an anagram of "abc".
 The substring with start index = 6 is "bac", which is an anagram of "abc".
 Example 2:

 Input: s = "abab", p = "ab"
 Output: [0,1,2]
 Explanation:
 The substring with start index = 0 is "ab", which is an anagram of "ab".
 The substring with start index = 1 is "ba", which is an anagram of "ab".
 The substring with start index = 2 is "ab", which is an anagram of "ab".
 
 Constraints:
 1 <= s.length, p.length <= 3 * 104
 s and p consist of lowercase English letters.
 
 
 link: https://leetcode.com/problems/find-all-anagrams-in-a-string/
 explanation: https://www.youtube.com/watch?v=G8xtZy0fDKg&list=PLot-Xpze53leOBgcVsJBEGrHPd_7x_koV&index=6
 primary idea:
 - First check if characters of p till p.count equals s, if yes, append 0
 - interate from p.count to s.count
 - Sliding window, as we add one char to right, we will remove one char from left
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class FindAllAnagramsInString {
    func callAsFunction(_ s: String, _ p: String) -> [Int] {
        if p.count > s.count {
            return []
        }
        let s = Array(s), p = Array(p)
        
        var countP = [Character: Int]()
        var windowMap = [Character: Int]()
        for i in 0..<p.count {
            countP[p[i], default: 0] += 1
            windowMap[s[i], default: 0] += 1
        }
        
        var res = [Int]()
        if windowMap == countP {
            res.append(0)
        }
        
        var l = 0
        for r in p.count..<s.count {
            windowMap[s[r], default: 0] += 1
            windowMap[s[l], default: 0] -= 1
            
            if let removedCharcount = windowMap[s[l]], removedCharcount == 0 {
                windowMap.removeValue(forKey: s[l])
            }
            l += 1
            if windowMap == countP {
                res.append(l)
            }

        }
        return res
    }
    
    //self wrote solution, align with above problem thinking
    func solution2(_ s: String, _ p: String) -> [Int] {
        guard p.count <= s.count else {
            return []
        }
        
        var s = Array(s), p = Array(p)
        var result = [Int]()
        
        var pMap = [Character: Int]()
        for char in p {
            pMap[char, default: 0] += 1
        }
        
        var sMap = [Character: Int]()
        
        var l = 0
        let windowLength = p.count
        
        for r in 0..<s.count {
            let char = s[r]
            sMap[char, default: 0] += 1
            
            if sMap == pMap {
                result.append(l)
            }
            
            if (r - l + 1) == windowLength {
                let removableChar = s[l]
                sMap[removableChar]! -= 1
                if let count = sMap[removableChar], count == 0 {
                    sMap[removableChar] = nil
                }
                l += 1
            }
        }
        
        return result
    }
}

/*
 problem:
 Given a string s, find the length of the longest substring without repeating characters.
 
 Testcases:
 Example 1:

 Input: s = "abcabcbb"
 Output: 3
 Explanation: The answer is "abc", with the length of 3.
 Example 2:

 Input: s = "bbbbb"
 Output: 1
 Explanation: The answer is "b", with the length of 1.
 Example 3:

 Input: s = "pwwkew"
 Output: 3
 Explanation: The answer is "wke", with the length of 3.
 Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.
 
 
 Constraints:
 0 <= s.length <= 5 * 104
 s consists of English letters, digits, symbols and spaces.
 
 
 link: https://leetcode.com/problems/longest-substring-without-repeating-characters/
 explanation:
 primary idea:
 - if s is empty or has count of only one, return same
 - check for existing index of a character, if found `left` will be at existingindex + 1
 Time Complexity: O(n)
 Space Complexity: O(n)
 */
class LengthOfLongestSubstringWithOutRepeatingChar {
    func callAsFunction(_ s: String) -> Int {
        let s = Array(s)
        var existingCharMap = [Character: Int](), maxLength = 0
        var start = 0
        for end in 0..<s.count {
            let currentChar = s[end]
            if let existingIndex = existingCharMap[currentChar] {
                start = max(existingIndex, start)
            }
            let currentWindowLength = end - start + 1
            maxLength = max(maxLength, currentWindowLength)
            existingCharMap[currentChar] = end + 1
        }
        return maxLength
    }
}

/*
 problem:
 You are given an array of integers nums, there is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position.

 Return the max sliding window.
 
 Testcases:
 Example 1:

 Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
 Output: [3,3,5,5,6,7]
 Explanation:
 Window position                Max
 ---------------               -----
 [1  3  -1] -3  5  3  6  7       3
  1 [3  -1  -3] 5  3  6  7       3
  1  3 [-1  -3  5] 3  6  7       5
  1  3  -1 [-3  5  3] 6  7       5
  1  3  -1  -3 [5  3  6] 7       6
  1  3  -1  -3  5 [3  6  7]      7
 Example 2:

 Input: nums = [1], k = 1
 Output: [1]
 
 
 Constraints:
 1 <= nums.length <= 105
 -104 <= nums[i] <= 104
 1 <= k <= nums.length
 
 
 link: https://leetcode.com/problems/sliding-window-maximum/
 explanation:
 primary idea:
 - check if nums.count or k is zero, return []
 - check if k is 1, then return nums
 - We use a monotonic queue to keep track of ids with max value. if we found max id is left most removable from window, we just pop it as it is invalid for current window
 - Append result with max value
 Time Complexity: O(n)
 Space Complexity: O(n)
 */
class MaxSlidingWindow {
    func callAsFunction(_ nums: [Int], _ k: Int) -> [Int] {
        var maxIds = [Int](), result = [Int]()
        var start = 0
        for end in 0..<nums.count {
            let currentNum = nums[end]

            while let last = maxIds.last, nums[last] <= currentNum {
                _ = maxIds.popLast()
            }
            maxIds.append(end)

            var currentWindowLength: Int { end - start + 1 }
            if currentWindowLength >  k {
                let removableNum = nums[start]
                if maxIds.first == start {
                    maxIds.removeFirst()
                }
                start += 1
            }

            if currentWindowLength == k {
                result.append(nums[maxIds.first!])
            }
        }
        return result
    }
}

/*
 problem:
 ❤️ - Premium problem [Not tested]
 Given a string, find the length of the longest substring T that contains at most 2 distinct characters.
 
 Testcases:
 
 Example 1
 Input: “eceba”
 Output: 3
 Explanation:
 T is "ece" which its length is 3.
 
 Example 2
 Input: “aaa”
 Output: 3
 
 
 Constraints:
 
 
 link: https://www.lintcode.com/problem/928/
 explanation:
 primary idea:
 - Same as Minimum window substring problem.
 - for every character we pick, we append it in hashmap and increase `l` if condition is invalid
 - update maxLength
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class LongestSubstringWithAtmost2DistinctChar {
    func callAsFunction(s: String) -> Int {
        let s = Array(s)
        let k = 2
        
        var l = 0, windowMap = [Character: Int]()
        var res = 0
        for r in 0..<s.count {
            let char = s[r]
            windowMap[char, default: 0] += 1
            
            while windowMap.count > k {
                let removableChar = s[l]
                windowMap[removableChar]! -= 1
                if windowMap[removableChar] == 0 {
                    windowMap.removeValue(forKey: removableChar)
                }
                l += 1
            }
            
            res = max(res, r - l + 1)
        }
        return res
    }
}

/*
 problem:
 ❤️ - Premium problem [Not tested]
 Given a string, find the length of the longest substring T that contains at most k distinct characters.
 
 Testcases:
 
 Example 1
 Input: “eceba”
 Output: 3
 Explanation:
 T is "ece" which its length is 3.
 
 Example 2
 Input: “aaa”
 Output: 3
 
 
 Constraints:
 
 
 link: https://www.lintcode.com/problem/386/
 explanation:
 primary idea:
 - Same as Minimum window substring problem.
 - for every character we pick, we append it in hashmap and increase `l` if condition is invalid
 - update maxLength
 Time Complexity: O(n)
 Space Complexity: O(n)
 */
class LongestSubstringWithAtmostKDistinctChar {
    func callAsFunction(s: String, k: Int) -> Int {
        let s = Array(s)
        
        var l = 0, windowMap = [Character: Int]()
        var res = 0
        for r in 0..<s.count {
            let char = s[r]
            windowMap[char, default: 0] += 1
            
            while windowMap.count > k {
                let removableChar = s[l]
                windowMap[removableChar]! -= 1
                if windowMap[removableChar] == 0 {
                    windowMap.removeValue(forKey: removableChar)
                }
                l += 1
            }
            
            res = max(res, r - l + 1)
        }
        return res
    }
}


/*
 problem:
 The frequency of an element is the number of times it occurs in an array.

 You are given an integer array nums and an integer k. In one operation, you can choose an index of nums and increment the element at that index by 1.

 Return the maximum possible frequency of an element after performing at most k operations.
 
 Testcases:
 
 Example 1:
 Input: nums = [1,2,4], k = 5
 Output: 3
 Explanation: Increment the first element three times and the second element two times to make nums = [4,4,4].
 4 has a frequency of 3.
 
 Example 2:
 Input: nums = [1,4,8,13], k = 5
 Output: 2
 Explanation: There are multiple optimal solutions:
 - Increment the first element three times to make nums = [4,4,8,13]. 4 has a frequency of 2.
 - Increment the second element four times to make nums = [1,8,8,13]. 8 has a frequency of 2.
 - Increment the third element five times to make nums = [1,4,13,13]. 13 has a frequency of 2.
 
 Example 3:
 Input: nums = [3,9,6], k = 2
 Output: 1
 
 
 Constraints:
 1 <= heights.length <= 105
 0 <= heights[i] <= 104
 
 
 link: https://leetcode.com/problems/frequency-of-the-most-frequent-element/
 explanation: https://www.youtube.com/watch?v=vgBrQ0NM5vE&list=PLot-Xpze53leOBgcVsJBEGrHPd_7x_koV&index=8
 primary idea:
 - Sort and sliding window
 - We need to sort arr, so that the number which comes after current iteration are always larger and we dont need to care about it. Our opeation is to add and not to decrease. We can add only to elements which are less than current one and we can find them left to it.
 - Condition: while nums[r] * currentWindowLength <= windowSum + k, which need to be true.
 Time Complexity: O(nlogn), mainly due to sorting of array
 Space Complexity: O(n)
 */
class FrequencyOfTheMostFrequentElement {
    func callAsFunction(_ nums: [Int], _ k: Int) -> Int {
        let nums = nums.sorted()
        var l = 0, windowSum = 0
        var maxLength = 0
        for r in 0..<nums.count {
            var currentWindowLength = r - l + 1
            windowSum += nums[r]
            while nums[r] * currentWindowLength > windowSum + k {
                let removableNum = nums[l]
                windowSum -= removableNum
                l += 1
                currentWindowLength = r - l + 1
            }
            maxLength = max(maxLength, currentWindowLength)
        }
        return maxLength
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
class PermutationInString {
    func callAsFunction(_ s1: String, _ s2: String) -> Bool {
        let s2 = Array(s2)
        var s1Map = [Character: Int]()
        for char in s1 {
            s1Map[char, default: 0] += 1
        }
        let windowLength = s1.count
        var s2Map = [Character: Int]()
        
        var l = 0
        for r in 0..<s2.count {
            let char = s2[r]
            s2Map[char, default: 0] += 1
            
            let currentWindowLength = (r - l + 1)
            if currentWindowLength > windowLength {
                let removableChar = s2[l]
                s2Map[removableChar]! -= 1
                if s2Map[removableChar] == 0 {
                    s2Map.removeValue(forKey: removableChar)
                }
                l += 1
            }
            
            if s2Map == s1Map {
                return true
            }
        }
        return false
    }
}

class MInSizeSubarraySum {
    func callAsFunction(_ target: Int, _ nums: [Int]) -> Int {
        var l = 0, sum = 0, res = Int.max
        for r in 0..<nums.count {
            sum += nums[r]
            
            while sum >= target {
                res = min(res, r - l + 1)
                let removableNum = nums[l]
                sum -= removableNum
                l += 1
            }
        }
        return res == Int.max ? 0 : res
    }
}


/*
 problem:
 You are given a binary string s. You are allowed to perform two types of operations on the string in any sequence:

 Type-1: Remove the character at the start of the string s and append it to the end of the string.
 Type-2: Pick any character in s and flip its value, i.e., if its value is '0' it becomes '1' and vice-versa.
 Return the minimum number of type-2 operations you need to perform such that s becomes alternating.

 The string is called alternating if no two adjacent characters are equal.

 For example, the strings "010" and "1010" are alternating, while the string "0100" is not.
 
 Testcases:
 Example 1:

 Input: s = "111000"
 Output: 2
 Explanation: Use the first operation two times to make s = "100011".
 Then, use the second operation on the third and sixth elements to make s = "101010".
 Example 2:

 Input: s = "010"
 Output: 0
 Explanation: The string is already alternating.
 Example 3:

 Input: s = "1110"
 Output: 1
 Explanation: Use the second operation on the second element to make s = "1010".
 
 
 Constraints:
 1 <= s.length <= 105
 s[i] is either '0' or '1'.
 
 
 link: https://leetcode.com/problems/minimum-number-of-flips-to-make-the-binary-string-alternating/
 explanation: https://www.youtube.com/watch?v=MOeuK6gaC2A
 primary idea:
 - alt1 = 010101010, alt2 = 10101010
 - checking the characters different for s and above alt1 and alt2, we get type2 flips respectively
 - For Type1 operations, as we have have to move prefix to suffix. it's better to S = s+s and use a sliding window
 - so we make s = s+s, alt1 = alt1 + alt1, alt2 = alt2 + alt2 and use sliding window
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class MinFlipsToMakeBinaryStringAlternating {
    func callAsFunction(_ s: String) -> Int {
        let n = s.count
        let s = Array(s + s).map{String($0)}
        var alt1 = [String](), alt2 = [String]()
        for i in 0..<s.count {
            alt1.append(i % 2 == 0 ? "0" : "1")
            alt2.append(i % 2 == 0 ? "1" : "0")
        }
        
        var diff1 = 0, diff2 = 0
        
        var l = 0, res = s.count
        for r in 0..<s.count {
            if s[r] != alt1[r] {
                diff1 += 1
            }
            if s[r] != alt2[r] {
                diff2 += 1
            }
            
            if (r - l + 1) > n {
                if s[l] != alt1[l] {
                    diff1 -= 1
                }
                if s[l] != alt2[l] {
                    diff2 -= 1
                }
                
                l += 1
            }
            
            if (r - l + 1) == n {
                res = min(res, diff1, diff2)
            }
        }
        return res
    }
}

/*
 problem:
 You are given an array prices where prices[i] is the price of a given stock on the ith day.

 You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.

 Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.
 
 Testcases:
 Input: prices = [7,1,5,3,6,4]
 Output: 5
 Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
 Note that buying on day 2 and selling on day 1 is not allowed because you must buy before you sell.
 
 Input: prices = [7,6,4,3,1]
 Output: 0
 Explanation: In this case, no transactions are done and the max profit = 0.
 
 Constraints:
 1 <= prices.length <= 105
 0 <= prices[i] <= 104
 
 link: https://leetcode.com/problems/best-time-to-buy-and-sell-stock/
 explanation: https://www.youtube.com/watch?v=EgI5nU9etnU
 primary idea:
 - Non DP, self explanatory
 Time Complexity: O(n)
 Space Complexity: O(1)
 */
class BestTimeToBuyAndSellStock {
    func maxProfit(_ prices: [Int]) -> Int {
        var buy = 0, profit = 0
        for sell in 1..<prices.count {
            if prices[sell] < prices[buy] {
                buy = sell
            }
            let currentProfit = prices[sell] - prices[buy]
            if profit < currentProfit {
                profit = currentProfit
            }
        }
        return profit
    }
}

/*
 problem:
 The DNA sequence is composed of a series of nucleotides abbreviated as 'A', 'C', 'G', and 'T'.

 For example, "ACGAATTCCG" is a DNA sequence.
 When studying DNA, it is useful to identify repeated sequences within the DNA.

 Given a string s that represents a DNA sequence, return all the 10-letter-long sequences (substrings) that occur more than once in a DNA molecule. You may return the answer in any order.
 
 Testcases:
 Input: s = "AAAAACCCCCAAAAACCCCCCAAAAAGGGTTT"
 Output: ["AAAAACCCCC","CCCCCAAAAA"]

 Input: s = "AAAAAAAAAAAAA"
 Output: ["AAAAAAAAAA"]
 
 Constraints:
 1 <= s.length <= 105
 s[i] is either 'A', 'C', 'G', or 'T'.
 
 link: https://leetcode.com/problems/repeated-dna-sequences/
 explanation: https://www.youtube.com/watch?v=FzTYfsmtOso
 primary idea:
 - Initial check is to check if s itself is > 10 or not
 - use seen set to keep track of already seen DNA's
 - if we encounter a DNA which is seen then we append it to our result and there are cance of multiple occurences of same DNA we use set for res
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class RepeatedDNASequences {
    func callAsFunction(_ s: String) -> [String] {
        let s = Array(s)
        if s.count < 10 {
            return []
        }
        var seen = Set<String>(), res = Set<String>()
        for index in 0..<s.count - 9 {
            let dna = String(s[index..<index+10])
            if seen.contains(dna) {
                res.insert(String(dna))
            }
            seen.insert(dna)
        }
        return Array(res)
    }
}

/*
 1876. Substrings of Size Three with Distinct Characters
 A string is good if there are no repeated characters.

 Given a string s​​​​​, return the number of good substrings of length three in s​​​​​​.

 Note that if there are multiple occurrences of the same substring, every occurrence should be counted.

 A substring is a contiguous sequence of characters in a string.

  

 Example 1:

 Input: s = "xyzzaz"
 Output: 1
 Explanation: There are 4 substrings of size 3: "xyz", "yzz", "zza", and "zaz".
 The only good substring of length 3 is "xyz".
 Example 2:

 Input: s = "aababcabc"
 Output: 4
 Explanation: There are 7 substrings of size 3: "aab", "aba", "bab", "abc", "bca", "cab", and "abc".
 The good substrings are "abc", "bca", "cab", and "abc".
  

 Constraints:

 1 <= s.length <= 100
 s​​​​​​ consists of lowercase English letters.
 
 link:https://leetcode.com/problems/substrings-of-size-three-with-distinct-characters/description/
 explanation:
 primary idea:
 - Classic sliding window problem
 */
class CountGoodSubstrings {
    func callAsFunction(_ s: String) -> Int {
        let s = Array(s)
        let windowLength = 3
        var start = 0, windowSet = Set<Character>()
        var result = 0

        for end in 0..<s.count {
            let char = s[end]
            while windowSet.contains(char){
                let removableChar = s[start]
                windowSet.remove(removableChar)
                start += 1
            }
            if (end - start + 1) > windowLength {
                let removableChar = s[start]
                windowSet.remove(removableChar)
                start += 1
            }
            windowSet.insert(char)
            if (end - start + 1) == windowLength {
                result += 1
            }
        }
        return result
    }
}
