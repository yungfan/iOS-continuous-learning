//
//  YFTabBar.swift
//  YFTabBarController
//
//  Created by yangfan on 2018/3/15.
//  Copyright © 2018年 yangfan. All rights reserved.
//

import UIKit

let SafeAreaBottomHeight = CGFloat(34.0)

class YFTabBar: UITabBar {
    
    var vcCount:Int?
    
    lazy var centerBtn:UIButton = {
        
        var btn = UIButton(type: UIButtonType.custom)
        
        btn.setImage(UIImage(named:"plus_Last"), for:UIControlState.normal)
        
        btn.sizeToFit();
   
        return btn
        
    }()
    
//    init 规则
//
//    定义 init 方法必须遵循三条规则
//
//    指定构造器必须调用它直接父类的指定构造器方法.
//    便利构造器必须调用同一个类中定义的其它初始化方法.
//    便利构造器在最后必须调用一个指定构造器.
    
    override init(frame: CGRect){
        
        super.init(frame: frame)
        addSubview(centerBtn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YFTabBar{
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let w = bounds.size.width
        
        let h = UIDevice().isX() ? bounds.size.height-SafeAreaBottomHeight:bounds.size.height;
    
        centerBtn.center = CGPoint(x: w*0.5, y: h*0.3)
        
        let width = w / CGFloat(vcCount! + 1)
        
        var index = 0
        
        for subView in subviews {
            
            if subView.isKind(of: NSClassFromString("UITabBarButton")!){
                
                subView.frame = CGRect(x: width * CGFloat(index), y: bounds.origin.y, width: width, height: h)
                
                print(subView.frame)
                
                index = index + 1
                
                if (index == vcCount! / 2) {
                    
                    index = index + 1
                }
                
            }
        }
        
        bringSubview(toFront: centerBtn)
        
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if isHidden == false {
            
            let point = convert(point, to: centerBtn)
         
            if centerBtn.point(inside: point, with: event){
                
                return centerBtn
            }
        
        }
        
        return super.hitTest(point, with: event)
    }
    
}

extension UIDevice {
    
    public func isX() -> Bool {
        
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        
        return false
    }
}

