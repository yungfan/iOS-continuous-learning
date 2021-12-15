//
//  iCloudTools.swift
//  CloudKitDemo
//
//  Created by 杨帆 on 2021/12/15.
//

import CloudKit
import Foundation

class CloudKitTools {
    // 容器
    let myContainer = CKContainer(identifier: "iCloud.demo.yf.abc")
    // 数据库
    lazy var database = myContainer.publicCloudDatabase

    // 增加
    func add(person: Person, completionHandler: @escaping () -> Void) {
        let record = CKRecord(recordType: "Person", recordID: person.recordID)
        record.setValue(person.name, forKey: "name")
        record.setValue(person.address, forKey: "address")

        // save保存记录
        database.save(record) { record, error in
            if record != nil, error == nil {
                completionHandler()
            } else {
                print(error.debugDescription)
            }
        }
    }

    // 修改
    func update(person: Person, completionHandler: @escaping () -> Void) {
        database.fetch(withRecordID: person.recordID) { record, error in
            guard let record = record, error == nil else { return }
            // 修改记录
            record.setValue(person.name, forKey: "name")
            record.setValue(person.address, forKey: "address")

            // 保存记录
            self.database.save(record) { record, error in
                if record != nil, error == nil {
                    completionHandler()
                } else {
                    print(error.debugDescription)
                }
            }
        }
    }

    // 删除
    func delete(person: Person, completionHandler: @escaping () -> Void) {
        // 删除记录
        database.delete(withRecordID: person.recordID) { _, error in
            if error == nil {
                completionHandler()
            } else {
                print(error.debugDescription)
            }
        }
    }

    // 查询
    func query(completionHandler: @escaping ([Person]) -> Void) {
        var person = [Person]()
        let query = CKQuery(recordType: "Person", predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: nil) { records, error in
            guard let records = records, error == nil else {
                print(error.debugDescription)
                return
            }

            let sortedRecords = records.sorted {
                $0.creationDate! < $1.creationDate!
            }
            person = sortedRecords.compactMap { record in
                Person(recordID: record.recordID, name: record.value(forKey: "name") as! String, address: record.value(forKey: "address") as! String)
            }

            for p in person {
                print("查询信息：", "name:", p.name, "address:", p.address)
            }

            completionHandler(person)
        }
    }
}
