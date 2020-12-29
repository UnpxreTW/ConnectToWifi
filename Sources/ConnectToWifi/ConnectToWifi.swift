//
//  ConnectToWifi.swift
//  ConnectToWifi
//
//  Created by UnpxreTW on 2020/12/28.
//  Copyright © 2020 UnpxreTW. All rights reserved.
//
import NetworkExtension

public struct ConnectToWifi {
    
    // MARK: Public Function
    
    public static func bySSID(_ SSID: String, password: String, whenConnected: ((Error?) -> Void)? = nil) {
        // let configuration: NEHotspotConfiguration = .init(ssid: SSID, passphrase: password, isWEP: false)
        let configuration: NEHotspotConfiguration = .init(ssid: SSID)
        NEHotspotConfigurationManager.shared.apply(configuration) { error in
            whenConnected?(error)
        }
    }
}
