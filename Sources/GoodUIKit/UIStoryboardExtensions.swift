//
//  UIStoryboard.swift
//  GoodExtensions
//
//  Created by Andrej Jasso on 29/09/2021.
//


import UIKit
import GRUICompatible

public extension GRUIActive where Base: UIStoryboard {

    func instantiateViewController<T: UIViewController>(withClass clas: T.Type) -> T? {
        return base.instantiateViewController(withIdentifier: String(describing: clas)) as? T
    }

}

