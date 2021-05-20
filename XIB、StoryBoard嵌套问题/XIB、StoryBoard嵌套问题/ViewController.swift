//
//  ViewController.swift
//  XIB、StoryBoard嵌套问题
//
//  Created by 杨帆 on 2019/7/18.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.present(SecondViewController(), animated: true, completion: nil)
        
    }

}

