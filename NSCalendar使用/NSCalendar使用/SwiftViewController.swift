//
//  SwiftViewController.swift
//  NSCalendar使用
//
//  Created by 杨帆 on 2019/5/29.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func checkTheDate(str:String) -> String {
        
        let format = DateFormatter()
        
        format.dateFormat = "yyyy-MM-dd"
        
        let date = format.date(from: str)
        
        let isToday = Calendar.current.isDateInToday(date!) //判断一个日期是否是今天
        
        let isYesterday = Calendar.current.isDateInToday(date!) //判断一个日期是否是昨天
        
        let isTomorrow = Calendar.current.isDateInTomorrow(date!) //判断一个日期是否是明天
        
        let isWeekend = Calendar.current.isDateInWeekend(date!) //判断一个日期是否是属于周末双休日
        
        let isSameDay = Calendar.current.isDate(date!, inSameDayAs: Date()) //判断一个日期和另外一个是否相等
        
        var strDiff:String = ""
        
        if isToday {
            
            strDiff = "今天"
        }
        return strDiff
    }

}
