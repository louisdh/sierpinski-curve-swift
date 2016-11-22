//
//  SierpinskiView.swift
//  Sierpinski
//
//  Created by Louis D'hauwe on 21/11/2016.
//  Copyright © 2016 Silver Fox. All rights reserved.
//

import UIKit

@IBDesignable
class SierpinskiView: UIView {
	
	@IBInspectable var level: CGFloat = 3.0 {
		didSet {
			setNeedsDisplay()
		}
	}
	
	@IBInspectable var lineWidth: CGFloat = 3.0 {
		didSet {
			setNeedsDisplay()
		}
	}
	
	@IBInspectable var strokeColor: UIColor = .red {
		didSet {
			setNeedsDisplay()
		}
	}
	
	@IBInspectable var fillColor: UIColor = .clear {
		didSet {
			setNeedsDisplay()
		}
	}
	
    override func draw(_ rect: CGRect) {
		
		// Inset for line width
		let rect = rect.insetBy(dx: lineWidth / 2.0, dy: lineWidth / 2.0)
		
		let turtle = DrawingTurtle(location: .zero)
		
		sierpinski(size: 1.0, level: level, with: turtle)

		let path = turtle.path
		
		let scale = rect.width / path.bounds.width
		path.apply(CGAffineTransform(scaleX: scale, y: scale))
		
		path.apply(CGAffineTransform(translationX: -path.bounds.origin.x + lineWidth / 2.0, y: -path.bounds.origin.y + lineWidth / 2.0))

		path.lineWidth = lineWidth
		fillColor.setFill()
		strokeColor.setStroke()
		path.lineCapStyle = .round
		path.lineJoinStyle = .round
		path.stroke()
		
		if fillColor != .clear {
			path.fill()
		}
		
    }

	fileprivate func sierpinski(size: CGFloat, level: CGFloat, with turtle: Turtle) {
		
		turtle.rotate(clockwise: 45.0)

		halfSierpinski(size: size, level: level, with: turtle)
		
		turtle.rotate(clockwise: 90.0)
		turtle.move(by: size)
		turtle.rotate(clockwise: 90.0)
		
		halfSierpinski(size: size, level: level, with: turtle)

		turtle.rotate(clockwise: 90.0)
		turtle.move(by: size)
		turtle.rotate(clockwise: 90.0)
		
	}

	fileprivate func halfSierpinski(size: CGFloat, level: CGFloat, with turtle: Turtle) {
		
		if level <= 0.0 {
			turtle.move(by: size)
			return
		}
		
		halfSierpinski(size: size, level: level - 1, with: turtle)
		
		turtle.rotate(counterClockwise: 45.0)

		turtle.move(by: size * sqrt(2))
		
		turtle.rotate(counterClockwise: 45.0)

		
		halfSierpinski(size: size, level: level - 1, with: turtle)

		turtle.rotate(clockwise: 90.0)

		turtle.move(by: size)

		turtle.rotate(clockwise: 90.0)

		
		halfSierpinski(size: size, level: level - 1, with: turtle)

		turtle.rotate(counterClockwise: 45.0)
		
		turtle.move(by: size * sqrt(2))

		turtle.rotate(counterClockwise: 45.0)
		
		halfSierpinski(size: size, level: level - 1, with: turtle)

		
		
	}
	
}

