//
//  File.swift
//
//
//  Created by Andrej Jasso on 08/06/2021.
//


import UIKit
import GRUICompatible

public extension GRUIActive where Base == UIRefreshControl {

    func endRefreshing() {
        if base.isRefreshing {
            base.endRefreshing()
        }
    }

}

