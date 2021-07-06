//
//  StringsLeetcode.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 25/06/21.
//

import Foundation

//Link: https://leetcode.com/problems/fizz-buzz/
struct FizzBuzz {
    func callAsFunction(n: Int) -> [String] {
        var result = [String](repeating: "", count: n)
        for i in 1...n {
            if i % 3 == 0 && i % 5 == 0 {
                result[i - 1] = "FizzBuzz"
            } else if i % 3 == 0 {
                result[i - 1] = "Fizz"
            } else if i % 5 == 0 {
                result[i - 1] = "Buzz"
            } else {
                result[i - 1] = "\(i)"
            }
        }
        return result
    }
}

//link: https://leetcode.com/problems/first-unique-character-in-a-string/
struct FirstUniqCharInStr {
    func callAsFunction(_ s: String) -> Int {
        var sMap = [Character: Bool]()
        for c in s {
            if let _ = sMap[c] {
                sMap[c] = true
            } else {
                sMap[c] = false
            }
        }
        
        for (i, element) in s.enumerated() {
            if !sMap[element]! {
                return i
            }
        }
        return -1
    }
}

//link: https://leetcode.com/problems/keyboard-row/
struct KeyboardRow {
    func callAsFunction(_ words: [String]) -> [String] {
        let rowOne = "qwertyuiop", rowTwo = "asdfghjkl", rowThree = "zxcvbnm"
        
        return words.filter { word in rowOne.contains(word.lowercased()) || rowTwo.contains(word.lowercased()) || rowThree.contains(word.lowercased()) }
    }
}
extension String {
    func contains(_ str: String) -> Bool {
        str.filter { c in !self.contains(c) }.isEmpty
    }
}


class ValidWordAbbreviation {
    func validWordAbbreviation(_ word: String, _ abbr: String) -> Bool {
        let wordChars = Array(word)
        let abbrChars = Array(abbr)
        
        var i = 0, j = 0
        
        while i < wordChars.count && j < abbrChars.count {
            if abbrChars[j].isNumber {
                
                if abbrChars[j] == "0" {
                    return false
                }
                
                let start = j
                
                while j < abbrChars.count && abbrChars[j].isNumber {
                    j += 1
                }
                
                let end = j - 1
                
                i += Int(String(abbrChars[start...end]))!
                
            } else {
                if wordChars[i] != abbrChars[j] {
                    return false
                } else {
                    i += 1
                    j += 1
                }
            }
        }
        
        return i == wordChars.count && j == abbrChars.count
    }
}


//link: https://leetcode.com/problems/valid-palindrome/
struct ValidPalindrome {
    //Solution 1
    func callAsFunction(_ s: String) -> Bool {
        let s = Array(s.lowercased())
        var i = 0, j = s.count - 1
        
        while i < j {
            while !(s[i].isLetter || s[i].isNumber) && i < j {
                i += 1
            }
            while !(s[i].isLetter || s[i].isNumber) && i < j {
                j -= 1
            }
            if s[i].lowercased() != s[j].lowercased() {
                return false
            } else {
                i += 1
                j -= 1
            }
        }
        return true
    }
    
    //Solution 2
    func solution2(_ s: String) -> Bool {
        
        let alphabets: ClosedRange<UInt32> = 97...122
        let numbers: ClosedRange<UInt32> = 48...57

        var words = [UInt32]()
        
        let s = s.lowercased()
        for char in s.unicodeScalars {
            if alphabets.contains(char.value) || numbers.contains(char.value) {
                words.append(char.value)
            }
        }
                
        var i = 0
        var j = words.count - 1
        while i < j {
            if words[i] != words[j] {
                return false
            } else {
                i += 1
                j -= 1
            }
        }
        return true
    }
}

//link: Valid Palindrome II
struct ValidPalindromeII {
    func callAsFunction(_ s: String) -> Bool {
        guard !s.isEmpty else {
            return true
        }
        return isValidPalindrome(s, skipLeft: true) || isValidPalindrome(s, skipLeft: false)
    }
    
    private func isValidPalindrome(_ s: String, skipLeft: Bool) -> Bool {
        var alreadySkipped = false
        
        let s = Array(s)
        var i = 0
        var j = s.count - 1
        
        while i < j {
            if s[i] != s[j] {
                if alreadySkipped {
                    return false
                } else {
                    alreadySkipped = true
                }
                skipLeft ? (i += 1) : (j -= 1)
            } else {
                i += 1
                j -= 1
            }
        }
        return true
    }
}

/*
 Given a string, determine if a permutation of the string could form a palindrome.

 For example, "code" -> False, "aab" -> True, "carerac" -> True.

 Hint:

 Consider the palindromes of odd vs even length. What difference do you notice? Count the frequency of each character. If each character occurs even number of times, then it must be a palindrome. How about character which occurs odd number of times?
 */
struct PalindromePermutation {
    func callAsFunction(_ s: String) -> Bool {
        var charMap = [Character: Int]()
        
        for char in s {
            charMap[char, default: 0] += 1
        }
        
        var alreadySkippedMiddle = false
        
        for (_, value) in charMap {
            if value == 2 {
                continue
            } else if value == 1 {
                if alreadySkippedMiddle {
                    return false
                } else {
                    alreadySkippedMiddle = true
                }
            } else {
                return false
            }
        }
        
        return true
    }
}

class DetectCapitals {
    func detectCapitalUse(_ word: String) -> Bool {
        var isValid = true
        
        if word.count == 1 {
            return true
        }
        
        if word[word.startIndex].isUppercase {
            if word[word.index(word.startIndex, offsetBy: 1)].isUppercase {
                detectCapitalHelper(word: word, startIndex: 2, keypath: \.isLowercase, isValid: &isValid)
            } else {
                detectCapitalHelper(word: word, startIndex: 2, keypath: \.isUppercase, isValid: &isValid)
            }
        } else {
            detectCapitalHelper(word: word, startIndex: 1, keypath: \.isUppercase, isValid: &isValid)
        }
        
        return isValid
    }
    
    func detectCapitalHelper(word: String, startIndex: Int, keypath: KeyPath<Character, Bool>, isValid: inout Bool) {
        for i in startIndex..<word.count {
            if word[word.index(word.startIndex, offsetBy: i)][keyPath: keypath] {
                isValid = false
                break
            }
        }
    }
}

class CountAndSay {
    func countAndSay(_ n: Int) -> String {
        guard n > 1 else {
            return "1"
        }
        
        var result = ""
        let prevArray = Array(countAndSay(n - 1))
        var currentChar: Character? = nil
        var nbChar = 0
        
        for element in prevArray {
            if currentChar == nil {
                currentChar = element
                nbChar = 1
            } else if (currentChar! == element) {
                nbChar += 1
            } else {
                result += String(nbChar) + String(currentChar!)
                currentChar = element
                nbChar = 1
            }
        }
        
        result += String(nbChar) + String(currentChar!)
        return result
    }
}

/*
 You are playing the following Flip Game with your friend: Given a string that contains only these two characters: + and -, you and your friend take turns to flip two consecutive “++” into “–”. The game ends when a person can no longer make a move and therefore the other person will be the winner.

 Write a function to compute all possible states of the string after one valid move.

 Example:

 Input: s = “++++“
 Output:
 [
 ”--++”,
 "+--+",
 "++--"
 ]
 Note: If there is no valid move, return an empty list [].
 */
class FlipGame {
    func callAsFunction(_ s: String) -> [String] {
        var res = [String]()
        let sChars = Array(s)
        
        guard sChars.count > 1 else {
            return []
        }
        
        for i in 0..<sChars.count - 1 {
            if sChars[i] == "+" && sChars[i + 1] == "+" {
                res.append(sChars[0..<i] + "--" + sChars[i+2..<sChars.count])
            }
        }
        return res
    }
}

class ImplementstrStr {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        guard let regex = try? NSRegularExpression(pattern: needle) else { return 0 }
        let range = NSRange(location: 0, length: haystack.count)
        let result = regex.firstMatch(in: haystack, options: [], range: range)
        return result?.range.lowerBound ?? -1
    }
    
    func strStr1(_ haystack: String, _ needle: String) -> Int {
        guard !needle.isEmpty else {
            return 0
        }
        
        guard needle.count <= haystack.count else {
            return -1
        }
        let needleArr = Array(needle)
        let haystackArr = Array(haystack)
                
        for (i, element) in haystackArr.enumerated() where element == needleArr[0] {
            guard (haystackArr.count - i) >= needleArr.count else { return -1 }
            
            var count = 1
            for j in 1..<needleArr.count {
                if haystackArr[i + j] == needleArr[j] {
                    count += 1
                }
            }
            if count == needleArr.count { return i }
        }
        return -1
    }
}

class IsIsomorphic {
    func callAsFunction(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else {
            return false
        }
        var relatedCharacterMap = [Character: Character]()
        let sChars = Array(s)
        let tChars = Array(t)
        
        for i in 0..<t.count {
            let firstStrChar = sChars[i]
            let secondStrChar = tChars[i]
            
            if let value = relatedCharacterMap[firstStrChar] {
                if value == secondStrChar {
                    continue
                } else {
                    return false
                }
            }
            
            if !relatedCharacterMap.values.contains(secondStrChar) {
                relatedCharacterMap[firstStrChar] = secondStrChar
            } else {
                return false
            }
        }
        return true
    }
}

struct ReverseString {
    func callAsFunction(_ s: inout [Character]) {
        var i = 0, j = s.count - 1
        while i < j {
            let temp = s[i]
            s[i] = s[j]
            s[j] = temp
            i += 1
            j -= 1
        }
    }
}

//link: https://leetcode.com/problems/reverse-string-ii/
struct ReverseStringII {
    func callAsFunction(_ s: String, _ k: Int) -> String {
        var s = Array(s)
        
        func reverse(low: Int, high: Int) {
            var i = low
            var j = high
            while i < j {
                (s[i], s[j]) = (s[j], s[i])
                i += 1
                j -= 1
            }
        }
        
        for i in stride(from: 0, to: s.count, by: 2 * k) {
            let low = i
            let high = i + 2*k - 1
            let middle = (low + high) / 2
            
            reverse(low: low, high: middle >= s.count ? s.count - 1 : middle)
        }
        
        return String(s)
    }
}

struct ReverseVowels {
    func callAsFunction(_ s: String) -> String {
        var sChars = Array(s), idx = [Int]()
        let mSet = Set<Character>(["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"])
        
        for (i, element) in sChars.enumerated() {
            if mSet.contains(element) {
                idx.append(i)
            }
        }
        
        if idx.count == 0 {
            return s
        }
        
        var i = 0, j = idx.count - 1
        while i < j {
            (sChars[idx[i]], sChars[idx[j]]) = (sChars[idx[j]], sChars[idx[i]])
            i += 1
            j -= 1
        }
        
        return String(sChars)
    }
    

}

//link: https://leetcode.com/problems/reverse-words-in-a-string/
class ReverseWordsInString {
    func callAsFunction(_ s: String) -> String {
        var components = s.split(separator: " ")
        let count = components.count
        
        var i = 0, j = count - 1
        while i < j {
            (components[i], components[j]) = (components[j], components[i])
            i += 1
            j -= 1
        }
        
        return components.joined(separator: " ")
    }
}
/*
 Given an input string, reverse the string word by word.
 Example:
 Input:
 ["t","h","e"," ","s","k","y"," ","i","s"," ","b","l","u","e"]

 Output:
 ["b","l","u","e"," ","i","s"," ","s","k","y"," ","t","h","e"]
 
 Note:
 A word is defined as a sequence of non-space characters.
 The input string does not contain leading or trailing spaces.
 The words are always separated by a single space.
 Follow up: Could you do itin-placewithout allocating extra space?
 Topics: Two Pointers, String
 */
struct ReverseWordsInStrII {
    func reverseWords(_ str: inout [Character]) {
        func reverse(start: Int, end: Int) {
            var i = start, j = end
            while i < j {
                (str[i], str[j]) = (str[j], str[i])
                i += 1
                j -= 1
            }
        }
        
        var last = 0
        reverse(start: 0, end: str.count - 1)
        
        for i in 0..<str.count {
            if i+1 == str.count || (str[i] != " " && str[i + 1] == " ") {
                reverse(start: last, end: i)
                last = i + 2
            }
        }
    }
}

struct ReverseWordsIII {
    func callAsFunction(_ s: String) -> String {
        var s = Array(s)
        func reverse(start: Int, end: Int) {
            var i = start
            var j = end
            while i < j {
                (s[i], s[j]) = (s[j], s[i])
                i += 1
                j -= 1
            }
        }
        
        var last = 0
        for i in 0..<s.count {
            if  i+1 == s.count || (s[i] != " " && s[i + 1] == " ") {
                reverse(start: last, end: i)
                last = i + 2
            }
        }
        
        return String(s)
    }
}

struct LengthLastWord {
    func callAsFunction(_ s: String) -> Int {
        var res = 0
        let sChars = Array(s)
        
        for i in (0..<sChars.count).reversed() {
            let element = sChars[i]
            if res == 0 {
                if element == " " {
                    continue
                } else {
                    res += 1
                }
            } else {
                if element == " " {
                    break
                } else {
                    res += 1
                }
            }
        }
        
        return res
    }
}

//link: https://leetcode.com/problems/string-compression/
class StringCompression {
    func compress(_ chars: inout [Character]) -> Int {
        var read = 0, write = 0
        
        while read < chars.count {
            let char = chars[read]
            var count = 0
            
            while read < chars.count, chars[read] == char {
                count += 1
                read += 1
            }
            
            chars[write] = char
            write += 1
            
            if count > 1 {
                String(count).forEach {
                    chars[write] = $0
                    write += 1
                }
            }
        }
        return write
    }
}

class AddStrings {
    func addStrings(_ num1: String, _ num2: String) -> String {
        let str1 = Array(num1)
        let str2 = Array(num2)
        
        var res = Array(repeating: 0, count: max(num1.count, num2.count) + 1)
        
        for i in 0..<str1.count {
            res[i] = str1[str1.count - 1 - i].wholeNumberValue!
        }
        
        for i in 0..<str2.count {
            res[i] += str2[str2.count - 1 - i].wholeNumberValue!
        }
        
        for i in 0..<(res.count - 1) {
            res[i+1] += res[i] / 10
            res[i] %= 10
        }
        
        var ret = ""
        var i = res.count - 1
        while i >= 0 && res[i] == 0 {
            i -= 1
        }
        
        while i >= 0 {
            ret += String(res[i])
            i -= 1
        }
        
        return ret == "" ? "0" : ret
    }
}

class ShortestToChar {
    func shortestToChar(_ s: String, _ c: Character) -> [Int] {
        let sChars = Array(s)
        let n = sChars.count
        var ans = [Int](repeating: 0, count: n)
        
        var prev = Int.min/2
        for i in 0..<n {
            if sChars[i] == c { prev = i }
            ans[i] = i - prev
        }
        
        prev = Int.max/2
        for i in (0..<n).reversed() {
            if sChars[i] == c { prev = i }
            ans[i] = min(ans[i], prev - i)
        }
        
        return ans
    }
}

class MultiplyTwoNumbers {
    func multiply(_ num1: String, _ num2: String) -> String {
        if num1 == "0" || num2 == "0" { return "0" }
        if num1 == "1" || num2 == "1" {
            if num1 != "1" {
                return num1
            }
            if num2 != "1" {
                return num2
            }
        }
        
        let n1 = num1.reversed().map{ Int(String($0))! }, n2 = num2.reversed().map{ Int(String($0))! }
        var ans = [Int](repeating: 0, count: n1.count + n2.count)
        
        for i in 0..<n1.count {
            for j in 0..<n2.count {
                ans[i + j] += n1[i] * n2[j]
            }
        }
        
        for i in 0..<ans.count - 1 {
            ans[i + 1] += ans[i]/10
            ans[i] %= 10
        }
        
        while ans.last == 0 {
            ans.removeLast()
        }
        
        var output = ""
        while let element = ans.popLast() {
            output.append("\(element)")
        }
        return output
    }
}

//link: https://leetcode.com/problems/valid-anagram/
class ValidAnagram {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        var ss = Array(repeating: 0, count: 26)
        var tt = Array(repeating: 0, count: 26)
        
        let aVal = Int("a".unicodeScalars.first!.value)
        
        for scalar in s.unicodeScalars {
            ss[Int(scalar.value) - aVal] += 1
        }
        
        for scalar in t.unicodeScalars {
            tt[Int(scalar.value) - aVal] += 1
        }
        
        return ss == tt
    }
}

//link: https://leetcode.com/problems/ransom-note/
class RansomeNote {
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        var mutableMagazine = magazine
        for char in ransomNote {
            if let index = mutableMagazine.firstIndex(of: char) {
                mutableMagazine.remove(at: index)
            } else {
                return false
            }
        }
        return true
    }
}

struct GroupAnagrams {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var sortedStrToStrs = [String: [String]]()
        for str in strs {
            sortedStrToStrs[String(str.sorted()), default: []].append(str)
        }
        return Array(sortedStrToStrs.values)
    }
}

struct FindDuplicate {
    func callAsFunction(_ paths: [String]) -> [[String]] {
        var contentPathMap = [String: [String]]()
        for path in paths {
            let components = path.split(separator: " ")
            
            guard let dir = components.first else {
                continue
            }
            
            for i in 1..<components.count {
                let file = components[i]
                let fileInfo = file.split(separator: "(")
                if let fileName = fileInfo.first, let filecontent = fileInfo.last?.dropLast() {
                    contentPathMap[String(filecontent), default: []].append("\(dir)/\(fileName)")
                }
            }
        }
        return Array(contentPathMap.values).filter { $0.count >= 2}
    }
}

class LongestCommonPrefix {
    func callAsFunction(_ strs: [String]) -> String {
        guard var prefix = strs.first else { return "" }
        
        for i in 1..<strs.count {
            while !strs[i].hasPrefix(prefix) {
                prefix.removeLast()
                if prefix.isEmpty {
                    return ""
                }
            }
        }
        
        return prefix
    }
}

class LengthOfLongestSubsctring {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var left = 0, sChars = Array(s), ans = 0, charMap = [Character: Int]()
        
        for r in 0..<sChars.count {
            let element = sChars[r]
            if let existingIndex = charMap[element] {
                left = max(left, existingIndex)
            }
            ans = max(ans, r - left + 1)
            charMap[element] = r + 1
        }
        return ans
    }
}
/*
 Given two strings s and t, determine if they are both one edit distance apart.

 Note:

 There are 3 possiblities to satisify one edit distance apart:

 Insert a character into s to get t
 Delete a character from s to get t
 Replace a character of s to get t
 
 Example 1:
 Input: s = "ab", t = "acb"
 Output: true
 Explanation: We can insert 'c' into s to get t.
 
 Example 2:
 Input: s = "cab", t = "ad"
 Output: false
 Explanation: We cannot get t from s by only one step.

 Example 3:
 Input: s = "1203", t = "1213"
 Output: true
 Explanation: We can replace '0' with '1' to get t.

 If s and t are One Edit Distance, then s and t are equal in length, do a replacement, or have a length difference of one, delete or insert.
 */

struct OneEditDistance {
   
    enum EditType {
        case insert
        case delete
        case replace
    }
    
    func callAsFunction(_ s: String, _ t: String) -> Bool {
        guard s != t else {
            return false
        }
        
        var editType: EditType = .insert
        if s.count - t.count == 1 {
            editType = .delete
        } else if t.count - s.count == 1 {
            editType = .insert
        } else if s.count == t.count {
            editType = .replace
        } else {
            return false
        }
        
        let sChars = Array(s), tChars = Array(t)
        var i = 0, j = 0, flag = false
        
        while i < sChars.count && j < tChars.count {
            if sChars[i] != tChars[j] {
                
                guard !flag else {
                    return false
                }
                
                flag = true
                
                switch editType {
                case .insert:
                    j += 1
                case .delete:
                    i += 1
                case .replace:
                    i += 1
                    j += 1
                }
                
            } else {
                i += 1
                j += 1
            }
        }
        return true
    }
}

class WordPattern {
    func callAsFunction(_ pattern: String, _ s: String) -> Bool {
        guard pattern.count == s.components(separatedBy: " ").count else {
            return false
        }
        let sArray: [String] = s.components(separatedBy: " ")
        var dict = [Character: String]()
        for (i, char) in pattern.enumerated() {
            if let str = dict[char] {
                if str != sArray[i] {
                    return false
                }
            } else {
                if dict.values.contains(sArray[i]) {
                    return false
                }
                dict[char] = sArray[i]
            }
        }
        return true
    }
}

struct PermutationInStr {
    func callAsFunction(_ s1: String, _ s2: String) -> Bool {
        guard s2.count > s1.count else {
            return false
        }
        guard !s1.isEmpty else {
            return true
        }
        
        let len = s1.count
        var dict = [Character: Int]()
        for c in s1 {
            dict[c, default: 0] += 1
        }
        var count = len
        
        let sChars = Array(s2)
        var start = 0
        
        for end in 0..<sChars.count {
            let element = sChars[end]
            if (end - start + 1) > len {
                if let n = dict[sChars[start]] {
                    dict[sChars[start]] = n + 1
                    if n + 1 > 0 {
                        count += 1
                    }
                }
                start += 1
            }
            if let n = dict[element] {
                dict[element] = n - 1
                if n - 1 >= 0 {
                    count -= 1
                }
            }
            if count == 0 {
                return true
            }
        }
        return false
    }
}

class FindAnagramsInStr {
    func findAnagrams(_ s: String, _ p: String) -> [Int] {
        guard !s.isEmpty, s.count >= p.count else {
            return []
        }
        
        let s = s.map { letterIndex($0) }
        let p = p.map { letterIndex($0) }
        
        var pArray = Array(repeating: 0, count: 26)
        for value in p {
            pArray[value] += 1
        }
        
        var result = [Int]()
        var slidingArr = Array(repeating: 0, count: 26)
        for i in 0..<s.count {
            slidingArr[s[i]] += 1
            if i - p.count >= 0 {
                slidingArr[s[i - p.count]] -= 1
            }
            if slidingArr == pArray {
                result.append(i - p.count + 1)
            }
        }
        return result
    }
    
    private func letterIndex(_ c: Character) -> Int {
        Int(c.unicodeScalars.first!.value - Unicode.Scalar("a").value)
    }
}

class MinWindowSubstring {
    func minWindow(_ s: String, _ t: String) -> String {
        if t.count > s.count { return "" }
        
        var window = [Character: Int]()
        for c in t {
            window[c, default: 0] += 1
        }
        var count = window.count
        
        var minLength = Int.max
        var head = 0, slow = 0
        let sChars = Array(s)
        
        for i in 0..<sChars.count {
            let char = sChars[i]
            if let find = window[char] {
                window[char] = find - 1
                if find - 1 == 0 {
                    count -= 1
                }
            }
            
            while count == 0 {
                if (i - slow + 1) < minLength  {
                    minLength = i - slow + 1
                    head = slow
                }
                
                let temp = sChars[slow]
                if let find = window[temp] {
                    window[temp] = find + 1
                    if find + 1 > 0 {
                        count += 1
                    }
                }
                
                slow += 1
            }
        }
        
        if minLength == Int.max {
            return ""
        }
        
        return String(sChars[head..<head+minLength])
    }
}
