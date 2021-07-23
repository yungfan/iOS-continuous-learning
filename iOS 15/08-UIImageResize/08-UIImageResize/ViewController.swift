//
//  ViewController.swift
//  08-UIImageResize
//
//  Created by 杨帆 on 2021/7/16.
//

import UIKit

class ViewController: UIViewController {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        imageView.center = view.center
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)

        // 1. preparingThumbnail
        let image = UIImage(named: "sv.png")?.preparingThumbnail(of: CGSize(width: 200, height: 100))

        // 2. preparingThumbnail，闭包中直接获取调整后的UIImage
        UIImage(named: "sv.png")?.prepareThumbnail(of: CGSize(width: 200, height: 100)) { image in
            // 需要回到主线程
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }

        // 3. 异步操作
        Task {
            await UIImage(named: "sv.png")?.byPreparingThumbnail(ofSize: CGSize(width: 100, height: 100))
        }
    }
}
