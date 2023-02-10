//
//  GestureSubscriber.swift
//  GoodExtensions
//
//  Created by Dominik Pethö on 4/30/19.
//  Copyright © 2020 GoodRequest. All rights reserved.
//
import UIKit
import Combine

@available(iOS 13.0, *)
public class GestureSubscriber<S: Subscriber>: Subscription where S.Input == GestureType, S.Failure == Never {

    private var subscriber: S?
    private var gestureType: GestureType
    private weak var view: UIView?

    public init(subscriber: S, view: UIView, gestureType: GestureType) {
        self.subscriber = subscriber
        self.view = view
        self.gestureType = gestureType
        configureGesture(gestureType)
    }

    private func configureGesture(_ gestureType: GestureType) {
        let gesture = gestureType.get()
        gesture.addTarget(self, action: #selector(handler))
        view?.addGestureRecognizer(gesture)
    }

    public func request(_ demand: Subscribers.Demand) {

    }

    public func cancel() {
        subscriber = nil
    }

    @objc private func handler() {
        _ = subscriber?.receive(gestureType)
    }
}
