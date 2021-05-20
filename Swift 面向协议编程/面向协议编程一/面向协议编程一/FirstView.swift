//
//  FirstView.swift
//  面向协议编程一
//
//  Created by 杨帆 on 2019/7/17.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit


// 由于现在默认不能在创建View的时候勾选 创建xibm，所以只能后创建xib后关联类文件
// 3. 遵守协议，获得加载View的方法
class FirstView: UIView, Nibloadable {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
