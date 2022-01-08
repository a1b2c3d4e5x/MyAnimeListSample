//
//  TableViewCellPresenter.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/7.
//

import Foundation

final class TableViewCellPresenter {
	weak var view: PresenterToViewCellProtocol? = nil
	var router: PresenterToRouterCellProtocol
	var interactor: PresenterToInteractorCellProtocol
	
	private var model: TopModel? = nil
	
	init(view: PresenterToViewCellProtocol,
		 router: PresenterToRouterCellProtocol,
		 interactor: PresenterToInteractorCellProtocol) {
		self.view = view
		self.router = router
		self.interactor = interactor
	}
}

extension TableViewCellPresenter: ViewToPresenterCellProtocol {
	func update(model: TopModel) {
		self.model = model
		self.view?.setCover(image: model.image_url)
		self.view?.setTitle(text: model.title)
		self.view?.setRank(is: model.rank)
		self.view?.setDate(start: model.start_date, end: model.end_date ?? "none")
		self.view?.setType(for: model.type)
		
		let exist = self.interactor.existFavorite(model: model)
		self.view?.setFavorite(state: exist)
	}
	
	func tapFavorite(to state: Bool) {
		guard let model = self.model else { return }
		if true == state {
			self.interactor.addFavorite(model: model)
		} else {
			self.interactor.removeFavorite(model: model)
		}
		self.view?.setFavorite(state: state)
	}
}

extension TableViewCellPresenter: InteractorToPresenterCellProtocol {
	func favoriteStateDidChange() {
	}
}





