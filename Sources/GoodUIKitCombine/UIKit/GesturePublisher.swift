//
//  GesturePublisher.swift
//  GoodExtensions
//
//  Created by Dominik Pethö on 4/30/19.
//  Copyright © 2020 GoodRequest. All rights reserved.
//

import UIKit
import Combine
import GRUICompatible

public enum GestureType {

    case tap(UITapGestureRecognizer = .init())
    case swipe(UISwipeGestureRecognizer = .init())
    case longPress(UILongPressGestureRecognizer = .init())
    case pan(UIPanGestureRecognizer = .init())
    case pinch(UIPinchGestureRecognizer = .init())
    case edge(UIScreenEdgePanGestureRecognizer = .init())

    public func get() -> UIGestureRecognizer {
        switch self {
        case let .tap(tapGesture):
            return tapGesture

        case let .swipe(swipeGesture):
            return swipeGesture

        case let .longPress(longPressGesture):
            return longPressGesture

        case let .pan(panGesture):
            return panGesture

        case let .pinch(pinchGesture):
            return pinchGesture

        case let .edge(edgePanGesture):
            return edgePanGesture
       }
    }
}

@available(iOS 13.0, *)
public struct GesturePublisher: Publisher {

    public typealias Output = GestureType
    public typealias Failure = Never
    private let view: UIView
    private let gestureType: GestureType

    public init(view: UIView, gestureType: GestureType) {
        self.view = view
        self.gestureType = gestureType
    }

    public func receive<S>(
    	subscriber: S
    ) where S: Subscriber, GesturePublisher.Failure == S.Failure, GesturePublisher.Output == S.Input {
        let subscription = GestureSubscriber(
            subscriber: subscriber,
            view: view,
            gestureType: gestureType
        )
        subscriber.receive(subscription: subscription)
    }
}

@available(iOS 13.0, *)
public extension GRActive where Base: UIView {

    func gesturePublisher(_ gestureType: GestureType) -> GesturePublisher {
        GesturePublisher(view: base, gestureType: gestureType)
    }

}
