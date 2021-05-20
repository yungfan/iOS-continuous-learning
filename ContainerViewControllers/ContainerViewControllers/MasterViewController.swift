//
//  ViewController.swift
//  ContainerViewControllers
//
//  Created by 杨帆 on 2019/4/20.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // 第一个子控制器
    private lazy var weatherViewController: WeatherViewController = {

        var viewController = WeatherViewController()

        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    
    // 第二个子控制器
    private lazy var expressViewController: ExpressViewController = {
        

        var viewController = ExpressViewController()

        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
         setupView()
    }


    private func setupView() {
        
        setupSegmentedControl()
        
        updateView()
    }
    
    private func setupSegmentedControl() {
       
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "天气", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "快递", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        
        // 选中第1个菜单
        segmentedControl.selectedSegmentIndex = 0
    }
    
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        
        updateView()
    }
    
    private func updateView() {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            
            remove(asChildViewController: expressViewController)
            
            add(asChildViewController: weatherViewController)
            
        } else {
            
            remove(asChildViewController: weatherViewController)
            
            add(asChildViewController: expressViewController)
        }
    }
    
    
    private func remove(asChildViewController viewController: UIViewController) {
        // 通知子控制器
        viewController.willMove(toParent: nil)
        
        // 移除
        viewController.view.removeFromSuperview()
        
        // 通知子控制器
        viewController.removeFromParent()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        // 添加子控制器
        addChild(viewController)
        
        // 将子控制器的view添加到当前控制器中去
        view.addSubview(viewController.view)
        
        // 配置view
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 通知子控制器
        viewController.didMove(toParent: self)
    }
}

