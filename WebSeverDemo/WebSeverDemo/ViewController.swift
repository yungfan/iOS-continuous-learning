//
//  ViewController.swift
//  WebSeverDemo
//
//  Created by 杨帆 on 2020/12/24.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // 创建request
            let request = URLRequest(url: (self.appDelegate.webServer?.serverURL)!)
            // 添加wkwebview
            let wkwebview = WKWebView(frame: UIScreen.main.bounds)
            // 加载网页
            wkwebview.load(request)
            self.view.addSubview(wkwebview)
        }
    }
}
