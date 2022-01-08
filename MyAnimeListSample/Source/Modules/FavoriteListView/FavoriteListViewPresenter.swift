//
//  FavoriteListViewPresenter.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import Foundation

final class FavoriteListViewPresenter {
	weak var view: PresenterToViewFavoriteListProtocol? = nil
	var interactor: PresenterToInteractorFavoriteListProtocol
	var router: PresenterToRouterFavoriteListProtocol
	
	private var models: [TopModel]? = nil
	
	init(view: PresenterToViewFavoriteListProtocol,
		 interactor: PresenterToInteractorFavoriteListProtocol,
		 router: PresenterToRouterFavoriteListProtocol) {
		self.view = view
		self.router = router
		self.interactor = interactor
	}
}

extension FavoriteListViewPresenter: ViewToPresenterFavoriteListProtocol {
	func viewDidLoad() {
		self.interactor.fetchFavoriteList { [weak self] models in
			self?.models = models
			self?.view?.reloadData()
		}
	}
	
	func itemCount() -> Int {
		return self.models?.count ?? 0
	}
	
	func item(at index: Int) -> TopModel? {
		guard self.itemCount() > index else { return nil }
		return self.models?[index]
	}
	
	func tapItem(at index: Int) {
		guard let model = self.item(at: index) else { return }
		self.router.showDetailView(for: model)
	}
	
	func removeFavorite(at index: Int) {
		guard let model = self.item(at: index) else { return }
		self.interactor.removeFavorite(model: model)
		self.models?.remove(at: index)
		self.view?.deleteData(at: index)
	}
}

extension FavoriteListViewPresenter: InteractorToPresenterFavoriteListProtocol { }
