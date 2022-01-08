//
//  FavoriteListViewInteractor.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import Foundation


final class FavoriteListViewInteractor {
	weak var presenter: InteractorToPresenterFavoriteListProtocol? = nil
	private let favoriteService: FavoriteService
	
	init(favoriteService: FavoriteService) {
		self.favoriteService = favoriteService
	}
}

extension FavoriteListViewInteractor: PresenterToInteractorFavoriteListProtocol {
	func  fetchFavoriteList(completion: @escaping ([TopModel]) -> Void) {
		completion(self.favoriteService.list)
	}
	
	func removeFavorite(model: TopModel) {
		self.favoriteService.delete(model)
		ObserverService.post(notification: .removeFavorite, object: model, userInfo: nil)
	}
}
