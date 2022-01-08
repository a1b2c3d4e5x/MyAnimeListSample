//
//  FavoriteListViewInterface.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import Foundation

protocol WireframeFavoriteListProtocol: AnyObject {
	static func createModule() -> FavoriteListViewController
}

protocol PresenterToRouterFavoriteListProtocol: AnyObject {
	func showDetailView(for model: TopModel)
}

protocol PresenterToInteractorFavoriteListProtocol: AnyObject {
	func fetchFavoriteList(completion: @escaping ([TopModel]) -> Void)
	func removeFavorite(model: TopModel)
}

protocol PresenterToViewFavoriteListProtocol: AnyObject {
	func reloadData()
	func deleteData(at index: Int)
}

protocol InteractorToPresenterFavoriteListProtocol: AnyObject {
}

protocol ViewToPresenterFavoriteListProtocol: AnyObject {
	func viewDidLoad()
	func viewWillAppear()
	
	func tapItem(at index: Int)
	
	func itemCount() -> Int
	func item(at index: Int) -> TopModel?
	
	func removeFavorite(at index: Int)
}

extension ViewToPresenterFavoriteListProtocol {
	func viewDidLoad() {}
	func viewWillAppear() {}
}
