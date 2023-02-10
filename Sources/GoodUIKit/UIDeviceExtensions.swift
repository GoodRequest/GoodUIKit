//
//  UIDevice.swift
//  GoodExtensions
//
//  Created by Dominik Pethö on 4/30/19.
//  Copyright © 2020 GoodRequest. All rights reserved.
//


import UIKit
import GRCompatible

public extension GRActive where Base: UIDevice {

    var device: GRDevice {
        GRDevice(
            deviceId: base.identifierForVendor?.uuidString ?? "",
            deviceSystem: "\(base.systemName) \(base.systemVersion)",
            deviceName: base.name,
            deviceType: base.model
        )
    }

}

public struct GRDevice {

    public let deviceId: String
    public let deviceSystem: String
    public let deviceName: String
    public let deviceType: String

}

