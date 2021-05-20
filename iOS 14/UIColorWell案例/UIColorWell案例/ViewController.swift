//
//  ViewController.swift
//  UIColorWell案例
//
//  Created by 杨帆 on 2020/7/6.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let colorWell = UIColorWell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        colorWell.center = view.center
    
        colorWell.addTarget(self, action:#selector(colorWellChanged(sender:)), for: .valueChanged)
        
        view.addSubview(colorWell)
    }


    @objc func colorWellChanged(sender: UIColorWell) {
        view.backgroundColor = sender.selectedColor
    }
}

