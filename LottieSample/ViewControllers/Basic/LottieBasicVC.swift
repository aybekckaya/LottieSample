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

// MARK: - Lottie Animation Model
struct LottieAnimation {
    let url: String
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
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
        self.viewAnimation.backgroundColor = UIColor.black.withAlphaComponent(0.75)
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
 
// MARK: - Skeleton
class LottieBasicVC: UIViewController {
   
    private let animations: [LottieAnimation] = [
        LottieAnimation(url: "lottieLoading1"),
        LottieAnimation(url: "animLottieBird"),
        LottieAnimation(url: "lottieLoading1"),
        LottieAnimation(url: "animLottieBird")
    ]
    
    private let collectionViewAnimationViews = ViewFactory.collectionView(layout: LottieBasicVC.flowLayout()).backgroundColor(.clear).asCollectionView()
}

// MARK: - Lifecycle
extension LottieBasicVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
       
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //collectionViewAnimationViews.collectionViewLayout.invalidateLayout()
        //self.collectionViewAnimationViews.collectionViewLayout = LottieBasicVC.flowLayout()
        //self.collectionViewAnimationViews.reloadData()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        //collectionViewAnimationViews.collectionViewLayout.invalidateLayout()
        
    }
}

// MARK: - Set Up UI
extension LottieBasicVC {
    private func setUpUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.collectionViewAnimationViews)

        self.collectionViewAnimationViews.fit(into: self.view, edges: .zero)
    
        self.collectionViewAnimationViews.register(LottieAnimationCell.self, forCellWithReuseIdentifier: "LottieAnimationCell")
        self.collectionViewAnimationViews.delegate = self
        self.collectionViewAnimationViews.dataSource = self
        self.collectionViewAnimationViews.reloadData()
        
        collectionViewAnimationViews.isPagingEnabled = true
    }
}

extension LottieBasicVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
}

// MARK: - CollectionView
extension LottieBasicVC {
    private static func flowLayout() -> UICollectionViewFlowLayout {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        return flow
    }
    
    private static func layout() -> UICollectionViewCompositionalLayout {
        
        let usePortraitLayout = UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        let groupSize = usePortraitLayout ? NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(1.0)) : NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1.0))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return UICollectionViewCompositionalLayout(section: section)
    }

}
