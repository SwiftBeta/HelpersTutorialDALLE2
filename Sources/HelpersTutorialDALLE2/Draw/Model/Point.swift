//
//  Point.swift
//  OpenAI
//
//  Created by Home on 5/11/22.
//

import Foundation

public struct Point {
    let currentPoint: CGPoint
    let lastPoint: CGPoint
    
    public init(currentPoint: CGPoint, lastPoint: CGPoint) {
        self.currentPoint = currentPoint
        self.lastPoint = lastPoint
    }
}
