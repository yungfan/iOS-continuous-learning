//
//  FirstView.swift
//  UIScrollView案例-轮播器
//
//  Created by 杨帆 on 2019/7/30.
//  Copyright © 2019 ABC. All rights reserved.
//

import UIKit

class FirstView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
     
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    
    class func initViewFromNib() -> FirstView{
        
        let view = Bundle.main.loadNibNamed("FirstView", owner: self, options: nil)?.last as! FirstView
    
        view.setupSubViews()
        
        return view
        
    }
    
    //布局界面
    @IBOutlet weak var leftVIewBottomConstraint: NSLayoutConstraint!
    
    func setupSubViews() {
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: {
            
            self.leftVIewBottomConstraint.constant = 20
            
            self.layoutIfNeeded()
            
            
        }) { (finished) in
            
            
        }
        
    }
    
}
