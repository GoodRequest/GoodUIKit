//
//  UIApplication.swift
//  GoodExtensions
//
//  Created by Dominik Pethö on 4/30/19.
//  Copyright © 2020 GoodRequest. All rights reserved.
//

import UIKit
import MapKit
import GRCompatible

public enum UIApplicationUrlType {

    case instagramMedia(id: String)
    case telepromt(number: String)
    case settings

}

public extension GRActive where Base: UIApplication {

    @available(iOS 13.0, *)
    var currentStatusBarFrame: CGRect? {
        return activeWindow?.windowScene?.statusBarManager?.statusBarFrame
    }

    @available(iOS 13.0, *)
    var activeWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first { $0 is UIWindowScene }
            .flatMap { $0 as? UIWindowScene }?
            .windows
            .first(where: \.isKeyWindow)
    }

    // MARK: - URL handling

    // swiftlint:disable force_unwrapping
    var canOpenInstagram: Bool {
        return base.canOpenURL(URL(string: "instagram://")!)
    }
    // swiftlint:enable force_unwrapping

    func open(_ urlType: UIApplicationUrlType) {
        switch urlType {
        case .instagramMedia(let id):
            safeOpen(URL(string: "instagram://media?id=\(id)"))

        case .telepromt(let number):
            safeOpen(URL(string: "telprompt://\(number.components(separatedBy: .whitespacesAndNewlines).joined())"))

        case .settings:
            safeOpen(URL(string: UIApplication.openSettingsURLString))
        }
    }

    func safeOpen(
        _ url: URL?,
        options: [UIApplication.OpenExternalURLOptionsKey: Any] = [:],
        completionHandler completion: ((Bool) -> Void)? = nil
    ) {
        if let url = url, base.canOpenURL(url) {
            base.open(url, options: options, completionHandler: completion)
        }
    }

}

