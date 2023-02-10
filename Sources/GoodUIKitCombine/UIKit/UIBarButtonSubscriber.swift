//
//  UIBarButtonSubscriber.swift
//  GoodCombineExtensions
//
//  Created by GoodRequest on 26/08/2021.
//

import UIKit
import Combine

// swiftlint:disable line_length
@available(iOS 13.0, *)
final class UIBarButtonSubscription<SubscriberType: Subscriber, BarButtonItem: UIBarButtonItem>: Subscription where SubscriberType.Input == BarButtonItem {
// swiftlint:enable line_length

    private var subscriber: SubscriberType?
    private weak var barButtonItem: BarButtonItem?

    init(subscriber: SubscriberType, barButtonItem: BarButtonItem?) {
        self.subscriber = subscriber
        self.barButtonItem = barButtonItem

        if let button = barButtonItem?.customView as? UIButton {
            button.addTarget(self, action: #selector(eventHandler), for: .touchUpInside)
        } else {
            barButtonItem?.action = #selector(eventHandler)
            barButtonItem?.target = self
        }
    }

    public func request(_ demand: Subscribers.Demand) {

    }

    public func cancel() {
        subscriber = nil
    }

    @objc private func eventHandler() {
        guard let barButtonItem = barButtonItem else { return }
        _ = subscriber?.receive(barButtonItem)
    }
}
