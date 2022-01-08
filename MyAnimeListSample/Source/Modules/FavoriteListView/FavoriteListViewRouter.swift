//
//  FavoriteListViewRouter.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import Foundation
import UIKit

final class FavoriteListViewRouter {
	weak var view: Viewable? = nil
	
	init(view: Viewable) {
		self.view = view
	}
}

extension FavoriteListViewRouter: PresenterToRouterFavoriteListProtocol {
	func showDetailView(for model: TopModel) {
		if let url = URL(string: model.url) {
			let webViewController = InAppWebViewRouter.createModule(url: url, title: model.title)
			let navigationController = UINavigationController(rootViewController: webViewController)
			self.view?.present(navigationController, animated: true, completion: nil)
		}
	}
}

extension FavoriteListViewRouter: WireframeFavoriteListProtocol {
	static func createModule() -> FavoriteListViewController {
		let FavoriteListViewController: FavoriteListViewController = FavoriteListViewController.storyboard()
		FavoriteListViewController.presenter = Self.bind(view: FavoriteListViewController)
		return FavoriteListViewController
	}
}

extension FavoriteListViewRouter {
	private static func bind(view: Viewable & PresenterToViewFavoriteListProtocol) -> ViewToPresenterFavoriteListProtocol {
		let interator = FavoriteListViewInteractor(favoriteService: FavoriteService.shared)
		let router = FavoriteListViewRouter(view: view)
		let presenter = FavoriteListViewPresenter(view: view, interactor: interator, router: router)
		interator.presenter = presenter
		
		return presenter
	}
}


