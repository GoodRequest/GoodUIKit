//
//  File.swift
//
//
//  Created by Andrej Jasso on 08/06/2021.
//


import UIKit
import GRUICompatible

public extension GRUIActive where Base == UIScrollView {

    var isRefreshing: Bool {
        return base.refreshControl?.isRefreshing ?? false
    }

}

