//
//  ViewController.swift
//  01-UISheetPresentationController
//
//  Created by 杨帆 on 2021/6/9.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 第一种使用方式，需要更改目标控制器的代码
        first()
        // 第二种使用方式，需要使用UIViewControllerTransitioningDelegate
        // second()
    }

    func first() {
        let modalVC = SecViewController()
        modalVC.view.backgroundColor = .red
        present(modalVC, animated: true, completion: nil)
    }

    func second() {
        let modalVC = SecViewController()
        modalVC.view.backgroundColor = .red
        modalVC.transitioningDelegate = self
        modalVC.modalPresentationStyle = .custom
        present(modalVC, animated: true, completion: nil)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = UISheetPresentationController(presentedViewController: presented, presenting: presenting)
        // 显示模式
        presentationController.detents = [.medium(), .large()]
        // 显示一个指示器表示可以拖拽调整大小
        presentationController.prefersGrabberVisible = true

        return presentationController
    }
}
