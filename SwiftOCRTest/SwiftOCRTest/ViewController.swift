//
//  ViewController.swift
//  SwiftOCRTest
//
//  Created by 杨帆 on 2019/7/12.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit
import SwiftOCR

//1. 修改库的语言版本为Swift 4，官方未更新至Swift最新版
//2. Edit Scheme：Run-Release
//3. 准备官方的一张图
//4. 可以根据字体训练，然后添加进项目，提高准确率（见图）

class ViewController: UIViewController {
    
    private let swiftOCRInstance = SwiftOCR()
    
    @IBAction func recognized(_ sender: Any) {
        
        let img = UIImage(named: "Test")
        
        if let img = img {
            
            self.swiftOCRInstance.recognize(OCRImage(cgImage: img.cgImage!)) { recognizedString in
                
                //回到主线程
                DispatchQueue.main.async {
                    
                    let alert = UIAlertController.init(title: "识别文字", message: recognizedString, preferredStyle: UIAlertControllerStyle.alert)
                    
                    let cancelAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
                        
                    }
                    
                    alert.addAction(cancelAction)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}



