//
//  UIColor.swift
//  GoodExtensions
//
//  Created by Dominik Pethö on 4/30/19.
//  Copyright © 2020 GoodRequest. All rights reserved.
//


import UIKit
import GRUICompatible

public extension GRUIActive where Base: UIColor {

    static func from(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return Base(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    /// Creates an instance with specified RGBA values.
    ///
    /// - returns: The new `UIColor` instance.
    static func color(rgb: Int, a: CGFloat = 1.0) -> UIColor {
        return UIColor.gr.color(r: rgb, g: rgb, b: rgb, a: a)
    }

    /// Creates an instance with specified RGBA values.
    ///
    /// - returns: The new `UIColor` instance.
    static func color(r: Int, g: Int, b: Int, a: CGFloat = 1.0) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }

}

