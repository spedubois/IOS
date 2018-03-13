//
//  GameView.swift
//  WordGame
//
//  Created by u0482113 on 3/12/18.
//  Copyright © 2018 u0482113. All rights reserved.
//

import Foundation
import UIKit

class gameView : UIView
{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.lightGray
    }
    
    override func draw(_ rect: CGRect) {
        drawRects()
    }
    
    func drawRects()
    {
        guard let context = UIGraphicsGetCurrentContext() else {return}
        context.setStrokeColor(UIColor.black.cgColor)
        context.setFillColor(UIColor.white.cgColor)
        context.setLineWidth(1)
        for j in 1..<13{
            for i in 0..<10{
                let testRect = CGRect(x: i*41, y: Int((self.frame.height)) - Int(j*40), width: 41, height: 41)
                context.stroke(testRect)
                let smallRect = CGRect(x: testRect.minX+5, y: testRect.minY+5, width: 31, height: 31)
                let testText = "A"
                let paraStyle = NSMutableParagraphStyle()
                paraStyle.alignment = .center
                let attributes = [NSAttributedStringKey.paragraphStyle : paraStyle, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 32), NSAttributedStringKey.foregroundColor:UIColor.black]
                let attString = NSAttributedString(string: testText, attributes: attributes)
                context.stroke(smallRect)
                attString.draw(in: smallRect)
                context.addRect(smallRect)
            }
        }
        
        
    }
}
