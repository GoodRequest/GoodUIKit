//
//  UICollectionView.swift
//  GoodExtensions
//
//  Created by Andrej Jasso on 29/09/2021.
//


import GRUICompatible
import UIKit

// MARK: - Cell Registration

public extension GRUIActive where Base: UICollectionView {

    /// Register reusable cell with specified class type.
    func registerCell<T: UICollectionViewCell>(fromClass type: T.Type) {
        guard Bundle.main.path(forResource: String(describing: type), ofType: "nib") != nil else {
            base.register(T.self, forCellWithReuseIdentifier: String(describing: type))
            return
        }
        base.register(
            UINib(nibName: String(describing: type), bundle: nil),
            forCellWithReuseIdentifier: String(describing: type)
        )
    }

    /// Register reusable supplementary view with specified class type.
    func register<T: UICollectionReusableView>(
        viewClass type: T.Type,
        forSupplementaryViewOfKind: String = UICollectionView.elementKindSectionHeader
    ) {
        base.register(
            UINib(nibName: String(describing: type), bundle: nil),
            forSupplementaryViewOfKind: forSupplementaryViewOfKind,
            withReuseIdentifier: String(describing: type)
        )
    }

}

// MARK: - Cell Dequeueing

public extension GRUIActive where Base: UICollectionView {

    // swiftlint:disable force_cast

    /// Dequeue reusable supplementary view with specified class type.
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
        ofKind kind: String,
        fromClass type: T.Type,
        for indexPath: IndexPath
    ) -> T {
        return base.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: String(describing: type),
            for: indexPath
        ) as! T
    }

    /// Dequeue reusable cell with specified class type.
    func dequeueReusableCell<T: UICollectionViewCell>(fromClass type: T.Type, for indexPath: IndexPath) -> T {
        return base.dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }

    // swiftlint:enable force_cast

    /// Deselect first selected item along UIViewController`s transition coordinator.
    func deselectSelectedItem(along transitionCoordinator: UIViewControllerTransitionCoordinator?) {
        guard let selectedIndexPath = base.indexPathsForSelectedItems?.first else { return }

        guard let coordinator = transitionCoordinator else {
            base.deselectItem(at: selectedIndexPath, animated: false)
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.base.deselectItem(at: selectedIndexPath, animated: true)
        }, completion: { [weak base] context in
            if context.isCancelled {
                base?.selectItem(
                    at: selectedIndexPath,
                    animated: false,
                    scrollPosition: UICollectionView.ScrollPosition(rawValue: 0)
                )
            }
        })
    }

}

