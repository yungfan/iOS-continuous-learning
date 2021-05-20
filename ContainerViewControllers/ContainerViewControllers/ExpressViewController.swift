//
//  ExpressViewController.swift
//  ContainerViewControllers
//
//  Created by 杨帆 on 2019/4/20.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class ExpressViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.blue
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ExpressViewController View Controller Will Appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("ExpressViewController View Controller Will Disappear")
    }

}
