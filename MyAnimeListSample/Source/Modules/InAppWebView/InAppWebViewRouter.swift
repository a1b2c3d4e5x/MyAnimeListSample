//
//  InAppWebViewRouter.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/8.
//

import Foundation
import UIKit

final class InAppWebViewRouter { }

extension InAppWebViewRouter: PresenterToRouterWebViewProtocol { }

extension InAppWebViewRouter: WireframeWebViewProtocol {
	static func createModule(url: URL, title: String) -> UIViewController {
		let viewController = InAppWebView()
		let presenter = Self.bind(view: viewController, url: url)
		viewController.presenter = presenter
		
		viewController.title = title
		return viewController
	}
}

extension InAppWebViewRouter {
	private static func bind(view: PresenterToViewWebViewProtocol, url: URL) -> ViewToPresenterWebViewProtocol {
		let interator = InAppWebViewInteractor()
		let router = InAppWebViewRouter()
		let presenter = InAppWebViewPresenter(view: view, interactor: interator, router: router, url: url)
		interator.presenter = presenter
		
		return presenter
	}
}
