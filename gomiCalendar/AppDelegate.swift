//
//  AppDelegate.swift
//  gomiCalendar
//
//  Created by liuchenghui on 2022/03/04.
//

import UIKit
import Firebase

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
