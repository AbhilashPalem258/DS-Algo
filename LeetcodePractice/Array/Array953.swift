//
//  Array953.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 16/06/21.
//

import Foundation

struct ArrayProblems {}
extension ArrayProblems {
    func isAlienSorted(_ words: [String], _ order: String) -> Bool {
        let charToOrder = Dictionary(uniqueKeysWithValues: order.enumerated().map{ ($0.1, $0.0) })
        print(charToOrder)
        
        for i in 0..<words.count - 1 {
            let currentWord = Array(words[i]), nextWord = Array(words[i + 1])
            var j = 0
            
            while j < min(currentWord.count, nextWord.count) {
                let firstChar = currentWord[j], secondChar = nextWord[j]
                guard firstChar != secondChar else {
                    j += 1
                    continue
                }
                if charToOrder[firstChar]! > charToOrder[secondChar]! {
                    return false
                } else {
                    break
                }
            }
            if j == nextWord.count && currentWord.count > nextWord.count {
                return false
            }
        }
        return true
    }
}
//["apple","app"]
//["hello","leetcode"], "hlabcdefgijkmnopqrstuvwxyz"
