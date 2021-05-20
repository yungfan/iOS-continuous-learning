//
//  City.swift
//  DiffableDataSourceDemo
//
//  Created by 杨帆 on 2020/5/29.
//  Copyright © 2020 杨帆. All rights reserved.
//

import UIKit

struct City: Hashable {
    let name: String
    let identifier = UUID()

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func ==(lhs: City, rhs: City) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    func contains(query: String?) -> Bool {
        guard let query = query else { return true }
        guard !query.isEmpty else { return true }
        return name.contains(query)
    }
}
