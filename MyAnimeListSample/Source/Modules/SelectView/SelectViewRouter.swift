//
//  SelectViewRouter.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/9.
//

import UIKit

final class SelectViewRouter {
	weak var view: Viewable? = nil
	
	init(view: Viewable) {
		self.view = view
	}
}

extension SelectViewRouter: PresenterToRouterSelectViewProtocol {
	func dismiss() {
		self.view?.dismiss(animated: true, completion: nil)
	}
}

extension SelectViewRouter: WireframeSelectViewProtocol {
	static func createModule() -> SelectViewController {
		let viewController: SelectViewController = SelectViewController.storyboard()
		viewController.presenter = Self.bind(view: viewController)
		return viewController
	}
}

extension SelectViewRouter {
	private static func bind(view: Viewable & PresenterToViewSelectViewProtocol) -> ViewToPresenterSelectViewProtocol {
		let interator = SelectViewInteractor()
		let router = SelectViewRouter(view: view)
		let presenter = SelectViewPresenter(view: view, interactor: interator, router: router)
		interator.presenter = presenter
		
		return presenter
	}
}


