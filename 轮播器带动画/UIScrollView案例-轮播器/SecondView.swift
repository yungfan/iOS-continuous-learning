//
//  SecondView.swift
//  UIScrollView案例-轮播器
//
//  Created by 杨帆 on 2019/7/30.
//  Copyright © 2019 ABC. All rights reserved.
//

import UIKit

class SecondView: UIView {
    
    var isShow:Bool = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    
    @IBOutlet weak var someView: UIView!
    
    class func initViewFromNib() -> SecondView{
        
        let view = Bundle.main.loadNibNamed("SecondView", owner: self, options: nil)?.last as! SecondView
        
        //view.setupSubViews()
        
        return view
        
    }
    
    
    func setupSubViews() {
        
        if isShow {
            
            UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: {
                
                
                self.someView.alpha = 1.0
                
                
            }) { (finished) in
                
                self.isShow = false
            }
            
        }
    }
    
}
