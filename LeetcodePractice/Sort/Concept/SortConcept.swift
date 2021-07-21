//
//  SortConcept.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 13/07/21.
//

import Foundation

struct Sort {
    // O(n^2) worst, O(nlogn) best
    static func insertionSort<T: Comparable>(_ arr: inout [T]) {
        for i in 1..<arr.count {
            var currentIndex = i
            while currentIndex > 0 && arr[currentIndex] < arr[currentIndex - 1] {
                (arr[currentIndex], arr[currentIndex - 1]) = (arr[currentIndex - 1], arr[currentIndex])
                currentIndex -= 1
            }
        }
    }
    
    static func quickSort<T: Comparable>(_ arr: [T]) -> [T]{
        guard arr.count > 1 else {
            return arr
        }
        let pivot = arr[arr.count/2]
        let left = arr.filter { $0 < pivot }
        let equal = arr.filter { $0 == pivot }
        let right = arr.filter { $0 > pivot }
        
        return quickSort(left) + equal + quickSort(right)
    }
    
    // NOTE: This implementation does not handle negative numbers
    static func radixSort(_ array: inout [Int] ) {
      var radix = 10, digit = 1, done = false
        while !done {
            done = true
            var buckets = [[Int]](repeating: [], count: radix)
            
            for number in array {
                let index = number/digit
                buckets[index % radix].append(number)
                if done && index > 0 {
                    done = false
                }
            }
            
            var i = 0
            for bucket in buckets {
                for num in bucket {
                    array[i] = num
                    i += 1
                }
            }
            
            digit *= radix
        }
    }
}
