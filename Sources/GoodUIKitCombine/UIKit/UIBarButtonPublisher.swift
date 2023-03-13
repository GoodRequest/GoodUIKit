//
//  UIBarButtonPublisher.swift
//  GoodCombineExtensions
//
//  Created by GoodRequest on 26/08/2021.
//

import UIKit
import Combine
import GRUICompatible

@available(iOS 13.0, *)
public struct UIBarButtonPublisher<BarButtonItem: UIBarButtonItem>: Publisher {

    public typealias Output = BarButtonItem
    public typealias Failure = Never

    weak var barButtonItem: BarButtonItem?

    init(barButtonItem: BarButtonItem, event: UIControl.Event) {
        self.barButtonItem = barButtonItem
    }

    public func receive<S>(subscriber: S) where S: Subscriber,
                                         S.Failure == UIBarButtonPublisher.Failure,
                                         S.Input == UIBarButtonPublisher.Output {
        let subscription = UIBarButtonSubscription(
            subscriber: subscriber,
            barButtonItem: barButtonItem
        )
        subscriber.receive(subscription: subscription)
    }
}

@available(iOS 13.0, *)
public extension GRUIActive where Base: UIBarButtonItem {

    func tapPublisher(for event: UIControl.Event) -> UIBarButtonPublisher<UIBarButtonItem> {
        UIBarButtonPublisher(barButtonItem: base, event: event)
    }

}
