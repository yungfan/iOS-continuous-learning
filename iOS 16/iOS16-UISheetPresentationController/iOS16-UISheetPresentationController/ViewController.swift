//
//  ViewController.swift
//  iOS16-UISheetPresentationController
//
//  Created by 杨帆 on 2022/8/24.
//

import UIKit


extension UISheetPresentationController.Detent.Identifier {
    static let small = UISheetPresentationController.Detent.Identifier("small")
}


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let modalViewController = ModalViewController()
        if let sheet = modalViewController.sheetPresentationController {
            // 支持的自定义显示大小
            sheet.detents = [
                .custom { _ in
                    200.0
                },
                .custom(identifier: .small) { context in
                    0.1 * context.maximumDetentValue
                },
                .custom { context in
                    0.5 * context.maximumDetentValue
                },
                .large()]
            sheet.largestUndimmedDetentIdentifier = .small
            sheet.prefersGrabberVisible = true
        }
        present(modalViewController, animated: true)
    }
}


class ModalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
    }
}

