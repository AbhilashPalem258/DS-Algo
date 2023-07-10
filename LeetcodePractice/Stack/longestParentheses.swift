//
//  longestParentheses.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 19/06/21.
//

import Foundation

class LongestValidParentheses {
    
    func nSpaceSolution(_ s: String) -> Int {
        var stack: [Int] = [-1], maxLength = 0
        
        for (i, char) in s.enumerated() {
            if char == "(" {
                stack.append(i)
            } else {
                _ = stack.popLast()
                if stack.isEmpty {
                    stack.append(i)
                } else {
                    let length = i - stack.last!
                    maxLength = max(maxLength, length)
                }
            }
        }
        return maxLength
    }
    
    func constantSpaceSolution(_ s: String) -> Int {
        var maxLength = 0
        var open: Int = 0
        var close: Int = 0
        
        for char in s {
            if char == "(" {
                open += 1
            } else {
                close += 1
            }
            if open == close {
                maxLength = max(maxLength, open + close)
            } else if close > open {
                open = 0
                close = 0
            }
        }
        
        open = 0
        close = 0
        
        for char in s.reversed() {
            if char == "(" {
                open += 1
            } else {
                close += 1
            }
            if open == close {
                maxLength = max(maxLength, open + close)
            } else if open > close {
                open = 0
                close = 0
            }
        }
        
        return maxLength
        
    }
}

class ExclusiveTimeFunctions {
    func exclusiveTime(_ n: Int, _ logs: [String]) -> [Int] {
        var stack = [(Int, Int)](), res = Array(repeating: 0, count: n)
        
        for log in logs {
            let logComponents = log.components(separatedBy: ":")
            let id = Int(logComponents[0])!, isStart = logComponents[1] == "start", time = Int(logComponents[2])!
            
            if isStart {
                if let last = stack.last {
                    res[last.0] += time - last.1
                }
                stack.append((id, time))
            } else {
                let startTime = stack.removeLast().1
                res[id] += time - startTime + 1
                
                if var last = stack.last {
                    last.1 = time + 1
                    stack[stack.count - 1] = last
                }
            }
        }
        
        return res
    }
}
