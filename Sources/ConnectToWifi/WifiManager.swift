//
//  WifiManager.swift
//  ConnectToWifi
//
//  Created by UnpxreTW on 2020/12/28.
//  Copyright © 2020 UnpxreTW. All rights reserved.
//
import os.log
import NetworkExtension

public final class WifiManager {
    
    // MARK: Public Variable
    
    public static var shared: WifiManager = .init()
    
    // MARK: Lifecycle
    
    private init() {}
    
    // MARK: Public Function
    
    public func getConfiguredSSIDs(_ handler: @escaping (([String]) -> Void)) {
        NEHotspotConfigurationManager.shared.getConfiguredSSIDs { handler($0) }
    }
    
    public func save(_ password: String, in SSID: String) {
        guard let passwordData = password.data(using: .utf8) as CFData? else { return }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: SSID,
            kSecValueData as String: passwordData
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            os_log("Save Password Failed", type: .error)
            return
        }
    }
    
    // MARK: Internal Function
    
    internal func findWifiPassword(by SSID: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecReturnData as String: true,
            kSecAttrAccount as String: SSID
        ]
        var dataTypeRef: AnyObject?
        let status = withUnsafeMutablePointer(to: &dataTypeRef) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        guard
            status == errSecSuccess,
            let data = dataTypeRef as! Data?,
            let password = String(data: data, encoding: .utf8)
        else { return nil }
        return password
    }
}
