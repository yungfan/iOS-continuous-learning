//
//  SearchResultsVC.swift
//  SearchControllerDemo
//
//  Created by Kaibo Lu on 2017/2/14.
//  Copyright © 2017年 Kaibo Lu. All rights reserved.
//

import UIKit

class SearchResultsVC: UITableViewController  {

    // 传过来的
    private var allStrings: [String]
    // 当前表格的数据源
    private var strings: [String] = []
    
    init(allStrings: [String]) {
        self.allStrings = allStrings
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
}

extension SearchResultsVC {

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "abc")
        
        if cell == nil {
            
            cell = UITableViewCell(style: .default, reuseIdentifier: "abc")
        }
        
        cell?.textLabel?.text = strings[indexPath.row]
        
        return cell!
    }
    
}


extension SearchResultsVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        strings.removeAll()
        
        //获取输入的字符
        if let text = searchController.searchBar.text?.uppercased(), !text.isEmpty {
            
            //过滤
            strings = allStrings.filter { $0.contains(text) }
        }
        
        //刷新表格
        tableView.reloadData()
    }
    
}
