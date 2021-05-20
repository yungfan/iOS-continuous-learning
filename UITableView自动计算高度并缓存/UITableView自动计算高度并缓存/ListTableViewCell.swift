//
//  ListTableViewCell.swift
//  UITableView自动计算高度并缓存
//
//  Created by 杨帆 on 2019/8/12.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var info: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func congigUI(model: ListModel) {
        
        self.imgView.image = UIImage(named: "panda")
        
        self.info.text = model.desc
    }

}
