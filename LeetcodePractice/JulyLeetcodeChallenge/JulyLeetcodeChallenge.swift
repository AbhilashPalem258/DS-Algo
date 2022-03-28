//
//  JulyLeetcodeChallenge.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 03/07/21.
//

import Foundation

struct MaxSumofRectangleNoLargerThanK {
    func callAsFunction(_ matrix: [[Int]], _ k: Int) -> Int {
        var res = Int.min
        let m = matrix.count
        let n = matrix[0].count
        
        
        for left in 0..<n {
            var rowsSum = [Int](repeating: 0, count: m)
            print("------------")
            for right in left..<n {
                for row in 0..<m {
                    print("*** left, Right, depth: \(left), \(right), \(row)")
                    rowsSum[row] += matrix[row][right]
                }
                print("**** Row Sum: \(rowsSum)")
                let subArrayCount = countSubarraysSmallerThenK(rowsSum, k)
                print("**** subArrayCount: \(subArrayCount)")
                res = max(subArrayCount, res)
                print("**** Res: \(res)")
            }
        }
        
        return res
    }
    
    func countSubarraysSmallerThenK(_ arr: [Int], _ k: Int) -> Int {
        var res = Int.min
        
        for i in 0..<arr.count {
            var sum = 0
            for j in i..<arr.count {
                sum += arr[j]
                if sum > res && sum <= k {
                    res = sum
                }
            }
        }
        
        print("**** countSubarraysSmallerThenK: \(res)")
        return res
    }
}
