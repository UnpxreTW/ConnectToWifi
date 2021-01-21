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
        saveToKeychain: Bool = true,
        whenConnected handler: ((NEHotspotConfigurationError?) -> Void)? = nil
    ) -> ConnectToWifiError? {
        if let password = password {
            bySSID(SSID, password: password, saveToKeychain: saveToKeychain, whenConnected: handler)
        } else if let password = manager.findWifiPassword(by: SSID) {
            bySSID(SSID, password: password, saveToKeychain: saveToKeychain, whenConnected: handler)
        } else {
            return .missPassword
        }
        return nil
    }

    public static func bySSID(
        _ SSID: String,
        password: String,
        saveToKeychain: Bool = true,
        whenConnected: ((NEHotspotConfigurationError?) -> Void)? = nil
    ) {
        let configuration: NEHotspotConfiguration = .init(ssid: SSID, passphrase: password, isWEP: false)
        NEHotspotConfigurationManager.shared.apply(configuration) { error in
            let neError = NEHotspotConfigurationError(by: error)
            whenConnected?(neError)
            switch neError {
            case .some(let error):
                switch error {
                case .alreadyAssociated:
                    if saveToKeychain { manager.save(password, on: SSID) }
                default:
                    break
                }
            case .none:
                if saveToKeychain { manager.save(password, on: SSID) }
            }
        }
    }
}
