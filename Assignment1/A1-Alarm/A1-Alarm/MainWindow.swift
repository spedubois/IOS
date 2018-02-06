//
//  MainWindow.swift
//  A1-Alarm
//
//  Created by Spenser DuBois on 1/31/18.
//  Copyright © 2018 Spenser DuBois. All rights reserved.
//

import UIKit

class mainView: UIView
{
    let timeRect = CGRect(x: 0, y: 0, width: 30, height: 50)
    let testLabel = UILabel()
    override func draw(_ rect: CGRect) {
        guard let context: CGContext = UIGraphicsGetCurrentContext()else{return}
        context.clear(bounds)
        
        testLabel.frame = timeRect
        testLabel.text = "TEST"
        context.addRect(timeRect)
    }
}
