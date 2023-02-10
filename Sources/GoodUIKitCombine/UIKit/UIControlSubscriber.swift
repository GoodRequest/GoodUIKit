//
//  UIControlSubscriber.swift
//  GoodExtensions
//
//  Created by Dominik Pethö on 4/30/19.
//  Copyright © 2020 GoodRequest. All rights reserved.
//

import UIKit
import Combine

// swiftlint:disable line_length
@available(iOS 13.0, *)
final public class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription where SubscriberType.Input == Control {
// swiftlint:enable line_length

    private var subscriber: SubscriberType?
    private weak var control: Control?

    init(subscriber: SubscriberType, control: Control?, event: UIControl.Event) {
        self.subscriber = subscriber
        self.control = control

        control?.addTarget(self, action: #selector(eventHandler), for: event)
    }

    public func request(_ demand: Subscribers.Demand) {

    }

    public func cancel() {
        subscriber = nil
    }

    @objc private func eventHandler() {
        guard let control = control else { return }
        _ = subscriber?.receive(control)
    }
}

// swiftlint:disable line_length
@available(iOS 13.0, *)
public final class UIControlKeyPathSubscription<S: Subscriber, Control: UIControl, Value>: Combine.Subscription where S.Input == Value {
// swiftlint:enable line_length

    private var subscriber: S?
    weak private var control: Control?
    let keyPath: KeyPath<Control, Value>
    private var didEmitInitial = false
    private let event: Control.Event

    init(subscriber: S, control: Control, event: Control.Event, keyPath: KeyPath<Control, Value>) {
        self.subscriber = subscriber
        self.control = control
        self.keyPath = keyPath
        self.event = event
        control.addTarget(self, action: #selector(handleEvent), for: event)
    }

    public func request(_ demand: Subscribers.Demand) {
        // Emit initial value upon first demand request
        if !didEmitInitial,
            demand > .none,
            let control = control,
            let subscriber = subscriber {
            _ = subscriber.receive(control[keyPath: keyPath])
            didEmitInitial = true
        }

        // We don't care about the demand at this point.
        // As far as we're concerned - UIControl events are endless until the control is deallocated.
    }

    public func cancel() {
        control?.removeTarget(self, action: #selector(handleEvent), for: event)
        subscriber = nil
    }

    @objc private func handleEvent() {
        guard let control = control else { return }

        _ = subscriber?.receive(control[keyPath: keyPath])
    }

}
