//
//  OneViewController.swift
//  YFTabBarController
//
//  Created by yangfan on 2018/3/15.
//  Copyright © 2018年 yangfan. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.blue
        
        addOneBtn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension OneViewController {
    
    func addOneBtn(){
        
        let btn = UIButton(type: UIButtonType.custom)
        
        btn.setImage(UIImage(named:"plusX_Last"), for: UIControlState.normal)
        
        btn.bounds = CGRect(x: 0, y: 0, width: 64, height: 64)
        
        btn.center = view.center
        
        btn.addTarget(self, action:#selector(close) , for: UIControlEvents.touchUpInside)
        
        view.addSubview(btn)
    }
    
    @objc func close(){
        
        navigationController?.pushViewController(TwoViewController(), animated: true);
        
    }
    
    
    
}


