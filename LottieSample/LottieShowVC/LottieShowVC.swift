//
//  LottieShowVC.swift
//  LottieSample
//
//  Created by Aybek Can Kaya on 8.07.2021.
//

import Foundation
import UIKit
import Combine
import Lottie

// MARK: - Lottie Animation Model
struct LottieAnimation {
    let url: String
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIScrollView {
    var currentPage:Int{
        guard self.frame.width > 0 else { return 1 }
        return Int((self.contentOffset.x+(0.5*self.frame.size.width))/self.frame.width)+1
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

// MARK: - LottieAnimationCell
class LottieAnimationCell: UICollectionViewCell {
    private let viewContent = ViewFactory.view().backgroundColor(UIColor.systemPink.withAlphaComponent(0.8))
    private let viewAnimation = AnimationView()
    
    private var widthConstraintAnimateViewPortrait: NSLayoutConstraint!
    private var heightConstraintAnimateViewPortrait: NSLayoutConstraint!
    private var widthConstraintAnimateViewLandscape: NSLayoutConstraint!
    private var heightConstraintAnimateViewLandscape: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        if orientation == .portrait {
            widthConstraintAnimateViewLandscape.isActive = false
            heightConstraintAnimateViewLandscape.isActive = false
            widthConstraintAnimateViewPortrait.isActive = true
            heightConstraintAnimateViewPortrait.isActive = true
        } else if  orientation == .landscapeLeft || orientation == .landscapeRight {
            widthConstraintAnimateViewLandscape.isActive = true
            heightConstraintAnimateViewLandscape.isActive = true
            widthConstraintAnimateViewPortrait.isActive = false
            heightConstraintAnimateViewPortrait.isActive = false
        } else if orientation == .unknown {
           
        }
        self.layoutIfNeeded()
    }
    
    private func setUpUI() {
        viewContent.backgroundColor = .clear
        self.viewAnimation.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        self.addSubview(self.viewContent)
        self.viewContent.fit(into: self)
        self.viewContent.addSubview(self.viewAnimation)
        self.viewAnimation.alignToCenter(from: self.viewContent, margins: .zero)
        self.viewAnimation.contentMode = .scaleAspectFill

        widthConstraintAnimateViewPortrait = self.viewAnimation.widthAnchor.constraint(equalTo: self.viewContent.widthAnchor, multiplier: 1.0)
        heightConstraintAnimateViewPortrait =  self.viewAnimation.heightAnchor.constraint(equalTo: self.viewContent.widthAnchor, multiplier: 1.0)
        widthConstraintAnimateViewLandscape = self.viewAnimation.widthAnchor.constraint(equalTo: self.viewContent.heightAnchor, multiplier: 1.0)
        heightConstraintAnimateViewLandscape = self.viewAnimation.heightAnchor.constraint(equalTo: self.viewContent.heightAnchor, multiplier: 1.0)
    }
    
    func updateCell(_ animation: LottieAnimation) {
        
        self.viewAnimation.animation = Animation.named(animation.url)
        self.viewAnimation.play(fromProgress: 0, toProgress: 1, loopMode: .loop) { _ in
            
        }
    }
}
 

// MARK: - View Controller
class LottieShowVC: UIViewController {
    private let collectionViewAnimationViews = ViewFactory.collectionView(layout: LottieShowVC.flowLayout())
        .showsHorizontalIndicators(false)
        .asCollectionView()
    
    private let pageControl = ViewFactory.pageControl()
        .pageColor(UIColor.black.withAlphaComponent(0.3))
        .pageSelectedColor(UIColor.black.withAlphaComponent(0.7))
    
    private var animations: [LottieAnimation] = []
}

// MARK: - Layout
extension LottieShowVC {
    private static func flowLayout() -> UICollectionViewFlowLayout {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        return flow
    }
}

// MARK: - Lifecycle
extension LottieShowVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

// MARK: - Set Up UI
extension LottieShowVC {
    private func setUpUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.collectionViewAnimationViews)

        self.collectionViewAnimationViews.fit(into: self.view, edges: .zero)
    
        self.collectionViewAnimationViews.register(LottieAnimationCell.self, forCellWithReuseIdentifier: "LottieAnimationCell")
        self.collectionViewAnimationViews.delegate = self
        self.collectionViewAnimationViews.dataSource = self
        self.collectionViewAnimationViews.reloadData()
        
        collectionViewAnimationViews.isPagingEnabled = true
        
        self.view.addSubview(self.pageControl)
        pageControl.leadingAnchor(from: self.view, margin: 0)
            .trailingAnchor(from: self.view, margin: 0)
            .bottomAnchor(from: self.view, margin: 0)
            .heightAnchor(16)
        
    }
}

// MARK: - Public
extension LottieShowVC {
    func updateAnimationItems(_ items: [LottieAnimation]) {
        self.animations = items
        pageControl.numberOfPages = self.animations.count
        self.collectionViewAnimationViews.reloadData()
    }
}

// MARK: - CollectionView Delegate/Datasource
extension LottieShowVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LottieAnimationCell", for: indexPath) as! LottieAnimationCell
        let currentAnimation = animations[indexPath.row]
        cell.updateCell(currentAnimation)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // let edgeLength = collectionView.frame.size.width < collectionView.frame.size.height ? collectionView.frame.size.width : collectionView.frame.size.height
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Page: \(scrollView.currentPage)")
        pageControl.currentPage = scrollView.currentPage - 1
    }
}
