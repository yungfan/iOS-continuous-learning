//
//  ViewController.swift
//  AA
//
//  Created by 杨帆 on 2019/4/22.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit
import CoreTelephony

public class DeviceInfo: NSObject {
    
    ///获取系统版本
    public class func yf_getDeviceSystemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    ///获取系统名称
    public class func yf_getDeviceSystemName() -> String {
        return UIDevice.current.systemName
    }
    
    ///获取系统名称 iPhone", "iPod touch"
    public class func yf_getDeviceModel() -> String {
        return UIDevice.current.model
    }
    
    ///获取系统名称 localized version of model
    public class func yf_getDeviceLocalizedModel() -> String {
        return UIDevice.current.localizedModel
    }
    
    ///获取设备名称 如 XXX的iphone
    public class func yf_getDeviceUserName() -> String {
        return UIDevice.current.name
    }
    ///获取总的内存
    public class func yf_getDeviceDiskTotalSize() -> String {
        return fileSizeToString(fileSize: yf_getTotalDiskSize())
    }
    
    ///获取可用的内存
    public class func yf_getDeviceAvalibleDiskSize() -> String {
        return fileSizeToString(fileSize: yf_getAvailableDiskSize())
    }
    
    ///获取运营商
    public class func yf_getDeviceSupplier() -> String {
        return yf_deviceSupplier()
    }
    
    /// 获取当前设备IP
    public class func yf_getDeviceIP() -> String {
        return yf_deviceIP()
    }
    
    ///获取cpu核数类型
    public class func yf_getDeviceCpuCount() -> Int {
        return yf_deviceCpuCount()
    }
    
    ///获取cpu类型
    public class func yf_getDeviceCpuType() -> String {
        return yf_deviceCpuType()
    }
    
    ///获取设备名称
    public class func yf_getDeviceName() -> String {
        return yf_deviceName()
    }
}


///private
extension DeviceInfo {
    ///获取运营商
    private class func yf_deviceSupplier() -> String {
        let info = CTTelephonyNetworkInfo()
        var supplier:String = ""
        if #available(iOS 12.0, *) {
            if let carriers = info.serviceSubscriberCellularProviders {
                if carriers.keys.count == 0 {
                    return "无Sim卡"
                } else { //获取运营商信息
                    for (index, carrier) in carriers.values.enumerated() {
                        guard carrier.carrierName != nil else { return "无Sim卡" }
                        //查看运营商信息 通过CTCarrier类
                        if index == 0 {
                            supplier = carrier.carrierName!
                        } else {
                            supplier = supplier + "," + carrier.carrierName!
                        }
                    }
                    return supplier
                }
            } else{
                return "无Sim卡"
            }
        } else {
            if let carrier = info.subscriberCellularProvider {
                guard carrier.carrierName != nil else { return "无Sim卡" }
                return carrier.carrierName!
            } else{
                return "无Sim卡"
            }
        }
    }
    
    /// 获取当前设备IP
    private class func yf_deviceIP() -> String {
        var addresses = [String]()
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while (ptr != nil) {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String(validatingUTF8:hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        if let ipStr = addresses.first {
            return ipStr
        } else {
            return ""
        }
    }
    
    ///获取cpu核数类型
    private class func yf_deviceCpuCount() -> Int {
        var ncpu: UInt = UInt(0)
        var len: size_t = MemoryLayout.size(ofValue: ncpu)
        sysctlbyname("hw.ncpu", &ncpu, &len, nil, 0)
        return Int(ncpu)
    }
    
    ///获取cpu类型
    private class func yf_deviceCpuType() -> String {
        
        let HOST_BASIC_INFO_COUNT = MemoryLayout<host_basic_info>.stride/MemoryLayout<integer_t>.stride
        var size = mach_msg_type_number_t(HOST_BASIC_INFO_COUNT)
        var hostInfo = host_basic_info()
        let result = withUnsafeMutablePointer(to: &hostInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity:Int(size)){
                host_info(mach_host_self(), Int32(HOST_BASIC_INFO), $0, &size)
            }
        }
        print(result, hostInfo)
        switch hostInfo.cpu_type {
        case CPU_TYPE_ARM:
            return "CPU_TYPE_ARM"
        case CPU_TYPE_ARM64:
            return "CPU_TYPE_ARM64"
        case CPU_TYPE_ARM64_32:
            return"CPU_TYPE_ARM64_32"
        case CPU_TYPE_X86:
            return "CPU_TYPE_X86"
        case CPU_TYPE_X86_64:
            return"CPU_TYPE_X86_64"
        case CPU_TYPE_ANY:
            return"CPU_TYPE_ANY"
        case CPU_TYPE_VAX:
            return"CPU_TYPE_VAX"
        case CPU_TYPE_MC680x0:
            return"CPU_TYPE_MC680x0"
        case CPU_TYPE_I386:
            return"CPU_TYPE_I386"
        case CPU_TYPE_MC98000:
            return"CPU_TYPE_MC98000"
        case CPU_TYPE_HPPA:
            return"CPU_TYPE_HPPA"
        case CPU_TYPE_MC88000:
            return"CPU_TYPE_MC88000"
        case CPU_TYPE_SPARC:
            return"CPU_TYPE_SPARC"
        case CPU_TYPE_I860:
            return"CPU_TYPE_I860"
        case CPU_TYPE_POWERPC:
            return"CPU_TYPE_POWERPC"
        case CPU_TYPE_POWERPC64:
            return"CPU_TYPE_POWERPC64"
        default:
            return ""
        }
    }
    
    
    ///获取设备名称
    private class func yf_deviceName() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
         
        ///iPod
        case "iPod1,1":                             return "iPod Touch 1G"
        case "iPod2,1":                             return "iPod Touch 2G"
        case "iPod3,1":                             return "iPod Touch 3G"
        case "iPod4,1":                             return "iPod Touch 4G"
        case "iPod5,1":                             return "iPod Touch (5 Gen)"
        case "iPod7,1":                             return "iPod touch 6G"
            
        ///iPhone
        case "iPhone1,1":                           return "iPhone 1G"
        case "iPhone1,2":                           return "iPhone 3G"
        case "iPhone2,1":                           return "iPhone 3GS"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": return "iPhone 4"
        case "iPhone4,1":                           return "iPhone 4S"
        case "iPhone5,1", "iPhone5,2":              return "iPhone 5"
        case "iPhone5,3","iPhone5,4":               return "iPhone 5C"
        case "iPhone6,1", "iPhone6,2":              return "iPhone 5S"
        case "iPhone7,1":                           return "iPhone 6 Plus"
        case "iPhone7,2":                           return "iPhone 6"
        case "iPhone8,1":                           return "iPhone 6S"
        case "iPhone8,2":                           return "iPhone 6S Plus"
        case "iPhone8,4":                           return "iPhone SE"
        case "iPhone9,1","iPhone9,3":               return "iPhone 7"
        case "iPhone9,2","iPhone9,4":               return "iPhone 7 Plus"
        case "iPhone10,1","iPhone10,4":             return "iPhone 8"
        case "iPhone10,2","iPhone10,5":             return "iPhone 8 Plus"
        case "iPhone10,3","iPhone10,6":             return "iPhone X"
        case "iPhone11,8":                          return "iPhone XR"
        case "iPhone11,2":                          return "iPhone XS"
        case "iPhone11,6":                          return "iPhone XS Max"
            
        ///iPad
        case "iPad1,1":                             return "iPad"
        case "iPad1,2":                             return "iPad 3G"
        case "iPad2,1":                             return "iPad 2 (WiFi)"
        case "iPad2,2":                             return "iPad 2"
        case "iPad2,3":                             return "iPad 2 (CDMA)"
        case "iPad2,4":                             return "iPad 2"
        case "iPad2,5":                             return "iPad Mini (WiFi)"
        case "iPad2,6":                             return "iPad Mini"
        case "iPad2,7":                             return "iPad Mini (GSM+CDMA)"
        case "iPad3,1":                             return "iPad 3 (WiFi)"
        case "iPad3,2":                             return "iPad 3 (GSM+CDMA)"
        case "iPad3,3":                             return "iPad 3"
        case "iPad3,4":                             return "iPad 4 (WiFi)"
        case "iPad3,5":                             return "iPad 4"
        case "iPad3,6":                             return "iPad 4 (GSM+CDMA)"
        case "iPad4,1":                             return "iPad Air (WiFi)"
        case "iPad4,2":                             return "iPad Air (Cellular)"
        case "iPad4,4":                             return "iPad Mini 2 (WiFi)"
        case "iPad4,5":                             return "iPad Mini 2 (Cellular)"
        case "iPad4,6":                             return "iPad Mini 2"
        case "iPad4,7":                             return "iPad Mini 3"
        case "iPad4,8":                             return "iPad Mini 3"
        case "iPad4,9":                             return "iPad Mini 3"
        case "iPad5,1":                             return "iPad Mini 4 (WiFi)"
        case "iPad5,2":                             return "iPad Mini 4 (LTE)"
        case "iPad5,3":                             return "iPad Air 2"
        case "iPad5,4":                             return "iPad Air 2"
        case "iPad6,3":                             return "iPad Pro 9.7"
        case "iPad6,4":                             return "iPad Pro 9.7"
        case "iPad6,7":                             return "iPad Pro 12.9"
        case "iPad6,8":                             return "iPad Pro 12.9"
        case "iPad6,11":                            return "iPad 5 (WiFi)"
        case "iPad6,12":                            return "iPad 5 (Cellular)"
        case "iPad7,1":                             return "iPad Pro 12.9 inch 2nd gen (WiFi)"
        case "iPad7,2":                             return "iPad Pro 12.9 inch 2nd gen (Cellular)"
        case "iPad7,3":                             return "iPad Pro 10.5 inch (WiFi)"
        case "iPad7,4":                             return "iPad Pro 10.5 inch (Cellular)"
        case "iPad7,5","iPad7,6":                   return "iPad (6th generation)"
        case "iPad8,1","iPad8,2","iPad8,3","iPad8,4":  return "iPad Pro (11-inch)"
        case "iPad8,5","iPad8,6","iPad8,7","iPad8,8":  return "iPad Pro (12.9-inch) (3rd generation)"
            
        //Apple Watch
        case "Watch1,1","Watch1,2":                 return "Apple Watch (1st generation)"
        case "Watch2,6","Watch2,7":                 return "Apple Watch Series 1"
        case "Watch2,3","Watch2,4":                 return "Apple Watch Series 2"
        case "Watch4,1","Watch4,2","Watch4,3","Watch4,4":    return "Apple Watch Series 3"
        case "Watch3,1","Watch3,2","Watch3,3","Watch3,4":    return "Apple Watch Series 4"
            
            
        ///AppleTV
        case "AppleTV2,1":                          return "Apple TV 2"
        case "AppleTV3,1":                          return "Apple TV 3"
        case "AppleTV3,2":                          return "Apple TV 3"
        case "AppleTV5,3":                          return "Apple TV 4"
        case "AppleTV6,2":                          return "Apple TV 4K"
            
        ///AirPods
        case "AirPods1,1":                          return "AirPods"
            
        ///Simulator
        case "i386":                                return "Simulator"
        case "x86_64":                              return "Simulator"
            
        default:                                    return "unknow"
        }
    }
    
    private class func blankof<T>(type:T.Type) -> T {
        let ptr = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T>.size)
        let val = ptr.pointee
        return val
    }
    
    /// 磁盘总大小
    private class func yf_getTotalDiskSize() -> Int64 {
        var fs = blankof(type: statfs.self)
        if statfs("/var",&fs) >= 0{
            return Int64(UInt64(fs.f_bsize) * fs.f_blocks)
        }
        return -1
    }
    
    /// 磁盘可用大小
    private class func yf_getAvailableDiskSize() -> Int64 {
        var fs = blankof(type: statfs.self)
        if statfs("/var",&fs) >= 0{
            return Int64(UInt64(fs.f_bsize) * fs.f_bavail)
        }
        return -1
    }
    
    /// 将大小转换成字符串用以显示
    private class func fileSizeToString(fileSize:Int64) -> String {
        
        let fileSize1 = CGFloat(fileSize)
        
        let KB:CGFloat = 1024
        let MB:CGFloat = KB*KB
        let GB:CGFloat = MB*KB
        
        if fileSize < 10 {
            return "0 B"
            
        } else if fileSize1 < KB {
            return "< 1 KB"
        } else if fileSize1 < MB {
            return String(format: "%.1f KB", CGFloat(fileSize1)/KB)
        } else if fileSize1 < GB {
            return String(format: "%.1f MB", CGFloat(fileSize1)/MB)
        } else {
            return String(format: "%.1f GB", CGFloat(fileSize1)/GB)
        }
    }
}
