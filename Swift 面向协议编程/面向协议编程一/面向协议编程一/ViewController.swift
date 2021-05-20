//
//  ViewController.swift
//  面向协议编程一
//
//  Created by 杨帆 on 2019/7/17.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //原本需要在基类中定义的方法，现在通过遵守协议获得
        let firstView = FirstView.loadFromNib()
        let secondView = SecondView.loadFromNib()
        
        firstView.frame = CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: 100)
        secondView.frame = CGRect(x: 0, y: 200, width: self.view.bounds.size.width, height: 100)
        
        self.view.addSubview(firstView)
        self.view.addSubview(secondView)
        
    }


}

