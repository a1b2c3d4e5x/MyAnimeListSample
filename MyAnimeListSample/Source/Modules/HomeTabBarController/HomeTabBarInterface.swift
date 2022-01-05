//
//  HomeTabBarInterface.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import Foundation
import UIKit

typealias HomeTabs = (
	top: UIViewController,
	favorite: UIViewController
)

protocol WireframeHomeTabProtocol: AnyObject {
	static func createModule(submodules: HomeTabs) -> HomeTabBarController
}

protocol PresenterToRouterHomeTabProtocol: AnyObject {
}

protocol PresenterToInteractorHomeTabProtocol: AnyObject {
}

protocol PresenterToViewHomeTabProtocol: AnyObject {
}

protocol InteractorToPresenterHomeTabProtocol: AnyObject {
}

protocol ViewToPresenterHomeTabProtocol: AnyObject {
	func viewDidLoad()
}
