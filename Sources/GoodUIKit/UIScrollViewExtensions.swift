//
//  File.swift
//
//
//  Created by Andrej Jasso on 08/06/2021.
//


import UIKit
import GRCompatible

public extension GRActive where Base == UIScrollView {

    var isRefreshing: Bool {
        return base.refreshControl?.isRefreshing ?? false
    }

}

