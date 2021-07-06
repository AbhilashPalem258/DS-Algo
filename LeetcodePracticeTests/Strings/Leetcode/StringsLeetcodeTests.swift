//
//  StringsLeetcodeTests.swift
//  LeetcodePracticeTests
//
//  Created by Abhilash Palem on 25/06/21.
//

import XCTest
@testable import LeetcodePractice

class StringsLeetcodeTests: XCTestCase {

    func testFizzBuzz() {
        let obj = FizzBuzz()
        XCTAssertEqual(obj(n: 3), ["1","2","Fizz"])
        XCTAssertEqual(obj(n: 5), ["1","2","Fizz","4","Buzz"])
        XCTAssertEqual(obj(n: 15), ["1","2","Fizz","4","Buzz","Fizz","7","8","Fizz","Buzz","11","Fizz","13","14","FizzBuzz"])
    }
    
    func testFirstUniqCharInStr() {
        let obj = FirstUniqCharInStr()
        XCTAssertEqual(obj("leetcode"), 0)
        XCTAssertEqual(obj("loveleetcode"), 2)
        XCTAssertEqual(obj("aabb"), -1)
    }
    
    func testKeyboardRow() {
        let obj = KeyboardRow()
        XCTAssertEqual(obj(["Hello","Alaska","Dad","Peace"]), ["Alaska","Dad"])
    }
    
    func testValidWordAbbreviation() {
        let obj = ValidWordAbbreviation()
        XCTAssertEqual(obj.validWordAbbreviation("internationalization", "i12iz4n"), true)
    }
    
    func testValidPalindrome() {
        let obj = ValidPalindrome()
//        XCTAssertEqual(obj("A man, a plan, a canal: Panama"), true)
//        XCTAssertEqual(obj("race a car"), false)
        
        XCTAssertEqual(obj.solution2("A man, a plan, a canal: Panama"), true)
        XCTAssertEqual(obj.solution2("race a car"), false)
    }
    
    func testValidPalindromeII() {
        let obj = ValidPalindromeII()
        XCTAssertEqual(obj("aba"), true)
        XCTAssertEqual(obj("abca"), true)
        XCTAssertEqual(obj("abc"), false)
    }
    
    func testPalindromePermutation() {
        let obj = PalindromePermutation()
        XCTAssertEqual(obj("code"), false)
        XCTAssertEqual(obj("aab"), true)
        XCTAssertEqual(obj("carerac"), true)
    }
    
    func testDetectCapitals() {
        let obj = DetectCapitals()
        XCTAssertEqual(obj.detectCapitalUse("USA"), true)
        XCTAssertEqual(obj.detectCapitalUse("leetcode"), true)
        XCTAssertEqual(obj.detectCapitalUse("Google"), true)
        XCTAssertEqual(obj.detectCapitalUse("FlaG"), false)
    }
    
    func testCountAndSay() {
        let obj = CountAndSay()
        XCTAssertEqual(obj.countAndSay(4), "1211")
    }
    
    func testFlipGame() {
        let obj = FlipGame()
        XCTAssertEqual(obj("++++"),["--++","+--+","++--"])
    }
    
    func testImplementstrStr() {
        let obj = ImplementstrStr()
        XCTAssertEqual(obj.strStr("hello", "ll"), 2)
        XCTAssertEqual(obj.strStr("aaaaa", "bba"), -1)
        XCTAssertEqual(obj.strStr("", ""), 0)
        
        XCTAssertEqual(obj.strStr1("hello", "ll"), 2)
        XCTAssertEqual(obj.strStr1("aaaaa", "bba"), -1)
        XCTAssertEqual(obj.strStr1("", ""), 0)
    }
    
    func testIsomorphicStr() {
        let obj = IsIsomorphic()
        XCTAssertEqual(obj("egg", "add"), true)
        XCTAssertEqual(obj("foo", "bar"), false)
        XCTAssertEqual(obj("paper", "title"), true)
    }
    
    func testReverseString() {
        let obj = ReverseString()
        
        var s: [Character] = ["h","e","l","l","o"]
        obj(&s)
        XCTAssertEqual(s, ["o","l","l","e","h"])
    }
    
    func testReverseStringII() {
        let obj = ReverseStringII()
        
        XCTAssertEqual(obj("a", 2), "a")
    }
    
    func testReverseVowels() {
        let obj = ReverseVowels()
        XCTAssertEqual(obj("hello"), "holle")
    }
    
    func testReverseWords() {
        let obj = ReverseWordsInString()
        XCTAssertEqual(obj("the sky is blue"), "blue is sky the")
        XCTAssertEqual(obj("a good   example"), "example good a")
        XCTAssertEqual(obj("  hello world  "), "world hello")
    }
    
    func testReverseWordsII() {
        let obj = ReverseWordsInStrII()
        
        var s: [Character] = ["t","h","e"," ","s","k","y"," ","i","s"," ","b","l","u","e"]
        obj.reverseWords(&s)
        XCTAssertEqual(s,  ["b","l","u","e"," ","i","s"," ","s","k","y"," ","t","h","e"])
    }
    
    func testReverseWordsIII() {
        let obj = ReverseWordsIII()
        
        XCTAssertEqual(obj("Let's take LeetCode contest"),  "s'teL ekat edoCteeL tsetnoc")
        XCTAssertEqual(obj("God Ding"),  "doG gniD")
    }
    
    func testLengthLastWord() {
        let obj = LengthLastWord()
        XCTAssertEqual(obj("Hello World"), 5)
        XCTAssertEqual(obj(" "), 0)
    }
    
    func testStringCompression() {
        let obj = StringCompression()
        
        var chars: [Character] = ["a","a","b","b","c","c","c"]
        XCTAssertEqual(obj.compress(&chars), 6)
    }
    
    func testAddStrings() {
        let obj = AddStrings()
//        XCTAssertEqual(obj.addStrings("1", "9"), "10")
        XCTAssertEqual(obj.addStrings("11", "123"), "134")
//        XCTAssertEqual(obj.addStrings("456", "77"), "533")
//        XCTAssertEqual(obj.addStrings("0", "0"), "0")
    }
    
    func testShortestToChar() {
        let obj = ShortestToChar()
        XCTAssertEqual(obj.shortestToChar("loveleetcode", "e"), [3,2,1,0,1,0,0,1,2,2,1,0])
    }
    
    func testMultiplyStrings() {
        let obj = MultiplyTwoNumbers()
        XCTAssertEqual(obj.multiply("2", "3"), "6")
        XCTAssertEqual(obj.multiply("123", "456"), "56088")
    }
    
    func testValidAnagram() {
        let obj = ValidAnagram()
        XCTAssertEqual(obj.isAnagram("anagram", "nagaram"), true)
        XCTAssertEqual(obj.isAnagram("rat", "car"), false)
    }
    
    func testRansomeNote() {
        let obj = RansomeNote()
        XCTAssertEqual(obj.canConstruct("a", "b"), false)
        XCTAssertEqual(obj.canConstruct("aa", "ab"), false)
        XCTAssertEqual(obj.canConstruct("aa", "aab"), true)
    }
    
    func testFindDuplicate() {
        let obj = FindDuplicate()
        XCTAssertEqual(obj(["root/a 1.txt(abcd) 2.txt(efgh)","root/c 3.txt(abcd)","root/c/d 4.txt(efgh)","root 4.txt(efgh)"]),  [["root/a/2.txt","root/c/d/4.txt","root/4.txt"],["root/a/1.txt","root/c/3.txt"]])
    }
    
    func testLongestCommonPrefix() {
        let obj = LongestCommonPrefix()
        XCTAssertEqual(obj(["flower","flow","flight"]), "fl")
    }
    
    func testLengthOfLongestSubstring() {
        let obj = LengthOfLongestSubsctring()
        XCTAssertEqual(obj.lengthOfLongestSubstring("abba"), 2)
//        XCTAssertEqual(obj.lengthOfLongestSubstring("abcabcbb"), 3)
//        XCTAssertEqual(obj.lengthOfLongestSubstring("bbbbb"), 1)
//        XCTAssertEqual(obj.lengthOfLongestSubstring("pwwkew"), 3)
    }
    
    func testOneEditDistance() {
        let obj = OneEditDistance()
        XCTAssertEqual(obj("ab", "acb"), true)
        XCTAssertEqual(obj("cab", "ad"), false)
        XCTAssertEqual(obj("1203", "1213"), true)
    }
    
    func testPermutationInStr() {
        let obj = PermutationInStr()
        XCTAssertEqual(obj("ab", "eidbaooo"), true)
    }
    
    func testFindAnagramsInStr() {
        let obj = FindAnagramsInStr()
        XCTAssertEqual(obj.findAnagrams("cbaebabacd", "abc"), [0,6])
        XCTAssertEqual(obj.findAnagrams("cbaebabacd", "abc"), [0,6])
        XCTAssertEqual(obj.findAnagrams("cbaebabacd", "abc"), [0,6])
    }
    
    func testMinmumWindowSubstring() {
        let obj = MinWindowSubstring()
        XCTAssertEqual(obj.minWindow("ADOBECODEBANC", "ABC"), "BANC")
    }
}
