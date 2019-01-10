//
//  Canvas.swift
//  DrawingApp
//
//  Created by Raul Mena on 1/3/19.
//  Copyright © 2019 Raul Mena. All rights reserved.
//

import UIKit

class Canvas: UIView{
    
    
    fileprivate var lines = [Line]()
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth: Float = 1
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            for (index, point) in line.points.enumerated(){
                if index == 0{
                    context.move(to: point)
                }
                else{
                    context.addLine(to: point)
                }
            }
            context.strokePath()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // new line
        let newLine = Line.init(strokeWidth: strokeWidth, color: strokeColor, points: [])
        lines.append(newLine)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: nil) else {return}
        
        guard var line = lines.popLast() else {return}
        
        line.points.append(point)
        
        lines.append(line)
        
        setNeedsDisplay()
    }
    
    func clear(){
        lines.removeAll()
        setNeedsDisplay()
    }
    
    
    func undo(){
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func setStrokeColor(color: UIColor){
        self.strokeColor = color
    }
    
    func setStrokeWidth(width: Float){
        self.strokeWidth = width
    }
    
    /*  Draw a line using CAShapeLayer
     */
    func drawLine(){
        
        var currentPoint: CGPoint = CGPoint(x: 0, y: 0)
        
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: currentPoint)
        
        while currentPoint.x < frame.width && currentPoint.y < frame.height{
            currentPoint.x += 1
            currentPoint.y += 1
            path.addLine(to: currentPoint)
        }
        
        path.close()
        
        shapeLayer.path = path.cgPath
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 3
        
        shapeLayer.lineWidth = 10
        shapeLayer.strokeColor = UIColor.red.cgColor
        
        shapeLayer.add(animation, forKey: "drawLineAnimation")
        
        layer.addSublayer(shapeLayer)
        
    }
}
