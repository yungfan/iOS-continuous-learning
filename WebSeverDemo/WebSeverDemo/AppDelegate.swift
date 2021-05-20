//
//  AppDelegate.swift
//  WebSeverDemo
//
//  Created by 杨帆 on 2020/12/24.
//

import Foundation
import GCDWebServer
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var webServer: GCDWebServer?

    let folderPath = Bundle.main.path(forResource: "localWeb", ofType: nil)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        initWebServer()

        print("HTML base folder Path: \(folderPath!)")

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate {
    func initWebServer() {
        webServer = GCDWebServer()

        webServer!.addGETHandler(forBasePath: "/", directoryPath: folderPath!, indexFilename: "index.html", cacheAge: 3600, allowRangeRequests: true)

        webServer!.start(withPort: 8080, bonjourName: "GCD Web Server")

        print("Visit \(webServer?.serverURL) in your web browser")

        print("AppDelegate is Runing \(webServer?.isRunning)")

        print("Visit \(webServer?.serverURL) in your web browser")
    }
}
