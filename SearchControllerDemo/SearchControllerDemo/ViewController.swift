//
//  ViewController.swift
//  SearchControllerDemo
//
//  Created by Kaibo Lu on 2017/2/14.
//  Copyright © 2017年 Kaibo Lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var searchController: UISearchController!
    
    
    private let allStrings: [String] = ["ABC", "BCD", "CDE", "DEF", "EFG", "FGH", "GHI"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "搜索"
        
        //1.创建表格
        let tableView = UITableView(frame: CGRect(x: 0, y: 140, width: view.bounds.size.width, height: view.bounds.size.height))
        tableView.dataSource = self
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Present", style: .plain, target: self, action: #selector(showSearchController))
        
        //创建UISearchController
        let searchResultsVC = SearchResultsVC(allStrings: allStrings)
        searchController = UISearchController(searchResultsController: searchResultsVC)
        searchController.searchResultsUpdater = searchResultsVC;
        
        if #available(iOS 11.0, *) {
            
            self.navigationItem.searchController = searchController
           

            
        }else {
            
            tableView.tableHeaderView = searchController.searchBar;
            
        }
        
        tableView.tableFooterView = UIView()
        
        definesPresentationContext = true;
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //如果不设置 一开始没有显示呀 为何列表拖动才出现
        if #available(iOS 11.0, *) {
            self.navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    // 点击进入搜索控制器时，自动弹出键盘，让搜索框进入编辑状态
    @objc func showSearchController() {

        searchController.searchBar.becomeFirstResponder()
        
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStrings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = allStrings[indexPath.row]
        return cell
    }
    
}

