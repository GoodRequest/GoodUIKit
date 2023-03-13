//
//  ViewController.swift
//  GoodExtensions
//
//  Created by Dominik Pethö on 4/30/19.
//  Copyright © 2020 GoodRequest. All rights reserved.
//


import UIKit
import GRUICompatible
import Combine

// MARK: - Embedable

public extension GRUIActive where Base: UIViewController {
    
    func embed(viewController: UIViewController, in containerView: UIView) {
        viewController.view.frame = containerView.bounds
        containerView.addSubview(viewController.view)
        base.addChild(viewController)
        viewController.didMove(toParent: base)
    }
    
}

// MARK: - Instantiable

public extension GRUIActive where Base: UIViewController {
    
    static func makeInstance(name: String? = nil) -> Base {
        var viewControllerName: String
        if let name = name {
            viewControllerName = name
        } else {
            viewControllerName = String(describing: type(of: self))
        }
        
        let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
        guard let instance = storyboard.instantiateInitialViewController() as? Base
                ?? instantiate(storyboard: storyboard, name: viewControllerName)
        else { fatalError("Could not make instance of \(String(describing: Base.self))") }
        return instance
    }
    
    private static func instantiate(storyboard: UIStoryboard, name: String) -> Base? {
        if #available(iOS 13.0, *) {
            return storyboard.instantiateViewController(identifier: name) as? Base
        } else {
            return nil
        }
    }
    
}

public struct KeyboardInfo: Equatable {

    public static func == (lhs: KeyboardInfo, rhs: KeyboardInfo) -> Bool {
        return lhs.height == rhs.height
    }

    public let height: CGFloat
    public let duration: Double
    public let curve: UIView.AnimationOptions

    public static let emptyInfo = KeyboardInfo(height: 0.0, duration: 0.0, curve: .curveEaseInOut)

}

public enum KeyboardState: Equatable {

    case hidden(KeyboardInfo)
    case expanded(KeyboardInfo)

    public var isHidden: Bool {
        if case KeyboardState.hidden = self {
            return true
        } else {
            return false
        }
    }

}

public extension GRUIActive where Base: UIViewController {

    var keyboardStatePublisher: AnyPublisher<KeyboardState, Never> {
        let showNotification = UIApplication.keyboardWillChangeFrameNotification
        let keyboardWillShowPublisher = NotificationCenter.default.publisher(for: showNotification)
            .map { keyboard -> KeyboardState in
                let height = (keyboard.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
                let duration = (keyboard.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0.5
                // swiftlint:disable line_length
                let animationCurveRawNSN = keyboard.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
                let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
                let curve = UIView.AnimationOptions(rawValue: animationCurveRaw)
                // swiftlint:enable line_length
                let info = KeyboardInfo(height: height, duration: duration, curve: curve)
                return .expanded(info)
            }

        let hideNotification = UIApplication.keyboardWillHideNotification
        let keyboardWillHidePublisher = NotificationCenter.default.publisher(for: hideNotification)
            .map { keyboard -> KeyboardState in
                let height = 0.0
                let duration = (keyboard.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? CGFloat) ?? 0.5
                // swiftlint:disable line_length
                let animationCurveRawNSN = keyboard.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
                let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
                let curve = UIView.AnimationOptions(rawValue: animationCurveRaw)
                // swiftlint:enable line_length
                let info = KeyboardInfo(height: height, duration: duration, curve: curve)
                return .hidden(info)
            }

        return Publishers.Merge(keyboardWillShowPublisher, keyboardWillHidePublisher)
            .eraseToAnyPublisher()
    }

    var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        keyboardStatePublisher
        .map {
            switch $0 {
            case .hidden(let info), .expanded(let info):
                return info.height
            }
        }
        .eraseToAnyPublisher()
    }
    
}
