//
//  HomeTabBarPresenter.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import Foundation

final class HomeTabBarPresenter {
	weak var view: PresenterToViewHomeTabProtocol? = nil
	var interactor: PresenterToInteractorHomeTabProtocol
	var router: PresenterToRouterHomeTabProtocol
	
	init(view: PresenterToViewHomeTabProtocol,
		 interactor: PresenterToInteractorHomeTabProtocol,
		 router: PresenterToRouterHomeTabProtocol) {
		self.view = view
		self.router = router
		self.interactor = interactor
	}
}

extension HomeTabBarPresenter: ViewToPresenterHomeTabProtocol {
	func viewDidLoad() {
	}
}

extension HomeTabBarPresenter: InteractorToPresenterHomeTabProtocol { }


