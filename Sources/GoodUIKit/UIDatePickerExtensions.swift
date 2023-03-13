//
//  UIDatePicker.swift
//  GoodExtensions
//
//  Created by Dominik Pethö on 4/30/19.
//  Copyright © 2020 GoodRequest. All rights reserved.
//


import UIKit
import GRUICompatible

public extension GRUIActive where Base: UIDatePicker {

    var dateBinding: Date {
        get {
            return base.date
        }
        set {
            base.date = newValue
            base.sendActions(for: .valueChanged)
        }
    }

}

