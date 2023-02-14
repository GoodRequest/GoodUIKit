//
//  UINavigationController.swift
//  GoodExtensions
//
//  Created by Dominik Pethö on 4/30/19.
//  Copyright © 2020 GoodRequest. All rights reserved.
//


import UIKit
import GRUICompatible

// MARK: - Navigation Controller

public extension GRActive where Base: UINavigationController {

    func pushViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void
    ) {
        base.pushViewController(viewController, animated: animated)

        guard animated, let coordinator = base.transitionCoordinator else {
            completion()
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }

}

