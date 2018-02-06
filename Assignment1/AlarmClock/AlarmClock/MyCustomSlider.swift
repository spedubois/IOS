//
//  MyCustomSlider.swift
//  AlarmClock
//
//  Created by u0482113 on 2/6/18.
//  Copyright © 2018 Spenser DuBois. All rights reserved.
//

import UIKit

class customSlider:UIView
{
    var nibRect : CGRect?
    var x : CGFloat?
    var timeLabel : UILabel?
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext()else{return}
        context.clear(bounds)
        context.setFillColor(UIColor.white.cgColor)
        context.fill(bounds)
        context.setLineWidth(2)
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineCap(CGLineCap.round)
        context.fillPath()
        context.move(to: CGPoint(x: bounds.minX+24, y: bounds.height/2))
        context.addLine(to: CGPoint(x: bounds.maxX-10, y: bounds.height/2))
        context.strokePath()
        context.setShouldAntialias(true)
        
        let y = (bounds.height/2)-10
        let newX = x
        nibRect = CGRect(x: newX!, y: y, width: 20, height: 20).integral
        context.setFillColor(UIColor.blue.cgColor)
        context.fillEllipse(in: nibRect!)
        timeLabel?.text = String(format: "%.0f", x!/2.425)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        x = bounds.minX+22
        timeLabel = UILabel(frame: CGRect(x: bounds.minX, y: bounds.minY, width: 30, height: 30))
        timeLabel?.text = String(format: "%.0f", x!)
        timeLabel?.textColor = UIColor.blue
        
        addSubview(timeLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch : UITouch = touches.first!
        let location : CGPoint = touch.location(in: self)

        if(location.x < 22)
        {
            x = 22
        }
        else if(location.x > 291)
        {
            x = 291
        }
        else{
        x = location.x
        }
        
        setNeedsDisplay()
        
    }
    
}
