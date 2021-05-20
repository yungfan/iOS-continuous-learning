//
//  Protocols.swift
//  面向协议编程一
//
//  Created by 杨帆 on 2019/7/17.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit


//1. 定义协议
protocol Nibloadable {
    
}

//2. 扩展协议
extension Nibloadable {
    
    static func loadFromNib() -> Self {
        
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.first as! Self
    }
    
}
