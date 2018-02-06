//
//  MainView.swift
//  AlarmClock
//
//  Created by Spenser DuBois on 2/5/18.
//  Copyright © 2018 Spenser DuBois. All rights reserved.
//

import UIKit

class mainView : UIView
{
    var hourLabel : UILabel?
    var minLabel : UILabel?
    var secLabel : UILabel?
    
    var timeString : String = "0 : 0 : 0"
    var days : String = ""
    
    var hour : Double?
    var min : Double?
    var sec : Double?
    
    var duration : Int?
    
    var timeZone : String?
    
    var hourStepper : UIStepper?
    var minStepper : UIStepper?
    var secStepper : UIStepper?
    
    var textLayer : CATextLayer?
    var textLayerDays : CATextLayer?
    
    var monday : UIButton?
    var tuesday : UIButton?
    var wednesday : UIButton?
    var thursday : UIButton?
    var friday : UIButton?
    var saturday : UIButton?
    var sunday : UIButton?
    
    var daySet : Array<UIButton>?
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext()else{return}
        context.clear(bounds)
        context.setFillColor(UIColor.white.cgColor)
        context.setShouldAntialias(true)
        context.fill(CGRect(x: 0.0, y: 0.0, width: bounds.maxX, height: bounds.maxY))
        
        textLayer?.string = timeString
        textLayer?.font = UIFont(name: "DBLCDTempBlack", size: 18)
        textLayer?.foregroundColor = UIColor.red.cgColor
        textLayer?.frame = CGRect(x: 10, y: 30, width: bounds.maxX, height: 50)
        
        textLayerDays?.string = days
        textLayerDays?.font = UIFont(name: "Helvetica", size: 9)
        textLayerDays?.foregroundColor = UIColor.red.cgColor
        textLayerDays?.fontSize = 12
        textLayerDays?.frame = CGRect(x: 10, y: 80, width: bounds.maxX, height: 20)
        
        self.layer.addSublayer(textLayerDays!)
        self.layer.addSublayer(textLayer!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLayer = CATextLayer()
        textLayerDays = CATextLayer()
        
        hour = 0
        min = 0
        sec = 0
        
        daySet = Array<UIButton>()
        
        monday = UIButton(type: .roundedRect)
        monday?.frame = CGRect(x: 5, y: 270, width: 40, height: 40)
        monday?.setTitle("M", for: .normal)
        monday?.layer.cornerRadius = 5
        monday?.layer.borderColor = UIColor.black.cgColor
        monday?.layer.borderWidth = 1
        monday?.addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchDown)
        daySet?.append(monday!)
        
        tuesday = UIButton(type: .roundedRect)
        tuesday?.frame = CGRect(x: 50, y: 270, width: 40, height: 40)
        tuesday?.setTitle("T", for: .normal)
        tuesday?.layer.cornerRadius = 5
        tuesday?.layer.borderColor = UIColor.black.cgColor
        tuesday?.layer.borderWidth = 1
        tuesday?.addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchDown)
        daySet?.append(tuesday!)
        
        wednesday = UIButton(type: .roundedRect)
        wednesday?.frame = CGRect(x: 95, y: 270, width: 40, height: 40)
        wednesday?.setTitle("W", for: .normal)
        wednesday?.layer.cornerRadius = 5
        wednesday?.layer.borderColor = UIColor.black.cgColor
        wednesday?.layer.borderWidth = 1
        wednesday?.addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchDown)
        daySet?.append(wednesday!)
        
        thursday = UIButton(type: .roundedRect)
        thursday?.frame = CGRect(x: 140, y: 270, width: 40, height: 40)
        thursday?.setTitle("TH", for: .normal)
        thursday?.layer.cornerRadius = 5
        thursday?.layer.borderColor = UIColor.black.cgColor
        thursday?.layer.borderWidth = 1
        thursday?.addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchDown)
        daySet?.append(thursday!)
        
        friday = UIButton(type: .roundedRect)
        friday?.frame = CGRect(x: 185, y: 270, width: 40, height: 40)
        friday?.setTitle("F", for: .normal)
        friday?.layer.cornerRadius = 5
        friday?.layer.borderColor = UIColor.black.cgColor
        friday?.layer.borderWidth = 1
        friday?.addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchDown)
        daySet?.append(friday!)
        
        saturday = UIButton(type: .roundedRect)
        saturday?.frame = CGRect(x: 230, y: 270, width: 40, height: 40)
        saturday?.setTitle("S", for: .normal)
        saturday?.layer.cornerRadius = 5
        saturday?.layer.borderColor = UIColor.black.cgColor
        saturday?.layer.borderWidth = 1
        saturday?.addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchDown)
        daySet?.append(saturday!)
        
        sunday = UIButton(type: .roundedRect)
        sunday?.frame = CGRect(x: 275, y: 270, width: 40, height: 40)
        sunday?.setTitle("SU", for: .normal)
        sunday?.layer.cornerRadius = 5
        sunday?.layer.borderColor = UIColor.black.cgColor
        sunday?.layer.borderWidth = 1
        sunday?.addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchDown)
        daySet?.append(sunday!)
        
        hourLabel = UILabel(frame: CGRect(x: 25.0, y: 160, width: 75, height: 75))
        hourLabel?.text = "HOUR"
        hourLabel?.adjustsFontSizeToFitWidth = true
        
        minLabel = UILabel(frame: CGRect(x: 128.0, y: 160, width: 75, height: 75))
        minLabel?.text = "MINUTE"
        minLabel?.adjustsFontSizeToFitWidth = true
        
        secLabel = UILabel(frame: CGRect(x: 230.0, y: 160, width: 75, height: 75))
        secLabel?.text = "SECOND"
        secLabel?.adjustsFontSizeToFitWidth = true
        
        hourStepper = UIStepper(frame: CGRect(x: 5, y: 215, width: 60, height: 50))
        hourStepper?.maximumValue = 23
        hourStepper?.minimumValue = 0
        hourStepper?.stepValue = 1
        hourStepper?.backgroundColor = UIColor.white
        hourStepper?.addTarget(self, action: #selector(self.stepperAction(_:)), for: .valueChanged)
        
        minStepper = UIStepper(frame: CGRect(x: 113, y: 215, width: 60, height: 50))
        minStepper?.maximumValue = 59
        minStepper?.minimumValue = 0
        minStepper?.stepValue = 1
        minStepper?.backgroundColor = UIColor.white
        minStepper?.addTarget(self, action: #selector(self.stepperAction(_:)), for: .valueChanged)
        
        secStepper = UIStepper(frame: CGRect(x: 220, y: 215, width: 60, height: 50))
        secStepper?.maximumValue = 59
        secStepper?.minimumValue = 0
        secStepper?.stepValue = 1
        secStepper?.backgroundColor = UIColor.white
        secStepper?.addTarget(self, action: #selector(self.stepperAction(_:)), for: .valueChanged)
        
        addSubview(hourLabel!)
        addSubview(minLabel!)
        addSubview(secLabel!)
        addSubview(hourStepper!)
        addSubview(minStepper!)
        addSubview(secStepper!)
        addSubview(monday!)
        addSubview(tuesday!)
        addSubview(wednesday!)
        addSubview(thursday!)
        addSubview(friday!)
        addSubview(saturday!)
        addSubview(sunday!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonPressed(_ sender: AnyObject?)
    {
        textLayerDays?.removeFromSuperlayer()
        if(sender === monday!)
        {
            if(monday?.isSelected)!
            {
                monday?.isSelected = false
                
                monday?.backgroundColor = UIColor.clear
                
            }
            else
            {
                monday?.backgroundColor = UIColor.lightGray
                monday?.isSelected = true
            }
        }
        if(sender === tuesday!)
        {
            if(tuesday?.isSelected)!
            {
                tuesday?.isSelected = false
                
                tuesday?.backgroundColor = UIColor.clear
                
            }
            else
            {
                tuesday?.backgroundColor = UIColor.lightGray
                tuesday?.isSelected = true
            }
        }
        if(sender === wednesday!)
        {
            if(wednesday?.isSelected)!
            {
                wednesday?.isSelected = false
                
                wednesday?.backgroundColor = UIColor.clear
                
            }
            else
            {
                wednesday?.backgroundColor = UIColor.lightGray
                wednesday?.isSelected = true
            }
        }
        if(sender === thursday!)
        {
            if(thursday?.isSelected)!
            {
                thursday?.isSelected = false
                
                thursday?.backgroundColor = UIColor.clear
                
            }
            else
            {
                thursday?.backgroundColor = UIColor.lightGray
                thursday?.isSelected = true
            }
        }
        if(sender === friday!)
        {
            if(friday?.isSelected)!
            {
                friday?.isSelected = false
                
                friday?.backgroundColor = UIColor.clear
                
            }
            else
            {
                friday?.backgroundColor = UIColor.lightGray
                friday?.isSelected = true
            }
        }
        if(sender === saturday!)
        {
            if(saturday?.isSelected)!
            {
                saturday?.isSelected = false
                
                saturday?.backgroundColor = UIColor.clear
                
            }
            else
            {
                saturday?.backgroundColor = UIColor.lightGray
                saturday?.isSelected = true
            }
        }
        if(sender === sunday!)
        {
            if(sunday?.isSelected)!
            {
                sunday?.isSelected = false
                
                sunday?.backgroundColor = UIColor.clear
                
            }
            else
            {
                sunday?.backgroundColor = UIColor.lightGray
                sunday?.isSelected = true
            }
        }
        days = ""
        for day in daySet!
        {
            if(day.isSelected)
            {
                days += "\(day.currentTitle ?? "")  "
            }
        }
        setNeedsDisplay()
    }
    
    @objc func stepperAction(_ sender: AnyObject?)
    {
        if (sender === hourStepper!)
        {
            textLayer?.removeFromSuperlayer()
            let val = hourStepper?.value.rounded()
            hour = val
            let h:String = String(format: "%.0f", val!)
            let m:String = String(format: "%.0f", min!)
            let s:String = String(format: "%.0f", sec!)
            timeString = h + " : " + m + " : " + s
        }
        if(sender === minStepper!)
        {
            textLayer?.removeFromSuperlayer()
            let val = minStepper?.value.rounded()
            min = val
            let h:String = String(format: "%.0f", hour!)
            let m:String = String(format: "%.0f", val!)
            let s:String = String(format: "%.0f", sec!)
            timeString = h + " : " + m + " : " + s
        }
        if(sender === secStepper!)
        {
            textLayer?.removeFromSuperlayer()
            let val = secStepper?.value.rounded()
            sec = val
            let h:String = String(format: "%.0f", hour!)
            let m:String = String(format: "%.0f", min!)
            let s:String = String(format: "%.0f", val!)
            timeString = h + " : " + m + " : " + s
        }
        setNeedsDisplay()
    }
}
