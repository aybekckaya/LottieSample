//
//  UIViewExtensions.swift
//  LottieSample
//
//  Created by Aybek Can Kaya on 7.07.2021.
//

import Foundation
import UIKit

// MARK: - Edge insets
extension UIEdgeInsets {
    static func fill(with value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
}

// MARK: - Constraints
extension UIView {
    @discardableResult
    func fit(into view:UIView, edges: UIEdgeInsets = .zero) -> UIView {
        return self.topAnchor(from: view, margin: edges.top)
            .leadingAnchor(from: view, margin: edges.left)
            .trailingAnchor(from: view, margin: edges.right)
            .bottomAnchor(from: view, margin: edges.bottom)
    }
    
    @discardableResult
    func alignToCenter(from view: UIView, margins: CGPoint) -> UIView {
        return self.centerXAnchor(from: view, margin: margins.x)
            .centerYAnchor(from: view, margin: margins.y)
    }
    
    @discardableResult
    func dimensions(_ size: CGSize) -> UIView {
        return self.widthAnchor(size.width)
            .heightAnchor(size.height)
    }
    
    @discardableResult
    func topAnchor(from view: UIView, margin: CGFloat) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: margin).isActive = true
        return self
    }
    
    @discardableResult
    func leadingAnchor(from view: UIView, margin: CGFloat) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        return self
    }
    
    @discardableResult
    func trailingAnchor(from view: UIView, margin: CGFloat) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * margin).isActive = true
        return self
    }
    
    @discardableResult
    func bottomAnchor(from view: UIView, margin: CGFloat) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1 * margin).isActive = true
        return self
    }
    
    @discardableResult
    func centerXAnchor(from view: UIView, margin: CGFloat) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: margin).isActive = true
        return self
    }
    
    @discardableResult
    func centerYAnchor(from view: UIView, margin: CGFloat) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: margin).isActive = true
        return self
    }
    
    @discardableResult
    func widthAnchor(_ constant: CGFloat) -> UIView {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func heightAnchor(_ constant: CGFloat) -> UIView {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
}

// MARK: - View Factory
struct ViewFactory {
   
    static func stackView(alignment: UIStackView.Alignment, distribution: UIStackView.Distribution, spacing: CGFloat, axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = alignment
        stack.distribution = distribution
        stack.spacing = spacing
        stack.axis = axis
        return stack
    }
    
    static func view() -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func imageView() -> UIImageView {
        let imView = UIImageView(frame: .zero)
        imView.translatesAutoresizingMaskIntoConstraints = false
        return imView
    }
    
    static func collectionView(layout: UICollectionViewLayout) -> UICollectionView {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }
    
    static func label() -> UILabel {
        let lbl = UILabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
    
    static func tableView() -> UITableView {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table 
    }
    
}

// MARK: - View Property
extension UIView {
    @discardableResult
    func roundCorners(by value: CGFloat, maskToBounds: Bool = false) -> UIView {
        self.layer.cornerRadius = value
        self.layer.masksToBounds = maskToBounds
        return self
    }
    
    @discardableResult
    func shadow(color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) -> UIView {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shouldRasterize = true
        self.layer.masksToBounds = false
        return self
    }
    
    @discardableResult
    func backgroundColor(_ color: UIColor) -> UIView {
        self.backgroundColor = color
        return self
    }
}

// MARK: - Casting
extension UIView {
    func asImageView() -> UIImageView {
        return self as! UIImageView
    }
    
    func asCollectionView() -> UICollectionView {
        return self as! UICollectionView
    }
    
    func asLabel() -> UILabel {
        return self as! UILabel
    }
    
    func asTableView() -> UITableView {
        return self as! UITableView
    }
}

// MARK: - CALayer
extension CALayer {
    static func gradientLayer(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint ) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.colors = colors.map { $0.cgColor }
        return gradient
    }
    
    @discardableResult
    func roundCorners(by value: CGFloat) -> CALayer {
        self.cornerRadius = value
        return self
    }
    
    @discardableResult
    func asGradientLayer() -> CAGradientLayer {
        return self as! CAGradientLayer
    }
}

// MARK: UILabel
extension UILabel {
    @discardableResult
    func font(_ font: UIFont) -> UILabel{
        self.font = font
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor) -> UILabel {
        self.textColor = color
        return self
    }
    
    @discardableResult
    func alignment(_ alignment: NSTextAlignment) -> UILabel {
        self.textAlignment = alignment
        return self
    }
    
    @discardableResult
    func numberOfLines(_ count: Int) -> UILabel {
        self.numberOfLines = count
        return self
    }
}


// MARK: - UITableView
extension UITableView {
    @discardableResult
    func seperatorStyle(_ style: UITableViewCell.SeparatorStyle) -> UITableView {
        self.separatorStyle = style
        return self 
    }
    
    @discardableResult
    func registerCell(_ cell: AnyClass, identifier: String) -> UITableView {
        self.register(cell, forCellReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func removeEmptyCellSeperators() -> UITableView {
        self.tableFooterView = UIView(frame: .zero)
        return self
    }
    
}

// MARK: - UIFont
/**
 Avenir Next ["AvenirNext-Regular", "AvenirNext-Italic", "AvenirNext-UltraLight", "AvenirNext-UltraLightItalic", "AvenirNext-Medium", "AvenirNext-MediumItalic", "AvenirNext-DemiBold", "AvenirNext-DemiBoldItalic", "AvenirNext-Bold", "AvenirNext-BoldItalic", "AvenirNext-Heavy", "AvenirNext-HeavyItalic"]
 */
extension UIFont {
    static func avenirNextRegular(with size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Regular", size: size)!
    }
    
    static func avenirNextBold(with size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Bold", size: size)!
    }
}

// MARK: - UINavigation Bar
extension UINavigationBar {
    @discardableResult
    func titleFont(font: UIFont, color: UIColor) -> UINavigationBar {
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font]
        return self 
    }
    
    @discardableResult
    func preferLargeTitles(_ isPrefer: Bool) -> UINavigationBar {
        self.prefersLargeTitles = isPrefer
        return self 
    }
    
    @discardableResult
    func backBarButtonImage(_ image: UIImage) -> UINavigationBar {
        self.backIndicatorImage = image
        self.backIndicatorTransitionMaskImage = image
        self.backItem?.title = "ac"
        return self
    }
}
