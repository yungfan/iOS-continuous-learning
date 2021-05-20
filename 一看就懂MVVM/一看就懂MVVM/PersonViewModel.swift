//
//  PersonViewModel.swift
//  一看就懂MVVM
//
//  Created by 杨帆 on 2019/5/24.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

// name 和 image 只是简单的通过两个计算属性来接受
// 将时间戳的注册时间转换为字符串的注册时间

//ViewModel 将Model与View结合
class PersonViewModel {
    
    let person: Person
    
    var name: String {
        return person.name
    }
    
    var image: String {
        return person.image
    }
    
    var registerTimeStr: String {
        let date = Date(timeIntervalSince1970: person.registerTimeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    init(_ person: Person) {
        self.person = person
    }
}


extension PersonViewModel {
    
    func configurate(_ personView: PersonView) {
        
        personView.imageView.image = UIImage(named: image)
        personView.nameLabel.text = name
        personView.registerTimeLabel.text = registerTimeStr
    }
}

