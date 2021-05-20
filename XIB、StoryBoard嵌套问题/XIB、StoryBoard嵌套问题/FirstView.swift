//
//  FirstView.swift
//  面向协议编程一
//
//  Created by 杨帆 on 2019/7/17.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit


class FirstView: UIView {

    @IBOutlet var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }
    
    private func initViewFromNib(){
        
        //self.view = UINib(nibName: "FirstView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView
        //或者
        
        self.view = Bundle.main.loadNibNamed("FirstView", owner: self, options: nil)?.first as? UIView
        self.view.frame = bounds
        self.addSubview(view)
    
    }
}
