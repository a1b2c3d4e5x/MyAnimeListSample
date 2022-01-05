//
//  HomeTabBarController.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import Foundation
import UIKit

final class HomeTabBarController: UITabBarController {
	var presenter: ViewToPresenterHomeTabProtocol? = nil
	
	init(tabs: HomeTabs) {
		super.init(nibName: nil, bundle: nil)
		self.viewControllers = [tabs.top, tabs.favorite]
		self._initialize()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self._initialize()
	}
}

extension HomeTabBarController: PresenterToViewHomeTabProtocol { }

extension HomeTabBarController {
	private func _initialize() {
	}
}
