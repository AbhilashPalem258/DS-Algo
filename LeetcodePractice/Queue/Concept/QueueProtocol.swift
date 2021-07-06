//
//  QueueProtocol.swift
//  LeetcodePractice
//
//  Created by Abhilash Palem on 20/06/21.
//

import Foundation

protocol QueueProtocol {
    associatedtype Element
    
    var isEmpty: Bool { get }
    var count: Int { get }
    var front: Element? {get}
    
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
}
