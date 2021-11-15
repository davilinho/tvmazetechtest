//
//  AppDelegate.swift
//  tvmazetechtest
//
//  Created by David Martin on 10/11/21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Components.initInjections()
        return true
    }
}
