//
//  AppTrackingPermission.swift
//  AppTrackingTransparency
//
//  Created by 杨帆 on 2021/5/31.
//

import AdSupport
import AppTrackingTransparency

enum AppTrackingPermissionError: Error {
    case denied
    case notDetermined
    case restricted
}

class AppTrackingPermission {
    // 请求授权
    func requestAppTrackingPermission(completion: @escaping (Bool, AppTrackingPermissionError?) -> Void) {
        ATTrackingManager.requestTrackingAuthorization { trackingAuthorizationStatus in
            switch trackingAuthorizationStatus {
            case .authorized:
                print(trackingAuthorizationStatus)
                completion(true, nil)
            case .denied:
                print(trackingAuthorizationStatus)
                completion(false, .denied)
            case .notDetermined:
                print(trackingAuthorizationStatus)
                completion(false, .notDetermined)
            case .restricted:
                print(trackingAuthorizationStatus)
                completion(false, .restricted)
            @unknown default:
                break
            }
        }
    }

    // 获取IDFA
    func getIDFA(completion: (AppTrackingPermissionError?, String?) -> Void) {
        if #available(iOS 14, *) {
            if ATTrackingManager.trackingAuthorizationStatus != ATTrackingManager.AuthorizationStatus.authorized {
                completion(AppTrackingPermissionError.denied, nil)
                return
            }
        } else {
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled == false {
                completion(AppTrackingPermissionError.denied, nil)
                return
            }
        }
        completion(nil, ASIdentifierManager.shared().advertisingIdentifier.uuidString)
    }
}
