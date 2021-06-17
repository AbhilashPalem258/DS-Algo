//
//  Array485.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 16/06/21.
//

import Foundation

extension ArrayProblems {
    func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
        var localMax = 0, globalMax = 0
        for num in nums {
            if num == 1 {
                localMax += 1
                globalMax = max(localMax, globalMax)
            } else {
                localMax = 0
            }
        }
        return globalMax
    }
}
//[1,1,0,1,1,1]
