//
//  143.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 18/06/21.
//

import Foundation

class LL143 {
    func reorderList(_ head: ListNode?) {
        var nodeArr = [ListNode]()
        var node = head
        while let currentNode = node {
            nodeArr.append(currentNode)
            node = currentNode.next
        }
        
        for i in 0...(nodeArr.count - 1)/2 {
            let j = nodeArr.count - 1 - i
            if j + 1 < nodeArr.count {
                nodeArr[j+1].next =  nodeArr[i]
            }
            
            if j == nodeArr.count/2 {
                nodeArr[j].next = nil
            } else {
                nodeArr[i].next = nodeArr[j]
            }
        }
    }
}
