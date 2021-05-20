//
//  CenterViewController.swift
//  YFTabBarController
//
//  Created by yangfan on 2018/3/15.
//  Copyright © 2018年 yangfan. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.purple
        
        addOneBtn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CenterViewController{
    
    
    func addOneBtn(){
        
        let btn = UIButton(type: UIButtonType.custom)
        
        btn.setImage(UIImage(named:"plusX_Last"), for: UIControlState.normal)
        
        btn.bounds = CGRect(x: 0, y: 0, width: 64, height: 64)
        
        btn.center = view.center
        
        btn.addTarget(self, action:#selector(close) , for: UIControlEvents.touchUpInside)
        
        view.addSubview(btn)
    }
    
    @objc func close(){
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
}
