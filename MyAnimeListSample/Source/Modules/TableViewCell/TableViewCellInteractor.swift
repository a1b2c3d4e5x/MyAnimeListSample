//
//  TableViewCellInteractor.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/7.
//

import Foundation

final class TableViewCellInteractor {
	weak var presenter: InteractorToPresenterCellProtocol? = nil
	private let favoriteService: FavoriteService
	
	init(favoriteService: FavoriteService) {
		self.favoriteService = favoriteService
	}
}

extension TableViewCellInteractor: PresenterToInteractorCellProtocol {
	func addFavorite(model: TopModel) {
		self.favoriteService.add(model)
		ObserverService.post(notification: .addFavorite, object: model, userInfo: nil)
	}
	
	func removeFavorite(model: TopModel) {
		self.favoriteService.delete(model)
		ObserverService.post(notification: .removeFavorite, object: model, userInfo: nil)
	}
	
	func existFavorite(model: TopModel) -> Bool {
		return self.favoriteService.contains(model)
	}
}
