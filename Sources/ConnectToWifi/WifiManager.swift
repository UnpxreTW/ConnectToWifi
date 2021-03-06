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

    // MARK: Private Variable

    private static var moduleKey = ("WifiManager.SSIDPassword").data(using: .utf8) as CFData? as Any

    // MARK: Lifecycle

    private init() {}

    // MARK: Public Function

    public func getConfiguredSSIDs(_ handler: @escaping (([String]) -> Void)) {
        NEHotspotConfigurationManager.shared.getConfiguredSSIDs { handler($0) }
    }

    public func getSSIDList() -> [String] {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrGeneric as String: WifiManager.moduleKey,
            kSecReturnAttributes as String: true,
            kSecMatchLimit as String: kSecMatchLimitAll
        ]
        var resultRef: AnyObject?
        let errorCode = withUnsafeMutablePointer(to: &resultRef) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        guard
            errorCode == errSecSuccess,
            let resultArray = resultRef as? [[String: Any]]
        else { return [] }
        return resultArray.compactMap { $0[kSecAttrAccount as String] as? String }
    }

    public func save(_ password: String, on SSID: String) {
        guard let passwordData = password.data(using: .utf8) as CFData? else { return }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrGeneric as String: WifiManager.moduleKey,
            kSecAttrAccount as String: SSID,
            kSecValueData as String: passwordData
        ]
        save(query)
    }

    public func update(_ password: String, on SSID: String) {
        guard let passwordData = password.data(using: .utf8) as CFData? else { return }
        let findOldQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrGeneric as String: WifiManager.moduleKey,
            kSecAttrAccount as String: SSID
        ]
        let newQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrGeneric as String: WifiManager.moduleKey,
            kSecAttrAccount as String: SSID,
            kSecValueData as String: passwordData
        ]
        let status = SecItemUpdate(findOldQuery as CFDictionary, newQuery as CFDictionary)
        if status == errSecItemNotFound {
            save(newQuery)
        } else {
            guard status == errSecSuccess else {
                os_log("%@", type: .error, SecCopyErrorMessageString(status, nil).debugDescription)
                return
            }
        }
    }

    public func deleteConfig(by SSID: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrGeneric as String: WifiManager.moduleKey,
            kSecAttrAccount as String: SSID
        ]
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess else {
            os_log("Delete Password Failed", type: .error)
            return
        }
        NEHotspotConfigurationManager.shared.removeConfiguration(forSSID: SSID)
    }

    // MARK: Internal Function

    internal func findWifiPassword(by SSID: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrGeneric as String: WifiManager.moduleKey,
            kSecReturnData as String: true,
            kSecAttrAccount as String: SSID
        ]
        var resultRef: AnyObject?
        let status = withUnsafeMutablePointer(to: &resultRef) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        guard
            status == errSecSuccess,
            let data = resultRef as? Data?,
            let passwordData = data,
            let password = String(data: passwordData, encoding: .utf8)
        else {
            os_log("%@", type: .error, SecCopyErrorMessageString(status, nil).debugDescription)
            return nil
        }
        return password
    }

    // MARK: Private Function

    private func save(_ query: [String: Any]) {
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            os_log("%@", type: .error, SecCopyErrorMessageString(status, nil).debugDescription)
            return
        }
    }
}
