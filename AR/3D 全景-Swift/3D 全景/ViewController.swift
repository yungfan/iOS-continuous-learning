//
//  ViewController.swift
//  3D 全景
//
//  Created by 杨帆 on 2019/5/9.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit
import CTPanoramaView

class ViewController: UIViewController {
    
    lazy var panaromaView = { () -> CTPanoramaView in
        
        let panaromaView = CTPanoramaView(frame: self.view.bounds)
        
        panaromaView.controlMethod = .touch
        
        return panaromaView
        
    }()
    
    lazy var changeModeBtn = { () -> UIButton in
        
        let button = UIButton(type:.custom)
        
        button.frame = CGRect(x: self.view.bounds.size.width - 100, y:40, width:80, height:30)
        
        button.setTitle("感控", for: .normal)
        
        button.setTitleColor(UIColor.blue, for: .normal)
        
        button.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        
        //默认false
        print(button.isSelected)
        
        return button
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let image = UIImage(named: "1-203 B.jpg")
        
        self.panaromaView.image = image
        
        self.view.addSubview(self.changeModeBtn)
        
        self.view.insertSubview(self.panaromaView, at: 0)
        
    }


}

extension ViewController {
    
    @objc func buttonClick(button:UIButton ){
        
        //来回切换
        button.isSelected = !button.isSelected
        
        print(button.isSelected)
        
        if button.isSelected {
            
            button.setTitle("触控", for: .normal)
            
            self.panaromaView.controlMethod = .motion
            
        }else{
            
            button.setTitle("感控", for: .normal)
            
            self.panaromaView.controlMethod = .touch
        }
    }
    
}


