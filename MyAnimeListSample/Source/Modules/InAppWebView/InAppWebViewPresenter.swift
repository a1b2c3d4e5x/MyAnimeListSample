//
//  InAppWebViewPresenter.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/8.
//

import Foundation

final class InAppWebViewPresenter {
	weak var view: PresenterToViewWebViewProtocol? = nil
	var interactor: PresenterToInteractorWebViewProtocol
	var router: PresenterToRouterWebViewProtocol
	var url: URL
	
	init(view: PresenterToViewWebViewProtocol,
		 interactor: PresenterToInteractorWebViewProtocol,
		 router: PresenterToRouterWebViewProtocol,
		 url: URL) {
		self.view = view
		self.router = router
		self.interactor = interactor
		self.url = url
	}
}

extension InAppWebViewPresenter: ViewToPresenterWebViewProtocol {
	func viewDidLoad() {
		self.view?.load(url: self.url)
	}
}

extension InAppWebViewPresenter: InteractorToPresenterWebViewProtocol { }
