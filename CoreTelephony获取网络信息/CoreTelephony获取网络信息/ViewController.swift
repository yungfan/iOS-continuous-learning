    //
    //  ViewController.swift
    //  CoreTelephony获取网络信息
    //
    //  Created by 杨帆 on 2019/3/28.
    //  Copyright © 2019 杨帆. All rights reserved.
    //

    import UIKit
    import CoreTelephony

    class ViewController: UIViewController {
        
        var info: String?
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
            
            //获取并输出运营商信息
            let teleInfo = CTTelephonyNetworkInfo()
            
            //iOS12以后 由于双卡iPhone的出现 所以变成了字典
            //获取所有的运营商
            if let carriers = teleInfo.serviceSubscriberCellularProviders {
                
                //获取运营商信息
                for (_, value) in carriers {
                    
                    //查看运营商信息 通过CTCarrier类
                    info = value.carrierName!
                    
                }
                
                //获取网络类型
                let currentRadioTech = teleInfo.serviceCurrentRadioAccessTechnology!

                //判断网络类型
                for (_,value) in currentRadioTech {
                    
                    info = info! + getNetworkType(currentRadioTech:value)
                    
                }
                
                print(info!)
            }
        }
        
        //根据数据业务信息获取对应的网络类型
        func getNetworkType(currentRadioTech:String) -> String {
            
            var networkType = ""
            
            switch currentRadioTech {
                
            case CTRadioAccessTechnologyGPRS:
                networkType = "2G"
            case CTRadioAccessTechnologyEdge:
                networkType = "2G"
            case CTRadioAccessTechnologyWCDMA:
                networkType = "3G"
            case CTRadioAccessTechnologyHSDPA:
                networkType = "3G"
            case CTRadioAccessTechnologyHSUPA:
                networkType = "3G"
            case CTRadioAccessTechnologyCDMA1x:
                networkType = "2G"
            case CTRadioAccessTechnologyCDMAEVDORev0:
                networkType = "3G"
            case CTRadioAccessTechnologyCDMAEVDORevA:
                networkType = "3G"
            case CTRadioAccessTechnologyCDMAEVDORevB:
                networkType = "3G"
            case CTRadioAccessTechnologyeHRPD:
                networkType = "3G"
            case CTRadioAccessTechnologyLTE:
                networkType = "4G"
            default:
                break
            }
            
            return networkType
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    }

