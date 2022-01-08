//
//  TopListViewInteractor.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import Foundation

final class TopListViewInteractor {
	weak var presenter: InteractorToPresenterTopListProtocol? = nil
}

extension TopListViewInteractor: APIServiceProtocol { }
extension TopListViewInteractor: ClientServiceProtocol { }

extension TopListViewInteractor: PresenterToInteractorTopListProtocol {
	func fetchTopList<T: Decodable>(type: TopListType, page: Int, completion: @escaping (GHResult<T>) -> Void) {
		let target = self.api.topList(type: type, page: page)
		self.client.call(target).responseModel { completion($0) }
	}
}
