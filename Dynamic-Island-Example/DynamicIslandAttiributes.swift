//
//  DynamicIslandAttiributes.swift
//  Dynamic-Island-Example
//
//  Created by Mehmet Ateş on 18.09.2022.
//

import Foundation
import ActivityKit

public enum NavigationDirection: Codable {
    case right
    case left
    case straight
    
    var toString: String {
        switch self {
        case .right:
            return "→"
        case .left:
            return "←"
        case .straight:
            return "↑"
        }
    }
}

struct NavigationAttributes: ActivityAttributes {
    public typealias NavigationStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var nextTurn: NavigationDirection
        var eta: Date
        var time: Int
    }
    
    var destination: String
}
