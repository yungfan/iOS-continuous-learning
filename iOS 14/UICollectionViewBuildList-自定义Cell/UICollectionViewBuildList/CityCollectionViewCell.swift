//
//  CityCollectionViewCell.swift
//  UICollectionViewBuildList
//
//  Created by 杨帆 on 2020/7/3.
//

import UIKit

class CityCollectionViewCell: UICollectionViewListCell {
    let width = UIScreen.main.bounds.size.width
    var cityLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        cityLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        cityLabel?.textColor = UIColor.systemRed
        addSubview(cityLabel!)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
