//
//  OneTableViewCell.swift
//  面向协议编程二
//
//  Created by 杨帆 on 2019/7/17.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit


//3.UITableViewCell遵守协议，获得了弹性动画的功能
class OneTableViewCell: UITableViewCell, BounceSelect  {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
