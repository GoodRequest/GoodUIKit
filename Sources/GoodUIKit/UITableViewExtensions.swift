//
//  UITableView.swift
//  GoodExtensions
//
//  Created by Andrej Jasso on 29/09/2021.
//


import GRUICompatible
import UIKit

public extension GRActive where Base: UITableView {

    /// Register reusable cell with specified class type.
    func registerCell<T: UITableViewCell>(fromClass type: T.Type) {
        guard Bundle.main.path(forResource: String(describing: type), ofType: "nib") != nil else {
            base.register(T.self, forCellReuseIdentifier: String(describing: type))
            return
        }
        base.register(
            UINib(nibName: String(describing: type), bundle: nil),
            forCellReuseIdentifier: String(describing: type)
        )
    }

    /// Register reusable header footer view with specified class type.
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(fromClass type: T.Type) {
        base.register(
            UINib(nibName: String(describing: type), bundle: nil),
            forHeaderFooterViewReuseIdentifier: String(describing: type)
        )
    }

    /// Dequeue reusable header footer view with specified class type.
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(fromClass type: T.Type) -> T? {
        return base.dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as? T
    }

    /// Dequeue reusable cell with specified class type.
    func dequeueReusableCell<T: UITableViewCell>(fromClass type: T.Type, for indexPath: IndexPath) -> T? {
        return base.dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as? T
    }

    /// Deselect selected row along UIViewController`s transition coordinator.
    func deselectSelectedRow(along transitionCoordinator: UIViewControllerTransitionCoordinator?) {
        guard let selectedIndexPath = base.indexPathForSelectedRow else { return }

        guard let coordinator = transitionCoordinator else {
            base.deselectRow(at: selectedIndexPath, animated: false)
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.base.deselectRow(at: selectedIndexPath, animated: true)
        }, completion: { [weak base] context in
            if context.isCancelled {
                base?.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
            }
        })
    }

}

// MARK: - Table Header/Footer Layout

public extension GRActive where Base: UITableView {

    func sizeHeaderToFit() {
        if let headerView = base.tableHeaderView {
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()

            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height

            var frame = headerView.frame

            frame.size.height = height
            headerView.frame = frame

            base.tableHeaderView = headerView
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
        }
    }

    func updateHeaderWidth() {
        if let headerView = base.tableHeaderView {
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
            var headerFrame = headerView.frame

            if height != headerFrame.size.width {
                headerFrame.size.width = height
                headerView.frame = headerFrame
                base.tableHeaderView = headerView
            }
        }
    }

    func sizeFooterToFit() {
        if let footerView = base.tableFooterView {
            footerView.setNeedsLayout()
            footerView.layoutIfNeeded()

            let height = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var frame = footerView.frame

            frame.size.width = frame.width
            frame.size.height = height
            footerView.frame = frame

            base.tableFooterView = footerView
        }
    }

}

