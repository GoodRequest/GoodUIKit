//
//  UITextFieldSubscriber.swift
//  
//
//  Created by Andrej Jasso on 11/03/2022.
//

import Combine
import GRUICompatible
import UIKit

// swiftlint:disable line_length
@available(iOS 13.0, *)
final public class UITextFieldSubscription<SubscriberType: Subscriber, TextField: UITextField>: Subscription where SubscriberType.Input == TextField {
// swiftlint:enable line_length

    private var subscriber: SubscriberType?
    private weak var textfield: TextField?

    init(subscriber: SubscriberType, textfield: TextField?, event: UITextField.Event) {
        self.subscriber = subscriber
        self.textfield = textfield

        textfield?.addTarget(self, action: #selector(eventHandler), for: event)
    }

    public func request(_ demand: Subscribers.Demand) {}

    public func cancel() {
        subscriber = nil
    }

    @objc private func eventHandler() {
        guard let textfield = textfield else { return }
        _ = subscriber?.receive(textfield)
    }
}

public extension GRUIActive where Base: UITextField {

    func eventPublisher(for event: UIControl.Event) -> UITextFieldPublisher<UITextField> {
        UITextFieldPublisher(control: base, event: event)
    }

}

public extension GRUIActive where Base: UITextField {

    var textPublisher: AnyPublisher<String?, Never> {
        Publishers.ControlProperty(control: base, events: [.valueChanged, .allEditingEvents], keyPath: \.text)
            .eraseToAnyPublisher()
    }

}
