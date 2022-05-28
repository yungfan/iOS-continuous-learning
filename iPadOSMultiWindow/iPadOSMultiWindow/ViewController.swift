//
//  ViewController.swift
//  iPadOSMultiWindow
//
//  Created by 杨帆 on 2022/5/28.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let activity = NSUserActivity(activityType: "abc")
        UIApplication.shared.requestSceneSessionActivation(nil, userActivity: activity, options: nil, errorHandler: nil)
    }
}
