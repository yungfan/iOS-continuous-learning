//
//  ViewController.swift
//  震动反馈
//
//  Created by 杨帆 on 2019/3/7.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    let notificationGenerator = UINotificationFeedbackGenerator()
    
    
    @IBAction func clickMeDown(_ sender: UIButton) {
        impactGenerator.prepare()
        impactGenerator.impactOccurred()
    }
    
    
    @IBAction func clickMeUp(_ sender: UIButton) {
        //impactGenerator.impactOccurred()
        notificationGenerator.notificationOccurred(.error)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

