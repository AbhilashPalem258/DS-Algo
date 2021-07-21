//
//  SimplifyPath.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 19/06/21.
//

import Foundation

struct SimplifyPath {
    func simplifyPath(_ path: String) -> String {
        var components = [String]()
        let pathComponents = path.components(separatedBy: "/")
        for pathComponent in pathComponents {
            switch pathComponent {
            case "", ".":
                break
            case "..":
                _ = components.popLast()
            default:
                components.append(pathComponent)
            }
        }
        return "/" + components.joined(separator: "/")
    }
}

struct RemoveKDigits {
    func callAsFunction(_ num: String, _ k: Int) -> String {
        let size = num.count
        guard size != k else {
            return "0"
        }
        var collection = [Character](), k = k
        for number in num {
            while k > 0, collection.count > 0, Int(String(collection.last!))! > Int(String(number))! {
                collection.removeLast()
                k -= 1
            }
            collection.append(number)
        }
        for char in collection {
            if char != "0" {
                break
            }
            collection.removeFirst()
        }
        return collection.isEmpty ? "0" : String(collection)
    }
}
/*
 Given a string representing arbitrarily nested ternary expressions, calculate the result of the expression. You can always assume that the given expression is valid and only consists of digits 0-9, ?, :, T and F (T and F represent True and False respectively).
 
 Note:
 The length of the given string is ≤ 10000.
 Each number will contain only one digit.
 The conditional expressions group right-to-left (as usual in most languages).
 The condition will always be either T or F. That is, the condition will never be a digit.
 The result of the expression will always evaluate to either a digit 0-9, T or F.
 
 
 Example 1:
 Input: "T?2:3"

 Output: "2"

 Explanation: If true, then result is 2; otherwise result is 3.
 
 
 Example 2:
 Input: "F?1:T?4:5"

 Output: "4"

 Explanation: The conditional expressions group right-to-left. Using parenthesis, it is read/evaluated as:

              "(F ? 1 : (T ? 4 : 5))"                   "(F ? 1 : (T ? 4 : 5))"
           -> "(F ? 1 : 4)"                 or       -> "(T ? 4 : 5)"
           -> "4"                                    -> "4"
 
 
 Example 3:
 Input: "T?T?F:5:3"

 Output: "F"

 Explanation: The conditional expressions group right-to-left. Using parenthesis, it is read/evaluated as:

              "(T ? (T ? F : 5) : 3)"                   "(T ? (T ? F : 5) : 3)"
           -> "(T ? F : 3)"                 or       -> "(T ? F : 5)"
           -> "F"                                    -> "F"
 */
struct TernaryExpressionParser {
    func callAsFunction(_ expression: String) -> String  {
        var stack = [Character]()
         
         for char in expression.reversed() {
             if !stack.isEmpty && stack.last! == "?" {
                 stack.removeLast()
                 let first = stack.removeLast()
                 stack.removeLast()
                 let second = stack.removeLast()
                 
                 if char == "T" {
                     stack.append(first)
                 } else {
                     stack.append(second)
                 }
             } else {
                 stack.append(char)
             }
         }
         
         
         return stack.isEmpty ? "" : String(stack.last!)
    }
}

fileprivate extension StringProtocol {
    subscript(offset: Int) -> Character {
        return self[index(startIndex, offsetBy: offset)]
    }
}

struct DecodeString {
    func callAsFunction(_ s: String) -> String {
        var res = "", strStack = [String](), intStack = [Int]()
        var i = 0
        while i < s.count {
            if s[i].isNumber {
                var count = 0
                while s[i].isNumber {
                    count = (count * 10) + Int(String(s[i]))!
                    i += 1
                }
                intStack.append(count)
            } else if s[i] == "[" {
                strStack.append(res)
                res = ""
                i += 1
            } else if s[i] == "]" {
                let count = intStack.removeLast()
                var crStr = strStack.removeLast()
                for _ in 1...count {
                    crStr += res
                }
                res = crStr
                i += 1
            } else {
                res += String(s[i])
                i += 1
            }
        }
        return res
    }
}

struct BasicCalculator {
    func callAsFunction(_ s: String) -> Int {
        var result = 0, operand = 0, sign = 1, stack = [Int]()
        for char in s {
            if char.isNumber {
                operand = (operand * 10) + char.wholeNumberValue!
            } else if char == "+" {
                result += operand * sign
                sign = 1
                operand = 0
            } else if char == "-" {
                result += operand * sign
                sign = -1
                operand = 0
            } else if char == "(" {
                stack.append(result)
                stack.append(sign)
                sign = 1
                result = 0
            } else if char == ")" {
                result += operand * sign
                result *= stack.removeLast()
                result += stack.removeLast()
                operand = 0
            }
        }
        return result + (operand * sign)
    }
}

//Link: https://leetcode.com/problems/valid-parentheses/
struct ValidParentheses {
    func callAsFunction(_ s: String) -> Bool {
        let rule = "()[]{}"
        var ruleMap = [Character: Int]()
        for (i, element) in rule.enumerated() {
            ruleMap[element] = i
        }
        var stack = [Character]()
        for char in s {
            if ruleMap[char]! % 2 == 0 {
                stack.append(char)
            } else {
                if stack.isEmpty {
                    return false
                } else {
                    if ruleMap[char]! - ruleMap[stack.last!]! == 1 {
                        stack.removeLast()
                    } else {
                        return false
                    }
                }
            }
        }
        return stack.isEmpty ? true : false
    }
}

//Link: https://leetcode.com/problems/longest-valid-parentheses/
struct LongestValidParenthesesII {
    func callAsFunction(_ s: String) -> Int {
        var stack = [Int](), start = 0, longest = 0
        for (i, element) in s.enumerated() {
            if element == "(" {
                stack.append(i)
            } else {
                if stack.isEmpty {
                    start = i + 1
                } else {
                    stack.removeLast()
                    
                    if let last = stack.last {
                        longest = i - last
                    } else {
                        longest = i - start + 1
                    }
                }
            }
        }
        return longest
    }
}

//Link: https://leetcode.com/problems/evaluate-reverse-polish-notation/
struct EvaluateReversePolishNotation {
    func callAsFunction(_ tokens: [String]) -> Int {
        var stack = [Int]()
        
        for token in tokens {
            if let num = Int(token) {
                stack.append(num)
            } else {
                if let postPrev = stack.popLast(), let prev = stack.popLast() {
                    stack.append(operate(token, prev, postPrev))
                }
            }
        }
        if let last = stack.last {
            return last
        } else {
            fatalError("Invalid Result")
        }
    }
    
    private func operate(_ token: String, _ prevNum: Int, _ postPrevNum: Int) -> Int {
        switch token {
        case "+":
            return prevNum + postPrevNum
        case "-":
            return prevNum - postPrevNum
        case "*":
            return prevNum * postPrevNum
        case "/":
            return prevNum / postPrevNum
        default:
            fatalError("Invalid Input")
        }
    }
}
