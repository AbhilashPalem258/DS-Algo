//
//  longestParentheses.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 19/06/21.
//

import Foundation

class LongestValidParentheses {
    func longestValidParentheses(_ s: String) -> Int {
        var stack = [Int](), longest = 0, start = 0
        
        for (i, char) in s.enumerated() {
            if char == "(" {
                stack.append(i)
            } else {
                if !stack.isEmpty {
                    stack.removeLast()
                    
                    if let last = stack.last {
                        longest = max(longest, i - last)
                    } else {
                        longest = max(longest, i - start + 1)
                    }
                } else {
                    start = i + 1
                }
            }
        }
        
        return longest
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
