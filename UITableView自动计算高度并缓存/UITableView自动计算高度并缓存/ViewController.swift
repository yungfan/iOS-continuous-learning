//
//  ViewController.swift
//  UITableView自动计算高度并缓存
//
//  Created by 杨帆 on 2019/8/12.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //懒加载数据源
    lazy var dataArray:[ListModel] = {
        
        var dataArray = [ListModel]()
        
        let str = "Siri 让你能够利用语音来完成发送信息、安排会议、查看最新比分等更多事务。只要说出你想做的事，Siri 就能帮你办到。Siri 可以听懂你说的话、知晓你的心意，甚至还能有所回应。iOS 7 中的 Siri 拥有新外观、新声音和新功能。它的界面经过重新设计，以淡入视图浮现于任意屏幕画面的最上层。Siri 回答问题的速度更快，还能查询更多信息源，如维基百科。它可以承担更多任务，如回电话、播放语音邮件、调节屏幕亮度，以及更多。"
        
        for _ in 0...20 {
            
            let model = ListModel()
            
            let startIndex = str.index(str.startIndex, offsetBy: Int.random(in: 10...70))
            
            let endIndex =  str.index(str.endIndex, offsetBy: Int.random(in: -40...0))
            
            let newStr = String(str[startIndex..<endIndex])
            
            model.desc = newStr
            
            dataArray.append(model)
        }
        
        return dataArray
        
        }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }

}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        
        let model = self.dataArray[indexPath.row]
        
        cell.congigUI(model: model)
        
        return cell
        
    }
    
}



