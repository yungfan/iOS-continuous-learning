//
//  SecViewController.swift
//  01-UISheetPresentationController
//
//  Created by 杨帆 on 2021/6/9.
//

import UIKit

class SecViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setPresentationController()
    }

    func setPresentationController() {
        if let presentationController = presentationController as? UISheetPresentationController {
            // 支持的显示模式
            presentationController.detents = [.medium(), .large()]
            // 显示一个指示器表示可以拖拽调整大小
            presentationController.prefersGrabberVisible = true
        }
    }
}
