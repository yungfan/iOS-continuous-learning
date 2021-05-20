//
//  ViewController.swift
//  一看就懂MVVM
//
//  Created by 杨帆 on 2019/5/24.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let personView = PersonView(frame: CGRect(x: (UIScreen.main.bounds.size.width - 200)/2, y: (UIScreen.main.bounds.size.height - 300)/2, width: 200, height: 300))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupSubViews()
        requestData()
    }
    
    func setupSubViews() {
        view.addSubview(personView)
    }
    
    func requestData() {
        let person = Person(name: "godiscoder", image: "head_default", registerTimeStamp: 1480134638.0)
        let viewModel = PersonViewModel(person)
        viewModel.configurate(personView)
        
    }
}

