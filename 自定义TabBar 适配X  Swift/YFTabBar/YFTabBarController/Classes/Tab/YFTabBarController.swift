//
//  YFTabBarController.swift
//  YFTabBarController
//
//  Created by yangfan on 2018/3/15.
//  Copyright © 2018年 yangfan. All rights reserved.
//

import UIKit

class YFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addChildViewController(childController: OneViewController(), title: "首页", imageName: "tab1-heartshow", selectedImageName: "tab1-heart")
        
        addChildViewController(childController: TwoViewController(), title: "活动", imageName: "tab2-doctor", selectedImageName: "tab2-doctorshow")
        
        addChildViewController(childController: ThreeViewController(), title: "设置", imageName: "tab4-more", selectedImageName: "tab4-moreshow")
        
        addChildViewController(childController: FourViewController(), title: "更多", imageName: "tab5-file", selectedImageName: "tab5-fileshow")
        
        let tabBar = YFTabBar()
        
        tabBar.vcCount = viewControllers?.count
        
        tabBar.centerBtn.addTarget(self, action: #selector(centerBtnClick), for: UIControlEvents.touchUpInside)
        
        UITabBar.appearance().backgroundImage = imageWithColor(color: UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.0))

        UITabBar.appearance().shadowImage = UIImage()
        
        setValue(tabBar, forKey: "tabBar")
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension YFTabBarController{
    
    func addChildViewController(childController: UIViewController, title:String, imageName:String, selectedImageName:String) {
        
        childController.title = title
        
        childController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
    childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.darkGray], for: UIControlState.selected)
        
        
        addChildViewController(YFNavigationController(rootViewController: childController))
        
  
    }
    
    @objc func centerBtnClick(){
        
        present(CenterViewController(), animated: true, completion: nil)
        
    }
    
    func imageWithColor(color:UIColor) -> UIImage? {
        // 一个像素
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        // 开启上下文
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return image
    }
    
    
}
