//
//  AppDelegate.swift
//  FilterTestDemo
//
//  Created by 刘飞 on 2020/11/4.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let screen = UIScreen.main.bounds
        self.window = UIWindow.init(frame: screen)
        let vc = ViewController.init()
        self.window?.rootViewController = vc
        
//        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
//        let tvc = sb.instantiateViewController(withIdentifier: "TestTableViewController") as! TestTableViewController
//        self.window?.rootViewController = tvc
        
        return true
    }

    
}

