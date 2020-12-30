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
    
    public static func bySSID(_ SSID: String, password: String, whenConnected: ((Error?) -> Void)? = nil) {
        manager.save(password, in: SSID)
        manager.findWifiPassword(by: SSID)
        let configuration: NEHotspotConfiguration = .init(ssid: SSID, passphrase: password, isWEP: false)
        NEHotspotConfigurationManager.shared.apply(configuration) { error in
            whenConnected?(error)
        }
    }
}
