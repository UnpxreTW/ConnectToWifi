//
//  ConnectToWifi
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the Apache License 2.0. See LICENSE for details.
//
//  SPDX-License-Identifier: Apache-2.0

import Foundation

public enum ConnectToWifiError: Error {

    case missPassword

    case keychain(error: OSStatus)
}
