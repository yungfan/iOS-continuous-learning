//
//  ViewController.swift
//  XIB表头部
//
//  Created by 杨帆 on 2019/8/22.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tab: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let view: UIView = Bundle.main.loadNibNamed("BillOverduePayConfirmPop", owner: nil, options: nil)!.last as! UIView
        
        view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 160)
        
        self.tab.tableHeaderView = view
    }


}

