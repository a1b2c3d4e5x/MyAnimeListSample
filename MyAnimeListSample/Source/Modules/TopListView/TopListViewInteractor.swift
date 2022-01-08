//
//  TopListViewInteractor.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import Foundation

final class TopListViewInteractor {
	weak var presenter: InteractorToPresenterTopListProtocol? = nil

	init() {
		ObserverService.add(observer: self, selector: #selector(self.addFavorite(_:)), notification: .addFavorite, object: nil)
		ObserverService.add(observer: self, selector: #selector(self.removeFavorite(_:)), notification: .removeFavorite, object: nil)
		ObserverService.add(observer: self, selector: #selector(self.topTypeChanged(_:)), notification: .topTypeChanged, object: nil)
	}
	
	deinit {
		ObserverService.remove(observer: self, notification: .addFavorite, object: nil)
		ObserverService.remove(observer: self, notification: .removeFavorite, object: nil)
		ObserverService.remove(observer: self, notification: .topTypeChanged, object: nil)
	}
}

extension TopListViewInteractor: APIServiceProtocol { }
extension TopListViewInteractor: ClientServiceProtocol { }

extension TopListViewInteractor: PresenterToInteractorTopListProtocol {
	func fetchTopList<T: Decodable>(type: TopListType, page: Int, completion: @escaping (GHResult<T>) -> Void) {
		let target = self.api.topList(type: type, page: page)
		self.client.call(target).responseModel { completion($0) }
	}
}

extension TopListViewInteractor {
	@objc private func addFavorite(_ notification: Notification) {
		guard let model = notification.object as? TopModel else { return }
		self.presenter?.modelDidChange(model: model)
	}
	
	@objc private func removeFavorite(_ notification: Notification) {
		guard let model = notification.object as? TopModel else { return }
		self.presenter?.modelDidChange(model: model)
	}
	
	@objc private func topTypeChanged(_ notification: Notification) {
		guard let type = notification.object as? TopListType else { return }
		self.presenter?.typeDidChang(type: type)
	}
}
