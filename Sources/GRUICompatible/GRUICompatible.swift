//
//  GRUICompatible.swift
//  
//
//  Created by Dominik Pethö on 4/30/19.
//

import UIKit

public struct GRUIActive<Base> {
    /// Base object to extend.
    public let base: Base

    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) {
        self.base = base
    }
}

/// A type that has reactive extensions.
public protocol GRUICompatible {
    /// Extended type
    associatedtype GRActiveBase

    /// GRActive extensions.
    static var gr: GRUIActive<GRActiveBase>.Type { get set }

    /// GRActive extensions.
    var gr: GRUIActive<GRActiveBase> { get set }
}

public extension GRUICompatible {
    /// Reactive extensions.
    static var gr: GRUIActive<Self>.Type {
        get {
            return GRUIActive<Self>.self
        }
        // swiftlint:disable:next unused_setter_value
        set {
            // this enables using Reactive to "mutate" base type
        }
    }

    /// Reactive extensions.
    var gr: GRUIActive<Self> {
        get {
            return GRUIActive(self)
        }
        // swiftlint:disable:next unused_setter_value
        set {
            // this enables using GRActive to "mutate" base object
        }
    }
}

/// Extend UI Objects with `gr` proxy.
extension UIView: GRUICompatible { }
extension UIViewController: GRUICompatible { }
extension UIColor: GRUICompatible { }
extension UIBarItem: GRUICompatible { }
extension UIApplication: GRUICompatible { }
