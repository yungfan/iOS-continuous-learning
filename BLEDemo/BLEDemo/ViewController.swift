//
//  ViewController.swift
//  BLEDemo
//
//  Created by student on 2019/3/7.
//  Copyright © 2019 abc. All rights reserved.
//

import UIKit
import CoreBluetooth

/**
 中心管理模式
 1.引入CoreBluetooth,初始化中心管理者
 2.监听CBCentralManager的状态,当是On的时候,才可以进行搜索外设
 3.当状态为On的时候,开始搜索我们的外设
 4.发现外设后,过滤出我们要的外设,并且对其进行标记或者存储到外设数组中(每个中心管理者都可以连接1-7个外设,但是每个外设都只能连接一个CBCentralManager)
 */

class ViewController: UIViewController {
    
    // 中心管理者
    var centralManager :CBCentralManager!
    // 外设
    var peripheral: CBPeripheral?
    // 外设数组
    var peripherals: [CBPeripheral]!
    // 表格展示所有可连接设备
    var tabView : UITableView!
    
    // 断开链接
    @IBAction func disConnect(_ sender: Any) {
        
        self.centralManager.cancelPeripheralConnection(self.peripheral!)
        
        self.title = "已断开" + (self.peripheral!.name)!
        
        self.peripheral = nil
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.peripherals = []
        
        tabView = UITableView(frame: self.view.frame)
        
        tabView.dataSource = self
        
        tabView.delegate = self
        
        self.view.addSubview(self.tabView)
        
        // 初始化中心管理者
        self.centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main, options: nil)
    }
}

// MARK:- UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return  self.peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "ble")
        
        if cell == nil {
            
            cell = UITableViewCell(style: .default, reuseIdentifier: "ble")
            
        }
        
        // 展示所有可连接的设备
        cell?.textLabel?.text = self.peripherals[indexPath.row].name
        
        return cell!
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.title =  "已连上" + (self.peripherals[indexPath.row].name)!
        
        // 连接想要的外设
        let selPeripheral = self.peripherals[indexPath.row]
        
        self.peripheral = selPeripheral
        
        //调用connect就会回调代理中连接外设结果的方法
        self.centralManager.connect(self.peripheral!, options: nil)
    }
    
}


// MARK:- CBCentralManagerDelegate
extension ViewController: CBCentralManagerDelegate
{
    // 监听CBCentralManager的状态
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        // 蓝牙打开的时候进行扫描
        if central.state == .poweredOn {
            // 传入nil，那么就是扫描所有可以发现的设备
            central.scanForPeripherals(withServices: nil, options: nil)
        }
        
    }
    
    
     // 搜索后发现外设就会回调该方法
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if !self.peripherals.contains(peripheral) {
            
            self.peripherals?.append(peripheral)
            // 刷新表格
            self.tabView.reloadData()
        }
    }
    
    
    // 连接外设的结果
    // 1 连接成功
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        print("didConnectPeripheral")
        
        peripheral.delegate = self
        // 发现服务
        peripheral.discoverServices(nil)
    }
    
    // 2 连接失败
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        
        print("didFailToConnectPeripheral")
    }
    
    // 3 丢失连接
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        //
        print("didDisconnectPeripheral")
    }
    
}

extension ViewController: CBPeripheralDelegate
{
    // 外设发现服务
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard error == nil else
        {
            print("didDiscoverServices : \(String(describing: error))")
            return
        }
        
        for service in peripheral.services! {
            // 外设检索服务中的每一个特征 peripheral:didDiscoverCharacteristicsForService
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    // 外设发现服务中的特征
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard error == nil else
        {
            print("didDiscoverCharacteristicsForService : \(String(describing: error))")
            return
        }
        
        for character in service.characteristics! {
            // 外设检索特征的描述  peripheral:didDiscoverDescriptorsForCharacteristic:error:
            peripheral.discoverDescriptors(for: character)
            
            // 外设读取特征的值
            guard character.properties.contains(.read) else
            {
                print("character.properties must contains read")
                // 如果是只读的特征,那就跳过本条进行下一个遍历
                continue
            }
            // 会调用 peripheral:didUpdateValueForCharacteristic:error:
            peripheral.readValue(for: character)
        }
    }
    
    // 外设发现了特征中的描述
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        //
        guard error == nil else
        {
            print("didDiscoverDescriptorsForCharacteristic : \(String(describing: error))")
            return
        }
        
        for des in characteristic.descriptors! {
            print("characteristic: \(characteristic) .des  :\(des)")
            // 会调用  peripheral:didUpdateValueForDescriptor:error:
            peripheral.readValue(for: des)
            // 订阅 会调用 peripheral:didUpdateNotificationStateFor:error:
            //peripheral.setNotifyValue(true, for: des)
        }
    }
    
    // 更新特征value
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard error == nil else
        {
            print("didUpdateValueForCharacteristic : \(String(describing: error))")
            return
        }
        
        print("\(characteristic.description) didUpdateValueForCharacteristic")
    }
    
    // 订阅特征值
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        
        guard error == nil else
        {
            print("didUpdateNotificationStateFor : \(String(describing: error))")
            return
        }
        
        print("\(characteristic.description) didUpdateNotificationStateFor")
    }
    
    
    
    // 更新描述value
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        
        guard error == nil else
        {
            print("didUpdateValueForDescriptor : \(String(describing: error))")
            return
        }
        
        print("\(descriptor.description) didUpdateValueForDescriptor")
        
    }
    
    
}

