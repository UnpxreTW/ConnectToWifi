//
//  WifiManager.swift
//  ConnectToWifi
//
//  Created by UnpxreTW on 2020/12/28.
//  Copyright © 2020 UnpxreTW. All rights reserved.
//
import NetworkExtension

public final class WifiManager {
    
    public static func getConfiguredSSIDs(_ handler: @escaping (([String]) -> Void)) {
        NEHotspotConfigurationManager.shared.getConfiguredSSIDs { handler($0) }
    }
}
