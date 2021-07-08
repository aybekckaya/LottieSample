//
//  LottieBasicVC.swift
//  LottieSample
//
//  Created by Aybek Can Kaya on 7.07.2021.
//

import Foundation
import UIKit
import Combine
import Lottie

// MARK: Child Container View
class ChildVCContainerView<T: UIViewController, G: UIViewController>: UIView {
    private(set) var childVC: T
    private(set) var parentVC: T
    
    init(parentVC: T, childVC: T) {
        self.parentVC = parentVC
        self.childVC = childVC
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func reload() {
        parentVC.addChildViewController(childController: childVC, onView: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Skeleton
class LottieBasicVC: UIViewController {

    private let showContainerView = ViewFactory.view().backgroundColor(.clear)
    private let vcShow = LottieShowVC()
    
    private let animations: [LottieAnimation] = [
        LottieAnimation(url: "lottieLoading1"),
        LottieAnimation(url: "animLottieBird"),
        LottieAnimation(url: "lottieLoading1"),
        LottieAnimation(url: "animLottieBird")
    ]

}

// MARK: - Lifecycle
extension LottieBasicVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        vcShow.updateAnimationItems(animations)
    }
}

// MARK: - Set Up UI
extension LottieBasicVC {
    private func setUpUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(showContainerView)
        showContainerView.leadingAnchor(from: view, margin: 0).trailingAnchor(from: view, margin: 0).topAnchor(from: view, margin: 0)
        showContainerView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
       
       
        self.addChildViewController(childController: vcShow, onView: showContainerView)
    }
}
