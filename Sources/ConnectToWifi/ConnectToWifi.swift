//
//  ConnectToWifi.swift
//  ConnectToWifi
//
//  Created by UnpxreTW on 2020/12/28.
//  Copyright © 2020 UnpxreTW. All rights reserved.
//
import NetworkExtension

public struct ConnectToWifi {
    
    public static var manager: WifiManager = .shared
    
    // MARK: Public Function
    
    public static func bySSID(
        _ SSID: String,
        password: String? = nil,
        whenConnected handler: ((String, Error?) -> Void)? = nil
    ) -> ConnectToWifiError? {
        if let password = password {
            bySSID(SSID, password: password, whenConnected: handler)
        } else if let password = manager.findWifiPassword(by: SSID) {
            bySSID(SSID, password: password, whenConnected: handler)
        } else {
            return .missPassword
        }
        return nil
    }
    
    public static func bySSID(
        _ SSID: String,
        whenNotFindPassword getPasswordByUser: (() -> String),
        whenConnected: ((Error?) -> Void)? = nil
    ) {
        var findedPassword: String? = manager.findWifiPassword(by: SSID)
        if findedPassword == nil { findedPassword = getPasswordByUser() }
        guard let password = findedPassword else { return }
        bySSID(SSID, password: password)
    }
    
    public static func bySSID(_ SSID: String, password: String, whenConnected: ((String, Error?) -> Void)? = nil) {
        let configuration: NEHotspotConfiguration = .init(ssid: SSID, passphrase: password, isWEP: false)
        NEHotspotConfigurationManager.shared.apply(configuration) { error in
            whenConnected?(SSID, error)
        }
    }
}
