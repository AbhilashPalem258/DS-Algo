//
//  Array475.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 16/06/21.
//

import Foundation

extension ArrayProblems {
    func findRadius(_ houses: [Int], _ heaters: [Int]) -> Int {
        var i = 0, radius = 0
        let houses = houses.sorted(), heaters = heaters.sorted()
        
        for house in houses {
            while i < heaters.count - 1 && 2 * house >= heaters[i] + heaters[i + 1]  {
                i += 1
            }
            
            radius = max(radius, abs(house - heaters[i]))
        }
        
        return radius
    }
}
//[5,7,9]  [1,2,3]
// houses = [1,2,3,4], heaters = [1,4]
