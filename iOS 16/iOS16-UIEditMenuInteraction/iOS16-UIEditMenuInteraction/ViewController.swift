//
//  ViewController.swift
//  iOS16-UIEditMenuInteraction
//
//  Created by 杨帆 on 2022/8/22.
//

import UIKit

class ViewController: UIViewController {
    lazy var textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 500, width: 300, height: 44))
        textField.borderStyle = .roundedRect
        textField.delegate = self
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(textField)
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    // MARK: 通过代理方法添加交互的菜单
    func textField(_ textField: UITextField,
                   editMenuForCharactersIn range: NSRange,
                   suggestedActions: [UIMenuElement]) -> UIMenu? {
        let favorite = UIAction(title: "Favorite") { _ in
            print("favorite")
        }
        let share = UIAction(title: "Share") { _ in
            print("share")
        }
        let delete = UIAction(title: "Delete", attributes: [.destructive]) { _ in
            print("delete")
        }
        return UIMenu(children: [favorite, share, delete])
    }
}

