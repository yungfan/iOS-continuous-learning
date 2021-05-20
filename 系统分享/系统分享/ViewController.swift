//
//  ViewController.swift
//  系统分享
//
//  Created by 杨帆 on 2019/8/30.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
        // 初始化activityItems参数
        let shareText = "商贸新闻"
        let shareImage = UIImage(named: "img.png")
        let sharedURL = URL(string: "https://www.abc.edu.cn")
        
        // 分享的内容 图片不是所有平台都有用 很多平台都是用URL网址里面的图片，如QQ
        let items = [shareText, shareImage!, sharedURL!] as [Any]
        
        // activityItems：分享的内容，包括图片、图片、网址。
        let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        // 设置不出现的分享选项，可以只保留常用的
        vc.excludedActivityTypes = [.assignToContact, .message, .mail]
        
        // 分享回调
        // activityType为被点击的服务类型；completed标识服务是否执行成功；returnedItems是一个包含ExtensionItem对象的数组；activityError指出出错原因。
        vc.completionWithItemsHandler = {  activityType, completed, returnedItems, activityError in
            
            if completed {
                
                print("分享成功")
            }
            
            else {
                
                print("分享失败")
            }
            
            vc.dismiss(animated: true, completion: nil)
        }
        
        self.present(vc, animated: true, completion: nil)
      
    }

}

