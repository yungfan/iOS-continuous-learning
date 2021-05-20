//
//  ViewController.swift
//  面向协议编程二
//
//  Created by 杨帆 on 2019/7/17.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "abc") as! OneTableViewCell
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    //点击时获得弹性动画
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OneTableViewCell
        
        //去掉默认的点击效果
        cell.selectionStyle = .none
        
        cell.selectWithBounce(select: true)
        
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "cba", for: indexPath) as! TwoCollectionViewCell
        
        return item
    }
}

extension ViewController: UICollectionViewDelegate {
    
     //点击时获得弹性动画
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = collectionView.cellForItem(at: indexPath) as! TwoCollectionViewCell
        
        item.selectWithBounce(select: true)
    }
}
