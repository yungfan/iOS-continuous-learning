//
//  ViewController.swift
//  视图透明度与控件可见性
//
//  Created by 杨帆 on 2019/7/13.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    
    @IBAction func btnClick(_ sender: Any) {
        
        print("按钮可点击")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 实现底层view透明，而其他控件不透明
        
        //1.设置父View背景色为clear时，子View能看见，父View完全透明（方案可行）
        //self.bgView.backgroundColor = UIColor.clear
        
        
        //2.设置父View的透明度为0，此时子View看不见（方案不可行）
        //self.bgView.alpha = 0
        
        //3.设置父View背景色为透明度为0.1，父View不完全透明（方案可行）
        self.bgView.backgroundColor = UIColor(white: 0, alpha: 0.1)
    }


}

