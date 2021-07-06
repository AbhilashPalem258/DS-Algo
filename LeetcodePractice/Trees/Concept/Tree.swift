//
//  Tree.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 21/06/21.
//

import Foundation

class TreeNode<T> {
    let value: T
    var children: [TreeNode<T>] = []
    
    init(value: T) {
        self.value = value
    }
    
    func add(child: TreeNode) {
        self.children.append(child)
    }
}
extension TreeNode {
    func depthFirstTraversal(_ visit: (TreeNode) -> Void) {
        visit(self)
        children.forEach {
            $0.depthFirstTraversal(visit)
        }
    }
    
    func levelOrderTraversal(_ visit: (TreeNode) -> Void) {
        visit(self)
        var queue = OptimizedQueue<TreeNode>()
        children.forEach {
            queue.enqueue($0)
        }
        while let node = queue.dequeue() {
            visit(node)
            node.children.forEach {
                queue.enqueue($0)
            }
        }
    }
}
extension TreeNode where T: Equatable {
    func search(_ value: T) -> TreeNode? {
        guard self.value != value else {
            return self
        }
        var result: TreeNode?
        
        depthFirstTraversal {
            if value == $0.value {
                result = $0
            }
        }
        
        return result
    }
}
extension TreeNode: Equatable where T: Equatable {
    static func == (lhs: TreeNode<T>, rhs: TreeNode<T>) -> Bool {
        lhs.value == rhs.value
    }
}
