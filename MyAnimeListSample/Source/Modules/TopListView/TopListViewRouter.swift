//
//  TopListViewRouter.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import Foundation
import WebKit

final class TopListViewRouter {
	weak var view: Viewable? = nil
	
	init(view: Viewable) {
		self.view = view
	}
}

extension TopListViewRouter: PresenterToRouterTopListProtocol {
	func showDetailView(for model: TopModel) {
		if let url = URL(string: model.url) {
			let webViewController = InAppWebViewRouter.createModule(url: url, title: model.title)
			let navigationController = UINavigationController(rootViewController: webViewController)
			self.view?.present(navigationController, animated: true, completion: nil)
		}
	}
}

extension TopListViewRouter: WireframeTopListProtocol {
	static func createModule() -> TopListViewController {
		let topListViewController: TopListViewController = TopListViewController.storyboard()
		topListViewController.presenter = Self.bind(view: topListViewController)
		return topListViewController
	}
}

extension TopListViewRouter {
	private static func bind(view: Viewable & PresenterToViewTopListProtocol) -> ViewToPresenterTopListProtocol {
		let interator = TopListViewInteractor()
		let router = TopListViewRouter(view: view)
		let presenter = TopListViewPresenter(view: view, interactor: interator, router: router)
		
		return presenter
	}
}


