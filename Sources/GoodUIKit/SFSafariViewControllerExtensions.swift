//
//  SFSafariViewController.swift
//  GoodExtensions
//
//  Created by Dominik Pethö on 4/30/19.
//  Copyright © 2020 GoodRequest. All rights reserved.
//


import UIKit
import SafariServices
import GRUICompatible

public extension GRUIActive where Base: SFSafariViewController {

    static func `default`(url: URL, preferredControlTintColor: UIColor) -> SFSafariViewController {
        let controller = SFSafariViewController(url: url)
        controller.preferredControlTintColor = preferredControlTintColor
        return controller
    }

}

