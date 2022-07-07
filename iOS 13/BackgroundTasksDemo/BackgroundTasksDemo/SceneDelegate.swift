//
//  SceneDelegate.swift
//  BackgroundTasksDemo
//
//  Created by 杨帆 on 2022/7/7.
//

import BackgroundTasks
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        scheduleAppRefresh()

        scheduleDataProcessing()
    }

    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "cn.abc.yf.refresh")
        // 执行此任务的最早日期，但是最早日期并不等于确切日期，还要看系统调度
        request.earliestBeginDate = Date(timeIntervalSinceNow: 3)

        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print(error.localizedDescription)
        }
    }

    func scheduleDataProcessing() {
        let request = BGProcessingTaskRequest(identifier: "cn.abc.yf.dataprocessing")
        // 是否需要网络连接
        request.requiresNetworkConnectivity = true
        // 是否需要设备连接到外部电源
        request.requiresExternalPower = true

        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print(error.localizedDescription)
        }
    }
}
