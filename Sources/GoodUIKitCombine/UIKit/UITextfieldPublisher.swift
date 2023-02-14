//
//  UITextFieldPublisher.swift
//  
//
//  Created by Andrej Jasso on 10/03/2022.
//

import Combine
import GRUICompatible
import UIKit

@available(iOS 13.0, *)
public struct UITextFieldPublisher<TextField: UITextField>: Publisher {

    public typealias Output = TextField
    public typealias Failure = Never

    weak var textfield: TextField?
    let event: UITextField.Event

    init(control: TextField, event: UIControl.Event) {
        self.textfield = control
        self.event = event
    }

    public func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, TextField == S.Input {
        let subscription = UITextFieldSubscription(
            subscriber: subscriber,
            textfield: textfield,
            event: event
        )
        subscriber.receive(subscription: subscription)
    }

}
