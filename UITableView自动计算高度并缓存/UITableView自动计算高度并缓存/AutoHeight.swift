//
//  AutoHeight.swift
//  UITableView自动计算高度并缓存
//
//  Created by 杨帆 on 2019/8/12.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

protocol AutoHeight : UITableViewDelegate {
    
    //字典:缓存UITableView的高度
    var heightAtIndexPath:[IndexPath : CGFloat] { get set}
    
}


extension AutoHeight where Self:ViewController {
    
    //设置Cell的高度
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let height = self.heightAtIndexPath[indexPath]
        
        if let height = height {
            
            return height
        }
            
        else {
            
            return 100.0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
    //存储高度
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let height = cell.frame.size.height
        
        self.heightAtIndexPath[indexPath] = height
    }
    
}


extension UIViewController : AutoHeight {
    
    var heightAtIndexPath: [IndexPath : CGFloat] {
        get {
            
            return [IndexPath : CGFloat]()
            
        }
        
        set {
            
        }
    }
}
