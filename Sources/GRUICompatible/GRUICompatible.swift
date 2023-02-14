//
//  GRUICompatible.swift
//  
//
//  Created by Dominik Pethö on 4/30/19.
//

import Foundation

public struct GRActive<Base> {
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
    static var gr: GRActive<GRActiveBase>.Type { get set }

    /// GRActive extensions.
    var gr: GRActive<GRActiveBase> { get set }
}

public extension GRUICompatible {
    /// Reactive extensions.
    static var gr: GRActive<Self>.Type {
        get {
            return GRActive<Self>.self
        }
        // swiftlint:disable:next unused_setter_value
        set {
            // this enables using Reactive to "mutate" base type
        }
    }

    /// Reactive extensions.
    var gr: GRActive<Self> {
        get {
            return GRActive(self)
        }
        // swiftlint:disable:next unused_setter_value
        set {
            // this enables using GRActive to "mutate" base object
        }
    }
}

/// Extend NSObject with `gr` proxy.
extension NSObject: GRUICompatible { }
