//
//  ViewController.swift
//  DeviceInfoTools
//
//  Created by 杨帆 on 2019/4/22.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let info = "设备名称:\(DeviceInfo.yf_getDeviceName())，运行系统:\(DeviceInfo.yf_getDeviceSystemName()) \(DeviceInfo.yf_getDeviceSystemVersion())，CPU类型:\(DeviceInfo.yf_getDeviceCpuType())，核心数:\(DeviceInfo.yf_getDeviceCpuCount())，运营商:\(DeviceInfo.yf_getDeviceSupplier())，当前IP:\(DeviceInfo.yf_getDeviceIP())"
        
        
        let alertController = UIAlertController(title: "当前设备信息",
                                                message: info, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "了解", style: .default, handler:nil)
        alertController.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }


}

