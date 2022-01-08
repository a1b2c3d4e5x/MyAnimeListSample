//
//  TableViewCellInterface.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/7.
//

import UIKit

protocol WireframeCellProtocol: AnyObject {
	static func createModule() -> UITableViewCell
	static func bind(view: PresenterToViewCellProtocol) -> ViewToPresenterCellProtocol
}

protocol PresenterToRouterCellProtocol: AnyObject {
}

protocol PresenterToInteractorCellProtocol: AnyObject {
	func addFavorite(model: TopModel)
	func removeFavorite(model: TopModel)
	func existFavorite(model: TopModel) -> Bool
}

protocol PresenterToViewCellProtocol: AnyObject {
	func setCover(image: String)
	func setTitle(text: String)
	func setRank(is rank: Int)
	func setDate(start: String, end: String)
	func setType(for type: String)
	
	func setFavorite(state: Bool)
}

protocol InteractorToPresenterCellProtocol: AnyObject {
	func favoriteStateDidChange()
}

protocol ViewToPresenterCellProtocol: AnyObject {
	func update(model: TopModel)
	
	func tapFavorite(to state: Bool)
}

