//
//  AppDelegate.swift
//  BackgroundTasksDemo
//
//  Created by 杨帆 on 2022/7/7.
//

import BackgroundTasks
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let operationQueue = OperationQueue()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registBackgroundTasks()

        return true
    }

    // MARK: 注册后台任务
    func registBackgroundTasks() {
        // 当系统运行具有指定标识符的任务时调用handAppRefresh()方法
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "cn.abc.yf.refresh", using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }

        //  当系统运行具有指定标识符的任务时调用handleDataProcessing()方法
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "cn.abc.yf.dataprocessing", using: nil) { task in
            self.handleDataProcessing(task: task as! BGProcessingTask)
        }
    }

    // MARK: 处理刷新任务
    func handleAppRefresh(task: BGAppRefreshTask) {
        // 因超时或其他问题而不得不被系统终止时，将调用该回调
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }

        // Data Fetching

        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.rootViewController?.view.backgroundColor = .red
        }

        // 告知后台任务调度器任务已完成
        task.setTaskCompleted(success: true)
    }

    // MARK: 处理处理任务
    func handleDataProcessing(task: BGProcessingTask) {
        let operation = BlockOperation {
            print("执行后台任务")
            sleep(1)
        }

        task.expirationHandler = {
            operation.cancel()
        }

        operation.completionBlock = {
            print("完成后台任务")
            OperationQueue.main.addOperation {
                print("刷新界面")
                UIApplication.shared.windows.first?.rootViewController?.view.backgroundColor = .red
            }
            task.setTaskCompleted(success: !operation.isCancelled)
        }

        operationQueue.addOperation(operation)
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
