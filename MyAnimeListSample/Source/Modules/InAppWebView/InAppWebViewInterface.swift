//
//  InAppWebViewInterface.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/8.
//

import Foundation

import UIKit

protocol WireframeWebViewProtocol: AnyObject {
	static func createModule(url: URL, title: String) -> UIViewController
}

protocol PresenterToRouterWebViewProtocol: AnyObject {
}

protocol PresenterToInteractorWebViewProtocol: AnyObject {
}

protocol PresenterToViewWebViewProtocol: AnyObject {
	func load(url: URL)
}

protocol InteractorToPresenterWebViewProtocol: AnyObject {
}

protocol ViewToPresenterWebViewProtocol: AnyObject {
	func viewDidLoad()
}
