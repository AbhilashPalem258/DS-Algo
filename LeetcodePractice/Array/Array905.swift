//
//  Array905.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 16/06/21.
//

import Foundation

extension ArrayProblems {
    func sortArrayByParity(_ nums: [Int]) -> [Int] {
        return nums.reduce(into: [Int]()) {
            $0.insert($1, at: $1.isMultiple(of: 2) ? 0 : $0.count)
        }
    }
}
