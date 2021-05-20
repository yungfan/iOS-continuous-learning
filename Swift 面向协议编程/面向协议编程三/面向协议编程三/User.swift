//
//  User.swift
//  面向协议编程三
//
//  Created by 杨帆 on 2019/7/18.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

//单例
class User {
    
    static let shared = User()
    var name: String?
    var isLogin: Bool = false
    private init() { }

}
