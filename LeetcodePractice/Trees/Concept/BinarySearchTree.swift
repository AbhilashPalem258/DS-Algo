//
//  BinarySearchTree.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 24/06/21.
//

import Foundation

protocol BST: ExpressibleByArrayLiteral, Comparable, CustomStringConvertible {
    associatedtype Element: Comparable where Element == Self.ArrayLiteralElement
    init(_ value: Element)
    
    var value: Element { get set }
    var parent: Self { get set }
    var left: Self { get set }
    var right: Self { get set }
    
    var isRoot: Bool { get }
    var isLeft: Bool { get }
    var isRight: Bool { get }
    
    var hasLeftChild: Bool { get }
    var hasRightChild: Bool { get }
    var hasAnyChild: Bool { get }
    var hasBothChild: Bool { get }
    
    func insert(_ value: Element)
    func insert(_ value: Element, from node: Self)
    
    func map(transform: (Element) -> Element) -> [Element]
    func search(_ value: Element) -> Self
    func contains(_ value: Element) -> Bool
    func minimum() -> Self
    func maximum() -> Self
    
    func remove()
    func reconnectParentTo(node: Self)
    
    func isBST(min: Element, max: Element) -> Bool
    
    func traverseInorder(process: (Self.Element) -> Void)
    func traversePreorder(process: (Self.Element) -> Void)
    func traversePostorder(process: (Self.Element) -> Void)
}
