//
//  ThirdView.swift
//  UIScrollView案例-轮播器
//
//  Created by 杨帆 on 2019/7/30.
//  Copyright © 2019 ABC. All rights reserved.
//

import UIKit

class ThirdView: UIView {
    
    
    var isShow:Bool = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    
    class func initViewFromNib() -> ThirdView{
        
        let view = Bundle.main.loadNibNamed("ThirdView", owner: self, options: nil)?.last as! ThirdView
        
        //view.setupSubViews()
        
        return view
        
    }
    
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    
    func setupSubViews() {
        
        if isShow {
            
            UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: {
                
                self.topConstraint.constant += 150
                self.bottomConstraint.constant += 150
                self.leftConstraint.constant += 150
                self.rightConstraint.constant += 150
                
                self.layoutIfNeeded()
                
                
            }) { (finished) in
                
                self.isShow = false
                
            }
            
        }
    }
    
}
