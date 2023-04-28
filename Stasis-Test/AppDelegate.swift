//
//  AppDelegate.swift
//  Stasis-Test
//
//  Created by Арсений on 22.04.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootWindow = UIWindow(frame: UIScreen.main.bounds)
        let view = ViewFactory.createMainView()
        rootWindow.rootViewController = view
        window = rootWindow
        rootWindow.makeKeyAndVisible()
        return true
    }

}


