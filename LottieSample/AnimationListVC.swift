//
//  AnimationListVC.swift
//  LottieSample
//
//  Created by Aybek Can Kaya on 7.07.2021.
//

import Foundation
import UIKit

// MARK: - Animation Type
enum AnimationType {
    case lottieBasic
    
    var title: String {
        switch self {
        case .lottieBasic:
            return "Basic Animations"
        }
    }
    
    var viewController: UIViewController {
        switch self {
            case .lottieBasic:
                return LottieBasicVC()
        }
    }

}

// MARK: - Animation List Cell
class AnimationListCell: UITableViewCell {
    static let identifier: String = "AnimationListCell"
    
    private let lblTitle: UILabel = ViewFactory.label()
        .alignment(.left)
        .numberOfLines(1)
        .textColor(UIColor.black.withAlphaComponent(0.7))
        .font(.avenirNextRegular(with: 17))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        self.addSubview(lblTitle)
        self.lblTitle.leadingAnchor(from: self, margin: 24)
            .trailingAnchor(from: self, margin: 16)
            .centerYAnchor(from: self, margin: 0)
    }
    
    func updateCell(with animationType: AnimationType) {
        self.lblTitle.text = animationType.title
    }
}

// MARK: - Skeleton
class AnimationListVC: UIViewController {
    private let tableViewAnimations: UITableView = ViewFactory.tableView()
        .seperatorStyle(.singleLine)
        .registerCell(AnimationListCell.self, identifier: AnimationListCell.identifier)
        .removeEmptyCellSeperators()
        .backgroundColor(.clear)
        .asTableView()
    
    private let animationTypes: [AnimationType] = [.lottieBasic]
    
}

// MARK: - Lifecycle
extension AnimationListVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

// MARK: - Set Up UI
extension AnimationListVC {
    private func setUpUI() {
    
        let config = UIImage.SymbolConfiguration(pointSize: 24)
        let backImage = UIImage(systemName: "chevron.left", withConfiguration: config)!
       
        self.navigationController?.navigationBar.titleFont(font: .avenirNextBold(with: 24), color: .black).preferLargeTitles(false)
        self.title = "Lottie List"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableViewAnimations)
        self.tableViewAnimations.fit(into: self.view)
        self.tableViewAnimations.delegate = self
        self.tableViewAnimations.dataSource = self
    }
}

// MARK: - TableView
extension AnimationListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animationTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AnimationListCell = tableView.dequeueReusableCell(withIdentifier: "AnimationListCell", for: indexPath) as! AnimationListCell
        let item = animationTypes[indexPath.row]
        cell.updateCell(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = animationTypes[indexPath.row]
        let viewController = item.viewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
