//
//  LoginViewController.swift
//  面向协议编程三
//
//  Created by 杨帆 on 2019/7/18.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginProtocol {

    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        
        //登录成功以后，将用户名传出去
        self.loginSuccess(username: self.username.text)
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
