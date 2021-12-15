//
//  ViewController.swift
//  CloudKitDemo
//
//  Created by student on 2021/12/15.
//

import CloudKit
import UIKit

// 记录ID
let recordID = CKRecord.ID(recordName: UUID().uuidString)
// 记录
let record = CKRecord(recordType: "Contact", recordID: recordID)
// 容器
let myContainer = CKContainer(identifier: "iCloud.demo.yf.abc")
// 数据库
let publicDatabase = myContainer.publicCloudDatabase

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }

    @IBAction func create(_ sender: Any) {
        // 添加数据
        record["job"] = "iOS开发"
        record["name"] = "张三"
        record["address"] = "江苏南京"
        // 将记录保存在数据库
        publicDatabase.save(record) { _, error in
            if error != nil {
                print("create failure！", error.debugDescription)
            } else {
                print("create success！")
            }
        }
    }

    @IBAction func query(_ sender: Any) {
        let query = CKQuery(recordType: "Contact", predicate: NSPredicate(value: true))

        publicDatabase.perform(query, inZoneWith: nil) { records, error in
            guard let records = records, error == nil else {
                print("query failure！", error.debugDescription)
                return
            }

            print("query success！")

            for record in records {
                let job = record["job"]
                let names = record["name"]
                let address = record["address"]

                print("查询信息：", "job:", job, "names:", names, "address:", address)
            }
        }
    }

    @IBAction func fetch(_ sender: Any) {
        // 在代码中获取我们保存好的内容
        publicDatabase.fetch(withRecordID: recordID) { record, error in
            if error != nil {
                print("fetch failure！", error.debugDescription)
            } else {
                print("fetch success！")
                let job = record!["job"]
                let names = record!["name"]
                let address = record!["address"]

                print("查询单个信息：", "job:", job, "names:", names, "address:", address)
            }
        }
    }

    @IBAction func update(_ sender: Any) {
        // 修改数据
        record["name"] = "李四"
        record["job"] = "Android开发"
        record["address"] = "浙江杭州"
        publicDatabase.save(record) { _, error in
            if error != nil {
                print("update failure！", error.debugDescription)
            } else {
                print("update success！")
            }
        }
    }

    @IBAction func del(_ sender: Any) {
        publicDatabase.delete(withRecordID: recordID) { _, error in
            if error != nil {
                print("delete failure！", error.debugDescription)
            } else {
                print("delete success！")
            }
        }
    }
}
