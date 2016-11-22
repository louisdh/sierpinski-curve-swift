//
//  Turtle.swift
//  Sierpinski
//
//  Created by Louis D'hauwe on 22/11/2016.
//  Copyright © 2016 Silver Fox. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class DrawingTurtle: Turtle {
	
	fileprivate var location: CGPoint
	fileprivate var angle: CGFloat = 0.0
	
	fileprivate(set) var path: UIBezierPath
	
	init(location: CGPoint) {
		self.location = location
		self.path = UIBezierPath()
		path.move(to: location)
	}
	
	func move(to location: CGPoint) {
		self.location = location
		path.move(to: location)
	}
	
	func move(by distance: CGFloat) {
		
		let anchorPoint = CGPoint(x: location.x + distance, y: location.y)
		
		let endPoint = anchorPoint.rotated(around: location, by: angle.degreesToRadians)
		
		path.addLine(to: endPoint)
		self.location = endPoint
		
	}
	
	func rotate(clockwise deltaAngle: CGFloat) {
		angle += deltaAngle
	}
	
	func rotate(counterClockwise deltaAngle: CGFloat) {
		angle -= deltaAngle
	}
	
}

fileprivate extension CGPoint {
	
	fileprivate func rotated(around b: CGPoint, by angle: CGFloat) -> CGPoint {
		
		let a = self
		let x = b.x + (a.x - b.x) * cos(angle) - (a.y - b.y) * sin(angle)
		let y = b.y + (a.x - b.x) * sin(angle) + (a.y - b.y) * cos(angle)
		
		return CGPoint(x: x, y: y)
		
	}
	
}

protocol Turtle {
	
	func move(to location: CGPoint)
	func move(by distance: CGFloat)
	func rotate(clockwise angle: CGFloat)
	func rotate(counterClockwise angle: CGFloat)
	
}

fileprivate extension FloatingPoint {
	
	var degreesToRadians: Self {
		return self * .pi / 180
	}
	
	var radiansToDegrees: Self {
		return self * 180 / .pi
	}
	
}
