//
//  UISwitchCombineExtension.swift
//  
//
//  Created by Andrej Jasso on 11/03/2022.
//

import Combine
import GRCompatible
import UIKit

public extension GRActive where Base: UISwitch {

    var isOnPublisher: AnyPublisher<Bool, Never> {
        Publishers.ControlProperty(control: base, events: .valueChanged, keyPath: \.isOn)
            .eraseToAnyPublisher()
    }

}
