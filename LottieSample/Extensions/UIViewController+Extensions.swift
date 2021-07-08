//
//  UIViewController+Helpers.swift
//  Rapsodo Diamond
//
//  Created by aybek can kaya on 25.07.2020.
//  Copyright © 2020 Asım Can Güleşgen. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Child View Controller
extension UIViewController {
    func addChildViewController(childController: UIViewController, onView: UIView) {
        addChild(childController)
        onView.addSubview(childController.view)
        constraintViewEqual(holderView: onView, view: childController.view)
        childController.didMove(toParent: self)
    }

    private func constraintViewEqual(holderView: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                                        toItem: holderView, attribute: .top, multiplier: 1.0, constant: 0)
        let pinBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
                                           toItem: holderView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal,
                                         toItem: holderView, attribute: .left, multiplier: 1.0, constant: 0)
        let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal,
                                          toItem: holderView, attribute: .right, multiplier: 1.0, constant: 0)
        holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
    }

    func removeChildViewController() {
        guard parent != nil else { return }
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}

