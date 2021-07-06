//
//  BinaryTree.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 21/06/21.
//

import Foundation

class BinaryTreeNode<T> {
    let value: T
    
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    
    init(value: T) {
        self.value = value
    }
}
extension BinaryTreeNode {
    func preOrderTraversal(_ visit: (BinaryTreeNode<T>) -> Void) {
        visit(self)
        left?.preOrderTraversal(visit)
        right?.preOrderTraversal(visit)
    }
    
    func postOrderTraversal(_ visit: (BinaryTreeNode<T>) -> Void) {
        left?.postOrderTraversal(visit)
        right?.postOrderTraversal(visit)
        visit(self)
    }
    
    func inOrderTraversal(_ visit: (BinaryTreeNode<T>) -> Void) {
        left?.inOrderTraversal(visit)
        visit(self)
        right?.inOrderTraversal(visit)
    }
}
extension BinaryTreeNode: Equatable where T: Equatable {
    static func == (lhs: BinaryTreeNode<T>, rhs: BinaryTreeNode<T>) -> Bool {
        lhs.value == rhs.value
    }
}
