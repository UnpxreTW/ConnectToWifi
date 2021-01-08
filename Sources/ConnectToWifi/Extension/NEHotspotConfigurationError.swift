//
//  NEHotspotConfigurationError.swift
//
//  Created by UnpxreTW on 2021/01/08.
//  Copyright © 2020 UnpxreTW. All rights reserved.
//
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
