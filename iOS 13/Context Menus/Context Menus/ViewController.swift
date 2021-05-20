//
//  ViewController.swift
//  Context Menus
//
//  Created by 杨帆 on 2020/6/16.
//  Copyright © 2020 杨帆. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 需要打开User Interaction
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建UIContextMenuInteraction
        let interaction = UIContextMenuInteraction(delegate: self)
        // 添加UIContextMenuInteraction
        imageView.addInteraction(interaction)
    }
}

// 代理方法
extension ViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        // 第一个
        let favorite = UIAction(title: "Favorite", image: UIImage(systemName: "heart.fill")) { action in
            print("favorite")
        }
        
        let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up.fill")) { action in
            print("share")
        }
        
        let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), attributes: [.destructive]) { action in
            print("delete")
        }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            UIMenu(title: "Actions", children: [favorite, share, delete])
        }
    }
}
