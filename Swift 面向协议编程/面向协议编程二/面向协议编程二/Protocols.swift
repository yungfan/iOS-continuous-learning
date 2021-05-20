//
//  Protocols.swift
//  面向协议编程一
//
//  Created by 杨帆 on 2019/7/17.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit


//1. 定义协议
protocol BounceSelect {
    func selectWithBounce(select:Bool, animated:Bool)
}

//2. 扩展协议
extension BounceSelect where Self:UIView  {
    
    //被选中时，先缩小到原来的0.7倍，再回弹到原来的大小
    func selectWithBounce(select:Bool, animated:Bool=true){
        
        let bounce = CAKeyframeAnimation(keyPath: "transform")
        
        let origin = CATransform3DIdentity
        let smallest = CATransform3DMakeScale(0.7, 0.7, 1)
        let small = CATransform3DMakeScale(1, 1, 1)
        
        let originValue = NSValue(caTransform3D: origin)
        let smallestValue = NSValue(caTransform3D:smallest)
        let smallValue = NSValue(caTransform3D:small)
        
        if animated {
            bounce.duration = 0.3
            bounce.isRemovedOnCompletion = false
            if select {
                bounce.values = [originValue, smallestValue, smallValue]
                self.layer.add(bounce, forKey: "bounce")
            }
            else{
                bounce.values = [smallestValue, originValue]
                self.layer.add(bounce, forKey: "bounce")
            }
        }
        
        if select {
            self.layer.transform = small
        }
        
        else{
            self.layer.transform = origin
        }
    }
    
}
