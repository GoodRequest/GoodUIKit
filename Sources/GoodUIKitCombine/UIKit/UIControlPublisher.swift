//
//  UIControlPublisher.swift
//  GoodExtensions
//
//  Created by Dominik Pethö on 4/30/19.
//  Copyright © 2020 GoodRequest. All rights reserved.
//

import UIKit
import Combine
import GRUICompatible

@available(iOS 13.0, *)
public struct UIControlPublisher<Control: UIControl>: Publisher {

    public typealias Output = Control
    public typealias Failure = Never

    weak var control: Control?
    let event: UIControl.Event

    init(control: Control, event: UIControl.Event) {
        self.control = control
        self.event = event
    }

    public func receive<S>(subscriber: S) where S: Subscriber,
                                         S.Failure == UIControlPublisher.Failure,
                                         S.Input == UIControlPublisher.Output {
        let subscription = UIControlSubscription(
            subscriber: subscriber,
            control: control,
            event: event
        )
        subscriber.receive(subscription: subscription)
    }
}

@available(iOS 13.0, *)
public extension GRUIActive where Base: UIControl {

    func publisher(for event: UIControl.Event) -> UIControlPublisher<UIControl> {
        UIControlPublisher(control: base, event: event)
    }

}

// MARK: - Keypath Publisher

@available(iOS 13.0, *)
public extension Combine.Publishers {

    /// A Control Property is a publisher that emits the value at the provided keypath
    /// whenever the specific control events are triggered. It also emits the keypath's
    /// initial value upon subscription.
    struct ControlProperty<Control: UIControl, Value>: Publisher {

        public typealias Output = Value
        public typealias Failure = Never

        private let control: Control
        private let controlEvents: Control.Event
        private let keyPath: KeyPath<Control, Value>

        /// Initialize a publisher that emits the value at the specified keypath
        /// whenever any of the provided Control Events trigger.
        ///
        /// - parameter control: UI Control.
        /// - parameter events: Control Events.
        /// - parameter keyPath: A Key Path from the UI Control to the requested value.
        public init(
            control: Control,
            events: Control.Event,
            keyPath: KeyPath<Control, Value>
        ) {
            self.control = control
            self.controlEvents = events
            self.keyPath = keyPath
        }

        public func receive<S: Subscriber>(subscriber: S) where S.Failure == Failure, S.Input == Output {
            let subscription = UIControlKeyPathSubscription(
                subscriber: subscriber,
                control: control,
                event: controlEvents,
                keyPath: keyPath
            )

            subscriber.receive(subscription: subscription)
        }

    }

}
