//
//  RecursionLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 02/03/22.
//

import Foundation

/*
 problem:
 We build a table of n rows (1-indexed). We start by writing 0 in the 1st row. Now in every subsequent row, we look at the previous row and replace each occurrence of 0 with 01, and each occurrence of 1 with 10.

 For example, for n = 3, the 1st row is 0, the 2nd row is 01, and the 3rd row is 0110.
 Given two integer n and k, return the kth (1-indexed) symbol in the nth row of a table of n rows.
 
 Testcases:
 
 Example 1:
 Input: n = 1, k = 1
 Output: 0
 Explanation: row 1: 0
 
 Example 2:
 Input: n = 2, k = 1
 Output: 0
 Explanation:
 row 1: 0
 row 2: 01
 
 Example 3:
 Input: n = 2, k = 2
 Output: 1
 Explanation:
 row 1: 0
 row 2: 01
 
 
 Constraints:
 1 <= n <= 30
 1 <= k <= 2n - 1
 
 
 link: https://leetcode.com/problems/k-th-symbol-in-grammar/
 explanation: https://www.youtube.com/watch?v=QRa9ZVGMWlY
 primary idea:
 - Better watch video
 Time Complexity: O(2n)
 Space Complexity: O(n)
 */
class KthSymbolOfGrammer {
    func recursion(_ n: Int, _ k: Int) -> Int {
        if n == 1 {
            return 0
        }
        let parent = recursion(n - 1, Int(ceil(Double(k)/2)))
        let isKOdd = (k % 2 == 1)
        if parent == 1 {
            return isKOdd ? 1 : 0
        } else {
            return isKOdd ? 0 : 1
        }
    }
}
