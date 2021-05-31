//
//  ViewController.swift
//  AppTrackingTransparencyTest
//
//  Created by 杨帆 on 2021/5/31.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        AppTrackingPermission().getIDFA { error, idfa in
            if error == nil {
                // 如果拒绝返回一串0
                print(idfa)
            } else {
                print(error!)
            }
        }
    }
}
