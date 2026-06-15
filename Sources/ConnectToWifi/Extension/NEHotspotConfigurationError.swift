//
//  ConnectToWifi
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the Apache License 2.0. See LICENSE for details.
//
//  SPDX-License-Identifier: Apache-2.0

import NetworkExtension

extension NEHotspotConfigurationError {

    init?(by error: Error?) {
        guard let error = error else { return nil }
        let nsError = error as NSError
        if nsError.domain == "NEHotspotConfigurationErrorDomain" {
            self.init(rawValue: nsError.code)
        } else {
            return nil
        }
    }
}
