//
//  ViewController.swift
//  05-SF Symbols
//
//  Created by 杨帆 on 2021/6/12.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imgViewOne: UIImageView!
    @IBOutlet var imgViewTwo: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // hierarchicalColor：多层渲染，透明度不同
        let config = UIImage.SymbolConfiguration(hierarchicalColor: .systemRed)
        let image = UIImage(systemName: "square.stack.3d.down.right.fill", withConfiguration: config)
        imgViewOne.image = image

        // paletteColors：多层渲染，设置不同风格
        let config2 = UIImage.SymbolConfiguration(paletteColors: [.systemRed, .systemGreen, .systemBlue])
        let image2 = UIImage(systemName: "person.3.sequence.fill", withConfiguration: config2)
        imgViewTwo.image = image2
    }
}
