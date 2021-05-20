//
//  YFNavigationController.swift
//  YFTabBarController
//
//  Created by yangfan on 2018/3/15.
//  Copyright © 2018年 yangfan. All rights reserved.
//

import UIKit

class YFNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        navigationBar.tintColor = UIColor.black
        
        super.pushViewController(viewController, animated: animated)
    }

}
