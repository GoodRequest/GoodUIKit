//
//  File.swift
//
//
//  Created by Andrej Jasso on 08/06/2021.
//


import UIKit
import GRCompatible

public extension GRActive where Base == UIRefreshControl {

    func endRefreshing() {
        if base.isRefreshing {
            base.endRefreshing()
        }
    }

}

