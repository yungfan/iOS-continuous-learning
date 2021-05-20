//
//  WeatherViewController.swift
//  ContainerViewControllers
//
//  Created by 杨帆 on 2019/4/20.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.red
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("WeatherViewController View Controller Will Appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("WeatherViewController View Controller Will Disappear")
    }

}
