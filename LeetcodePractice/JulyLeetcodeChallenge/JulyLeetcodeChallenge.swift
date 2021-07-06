//
//  JulyLeetcodeChallenge.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 03/07/21.
//

import Foundation

struct FindClosestElements {
    func callAsFunction(_ arr: [Int], _ k: Int, _ x: Int) -> [Int] {
        let count = arr.count
        guard k < count else {
            return arr
        }
        
        var diff = 0
        for i in 0..<k {
            diff += abs(x - arr[i])
        }
        var mindiff = diff, mindiffId = k - 1
        
        for i in k..<count {
            diff += abs(x - arr[i]) - abs(x - arr[i - k])
            if diff < mindiff {
                mindiff = diff
                mindiffId = i
            }
        }
        return Array(arr[mindiffId - (k - 1)...mindiffId])
    }
}

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
