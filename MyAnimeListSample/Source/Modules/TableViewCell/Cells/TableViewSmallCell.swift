//
//  TableViewSmallCell.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/7.
//

import Foundation
import UIKit

final class TableViewSmallCell: UITableViewCell {
	@IBOutlet weak var coverImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var rankLabel: InsetLabel!
	@IBOutlet weak var blurView: UIVisualEffectView!
	@IBOutlet weak var favoriteButton: UIButton!
	
	var presenter: ViewToPresenterCellProtocol? = nil
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self._initialize()
	}
	
	@IBAction func tapFavoriteButton(_ sender: UIButton) {
		let generator = UIImpactFeedbackGenerator(style: .light)
		generator.impactOccurred()
		self.presenter?.tapFavorite(to: !sender.isSelected)
	}
}

extension TableViewSmallCell: PresenterToViewCellProtocol {
	func setCover(image: String) {
		self.coverImageView.downloaded(from: image, placeholder: UIImage(named: "NoPicture"))
	}
	
	func setTitle(text: String) {
		self.titleLabel.text = text
	}
	
	func setRank(is rank: Int) {
		self.rankLabel.text = "#\(rank)"
	}
	
	func setDate(start: String, end: String) {
		self.timeLabel.text = "\(start) - \(end)"
	}
	
	func setType(for type: String) {
		self.typeLabel.text = type
	}
	
	func setFavorite(state: Bool) {
		self.favoriteButton.isSelected = state
	}
}

extension TableViewSmallCell {
	public func setup(model: TopModel) {
		self.presenter?.update(model: model)
	}
}

extension TableViewSmallCell {
	private func _initialize() {
		self.presenter = TableViewCellRouter.bind(view: self)
		
		self.favoriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
		self.favoriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
		
		self.blurView.clipsToBounds = true
		self.blurView.layer.cornerRadius = 5
		self.blurView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
		
		self.coverImageView.clipsToBounds = true
		self.coverImageView.layer.cornerRadius = 5
	}
}
