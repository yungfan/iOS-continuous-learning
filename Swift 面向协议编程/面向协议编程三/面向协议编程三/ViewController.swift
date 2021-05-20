//
//  ViewController.swift
//  面向协议编程三
//
//  Created by 杨帆 on 2019/7/17.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LoginProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if User.shared.isLogin {
            
            self.view.backgroundColor = UIColor.red
            
            print(User.shared.name ?? "")
            
        }
    }

    //点击按钮 判断登录
    @IBAction func login(_ sender: Any) {
        
        if !User.shared.isLogin {
            
            self.loginUI()
            
        }
        
    }
}

