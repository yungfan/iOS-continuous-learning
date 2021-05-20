//
//  MyButton.swift
//  扩大按钮点击范围
//
//  Created by 杨帆 on 2019/7/16.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class MyButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // 将按钮的点击范围上下左右扩大10pt的范围，注意范围不要超出父视图的边界，超出范围依旧无效。
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let newFrame = CGRect(x: bounds.origin.x - 10, y: bounds.origin.y - 10, width: bounds.size.width + 20, height: bounds.size.height + 20)
        return newFrame.contains(point)
    }

}
