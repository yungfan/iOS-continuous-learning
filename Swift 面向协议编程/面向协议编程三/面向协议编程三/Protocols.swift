//
//  Protocols.swift
//  面向协议编程一
//
//  Created by 杨帆 on 2019/7/17.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit


//1. 定义协议
protocol LoginProtocol  {
    //跳转界面登录
    func loginUI()
    //登录成功处理
    func loginSuccess(username:String?)
}

//2. 扩展协议
extension LoginProtocol where Self: UIViewController {
    
    
    func loginUI(){
        
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "abc") as! LoginViewController
        
        present(loginVC, animated: true, completion: nil)
        
    }

    
    func loginSuccess(username:String?){
        
        User.shared.isLogin = true
        User.shared.name = username
        
    }
}
