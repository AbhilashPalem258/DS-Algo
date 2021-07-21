//
//  BinarySearch.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 10/07/21.
//

import Foundation

func binarySearch<T: Comparable>(_ arr: [T], searchKey: T, range: Range<Int>) -> Int? {
    if range.lowerBound >= range.upperBound {
        return nil
    } else {
        let midIdx = range.lowerBound + (range.upperBound - range.lowerBound)/2
        
        if arr[midIdx] == searchKey {
            return midIdx
        } else if arr[midIdx] > searchKey {
            return binarySearch(arr, searchKey: searchKey, range: range.lowerBound..<midIdx)
        } else {
            return binarySearch(arr, searchKey: searchKey, range: midIdx+1..<range.upperBound)
        }
    }
}

func binarySearchIterative<T: Comparable>(_ arr: [T], key: T) -> Int? {
    var lower = 0, upper = arr.count
    
    while lower < upper {
        let midIdx = lower + (upper - lower)/2
        if arr[midIdx] == key {
            return midIdx
        } else if arr[midIdx] > key {
            upper = midIdx
        } else {
            lower = midIdx+1
        }
    }
    return nil
}

func countOccurances<T: Comparable>(_ arr: [T], key: T) -> Int {
    var lowBoundary: Int {
        var low = 0, upper = arr.count
        while low < upper {
            let midId = low + (upper - low)/2
             if arr[midId] < key {
                low = midId+1
            } else {
                upper = midId
            }
        }
        return low
    }
    
    var upperBoundary: Int {
        var low = 0, upper = arr.count
        while low < upper {
            let mId = low + (upper - low)/2
            if arr[mId] > key {
                upper = mId
            } else {
                low = mId+1
            }
        }
        return upper
    }
    
    return upperBoundary - lowBoundary
}

func minimumMaximun<T: Comparable>(_ arr: [T]) -> (minimum: T, maximum: T)? {
    if arr.isEmpty {
        return nil
    }
    
    if arr.count == 1{
        return (arr.first!, arr.first!)
    }
    
    var maximum = arr.first!, minimum = arr.first!
    
    for i in stride(from: arr.count % 2, to: arr.count, by: 2) {
        let pair = (arr[i], arr[i+1])
        
        if pair.0 < pair.1 {
            minimum = min(pair.0, minimum)
            maximum = max(pair.1, maximum)
        } else {
            minimum = min(pair.1, minimum)
            maximum = max(pair.0, maximum)
        }
    }
    return (minimum, maximum)
}
