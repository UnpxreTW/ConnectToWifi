//
//  ConnectToWifiError.swift
//
//  Created by UnpxreTW on 2021/01/04.
//  Copyright © 2020 UnpxreTW. All rights reserved.
//
import Foundation

public enum ConnectToWifiError: Error {

    case missPassword

    case keychain(error: OSStatus)
}
