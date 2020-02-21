//
//  BaseTimeList.swift
//  OneLineWeatherEx
//
//  Created by Jun soo Song on 15/01/2020.
//  Copyright © 2020 amebahead. All rights reserved.
//

import Foundation

// Magnetic Double Linked List
class Node {
    var value: Int
    var prev: Node?
    var next: Node?
    
    init(value: Int) {
        self.value = value
        self.prev = nil
        self.next = nil
    }
}

class BaseTimeList {
    var yesterday: Node
    var tommorrow: Node
    
    init() {
        self.yesterday = Node(value: -100)
        self.tommorrow = Node(value: 100)
        
        // Base Times: 02 - 05 - 08 - 11 - 14 - 17 - 20 - 23
        let baseTimes = [2, 5, 8, 11, 14, 17, 20, 23]
        var now = self.yesterday
        for time in baseTimes {
            let node = Node(value: time)
            now.next = node
            node.prev = now
            
            now = node
        }
        
        now.next = self.tommorrow
        self.tommorrow.prev = now
    }
    
    // 08:00 이전 시간은 -> 02
    func seekTime(value: Int) -> Int {
        if value < 8 {return 2}
        
        var node = self.yesterday.next
        while true {
            if let thisNode = node {
                if thisNode.value < value {
                    node = thisNode.next
                }
                else if thisNode.value == value {
                    return thisNode.prev?.value ?? 2
                }
                else {
                    return thisNode.prev?.prev?.value ?? 2
                }
            }
            else {
                return 2
            }
        }
    }
    
    func shoot() {
        var node = self.yesterday
        while true {
            if node.value != 100 {
                print("\(node.value) ->")
                
                if let nextNode = node.next {
                    node = nextNode
                }
            }
            else {
                print(node.value)
                break
            }
        }
    }
}
