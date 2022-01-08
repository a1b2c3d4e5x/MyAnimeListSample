//
//  TopListViewInterface.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import Foundation

protocol WireframeTopListProtocol: AnyObject {
	static func createModule() -> TopListViewController
}

protocol PresenterToRouterTopListProtocol: AnyObject {
	func showDetailView(for model: TopModel)
	
	func showFavoriteListView()
	func showSelectView()
}

protocol PresenterToInteractorTopListProtocol: AnyObject {
	func fetchTopList<T: Decodable>(type: TopListType, page: Int, completion: @escaping (GHResult<T>) -> Void)
}

protocol PresenterToViewTopListProtocol: AnyObject {
	func reloadData()
	func reloadData(at index: Int)
	func appendData(lastCount: Int)
	
	func showEmptyView()
	func showLoadingView()
	
	func setCurrentDetail(for type: String, subtype: String)
}

protocol InteractorToPresenterTopListProtocol: AnyObject {
	func modelDidChange(model: TopModel)
	func typeDidChang(type: TopListType)
}

protocol ViewToPresenterTopListProtocol: AnyObject {
	func viewDidLoad()
	func viewWillAppear()
	
	func tapFavorite()
	func tapSearch()
	func tapItem(at index: Int)
	
	func itemCount() -> Int
	func item(at index: Int) -> TopModel?
	
	func reloadDataSource()
	func moreDataSource()
}

extension ViewToPresenterTopListProtocol {
	func viewDidLoad() {}
	func viewWillAppear() {}
}
