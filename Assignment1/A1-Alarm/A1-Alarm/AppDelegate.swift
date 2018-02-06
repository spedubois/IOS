//
//  AppDelegate.swift
//  A1-Alarm
//
//  Created by Spenser DuBois on 1/31/18.
//  Copyright © 2018 Spenser DuBois. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let mainWindow = UIWindow()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        mainWindow.rootViewController = UIViewController()
        mainWindow.rootViewController!.view.backgroundColor = UIColor.lightGray
        mainWindow.makeKeyAndVisible()
        
        let hourUpbtn1 = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 45.0, height: 29.0))
        hourUpbtn1.backgroundColor = UIColor.darkGray
        hourUpbtn1.tintColor = UIColor.red
        hourUpbtn1.setTitle("+", for: .normal)
        hourUpbtn1.setTitleColor(UIColor.red, for: .normal)
        
        
        let testView = UIView()
        let testLabel = UILabel(frame: CGRect(x: 0.0, y: 30.0, width: 45.0, height: 75.0))
        testLabel.text = "0"
        testLabel.textColor = UIColor.red
        testLabel.backgroundColor = UIColor.lightGray
        testLabel.textAlignment = NSTextAlignment.center
        testLabel.font = UIFont(name: "DBLCDTempBlack", size: 60)
        
        let testLabel2 = UILabel(frame: CGRect(x: 46.0, y: 30.0, width: 45.0, height: 75.0))
        testLabel2.text = "7"
        testLabel2.textColor = UIColor.red
        testLabel2.backgroundColor = UIColor.lightGray
        testLabel2.textAlignment = NSTextAlignment.center
        testLabel2.font = UIFont(name: "DBLCDTempBlack", size: 60)
        
        let testLabel3 = UILabel(frame: CGRect(x: 112.0, y: 30.0, width: 45.0, height: 75.0))
        testLabel3.text = "3"
        testLabel3.textColor = UIColor.red
        testLabel3.backgroundColor = UIColor.lightGray
        testLabel3.textAlignment = NSTextAlignment.center
        testLabel3.font = UIFont(name: "DBLCDTempBlack", size: 60)
        
        let testLabel4 = UILabel(frame: CGRect(x: 158.0, y: 30.0, width: 45.0, height: 75.0))
        testLabel4.text = "4"
        testLabel4.textColor = UIColor.red
        testLabel4.backgroundColor = UIColor.lightGray
        testLabel4.textAlignment = NSTextAlignment.center
        testLabel4.font = UIFont(name: "DBLCDTempBlack", size: 60)
        
        let testLabel5 = UILabel(frame: CGRect(x: 224.0, y: 30.0, width: 45.0, height: 75.0))
        testLabel5.text = "3"
        testLabel5.textColor = UIColor.red
        testLabel5.backgroundColor = UIColor.lightGray
        testLabel5.textAlignment = NSTextAlignment.center
        testLabel5.font = UIFont(name: "DBLCDTempBlack", size: 60)
        
        let testLabel6 = UILabel(frame: CGRect(x: 270.0, y: 30.0, width: 45.0, height: 75.0))
        testLabel6.text = "8"
        testLabel6.textColor = UIColor.red
        testLabel6.backgroundColor = UIColor.lightGray
        testLabel6.textAlignment = NSTextAlignment.center
        testLabel6.font = UIFont(name: "DBLCDTempBlack", size: 60)
        
        let col1 = UILabel(frame: CGRect(x: 91.0, y: 30, width: 20, height: 75))
        col1.text = ":"
        col1.textColor = UIColor.red
        col1.backgroundColor = UIColor.lightGray
        col1.textAlignment = NSTextAlignment.center
        col1.font = UIFont(name: "DBLCDTempBlack", size: 60)
        
        
        let col2 = UILabel(frame: CGRect(x: 203.0, y: 30, width: 20, height: 75))
        col2.text = ":"
        col2.textColor = UIColor.red
        col2.backgroundColor = UIColor.lightGray
        col2.textAlignment = NSTextAlignment.center
        col2.font = UIFont(name: "DBLCDTempBlack", size: 60)
        
        testView.frame = CGRect(x: 0, y: 30, width: 221, height: 75)
        testView.backgroundColor = UIColor.lightGray
        testView.addSubview(testLabel)
        testView.addSubview(testLabel2)
        testView.addSubview(testLabel3)
        testView.addSubview(testLabel4)
        testView.addSubview(testLabel5)
        testView.addSubview(testLabel6)
        testView.addSubview(col1)
        testView.addSubview(col2)
        testView.addSubview(hourUpbtn1)

        mainWindow.rootViewController?.view.addSubview(testView)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

