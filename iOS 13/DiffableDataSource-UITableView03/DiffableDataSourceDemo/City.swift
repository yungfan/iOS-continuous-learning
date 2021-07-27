//
//  City.swift
//  DiffableDataSourceDemo
//
//  Created by 杨帆 on 2020/5/29.
//  Copyright © 2020 杨帆. All rights reserved.
//

import UIKit

struct City: Hashable {
    var name: String
    let identifier = UUID()

    func contains(query: String?) -> Bool {
        guard let query = query else { return true }
        guard !query.isEmpty else { return true }
        return name.contains(query)
    }
}
