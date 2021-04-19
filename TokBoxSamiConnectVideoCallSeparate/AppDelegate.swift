//
//  AppDelegate.swift
//  TokBoxSamiConnectVideoCallSeparate
//
//  Created by Mushrankhan Pathan on 19/04/21.
//

import UIKit

let apde = UIApplication.shared.delegate as! AppDelegate


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var isVideoCallRunning = false
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    
}

