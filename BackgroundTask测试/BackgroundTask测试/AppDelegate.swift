//
//  AppDelegate.swift
//  BackgroundTask测试
//
//  Created by 杨帆 on 2019/9/8.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // 任务ID
    var backgroundTask: UIBackgroundTaskIdentifier! = nil
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        
        //短时间常驻3分钟
        
        // 如果已存在后台任务，先将其设为完成
        if self.backgroundTask != nil {
            
            application.endBackgroundTask(self.backgroundTask)
            
            self.backgroundTask = .invalid
        }
        
        // 注册后台任务
        self.backgroundTask = application.beginBackgroundTask{
            
            // 如果没有调用endBackgroundTask，时间耗尽时应用程序将被终止
            application.endBackgroundTask(self.backgroundTask)
            
            self.backgroundTask = .invalid
            
        }
        
        //要进行的后台任务
        yourTask()
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
    
    private func yourTask()  {
        
        for _ in 0...10 {
            
            print("Hello")
            
            Thread.sleep(forTimeInterval: 1.0)
        }
        
    }
    
    
}

