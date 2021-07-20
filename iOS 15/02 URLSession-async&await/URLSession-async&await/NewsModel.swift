//
//  NewsModel.swift
//  NewsModel
//
//  Created by 杨帆 on 2021/7/20.
//

import Foundation

struct News: Codable {
    var author, title, department, date, url: String
    var important: Bool
}

struct NewsModel: Codable {
    let result: [News]
}

