//
//  HomeTabBarRouter.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import Foundation
import UIKit

final class HomeTabBarRouter { }

extension HomeTabBarRouter: PresenterToRouterHomeTabProtocol { }

extension HomeTabBarRouter: WireframeHomeTabProtocol {
	static func createModule(submodules: HomeTabs) -> HomeTabBarController {
		let tabBarController: HomeTabBarController = HomeTabBarController.storyboard()
		tabBarController.viewControllers = [submodules.top, submodules.favorite]
		tabBarController.presenter = Self.bind(view: tabBarController)
		return tabBarController
	}
}

extension HomeTabBarRouter {
	private static func bind(view: PresenterToViewHomeTabProtocol) -> ViewToPresenterHomeTabProtocol {
		let interator: HomeTabBarInteractor = HomeTabBarInteractor()
		let router: HomeTabBarRouter = HomeTabBarRouter()
		let presenter: HomeTabBarPresenter = HomeTabBarPresenter(view: view, interactor: interator, router: router)
		
		return presenter
	}
}
