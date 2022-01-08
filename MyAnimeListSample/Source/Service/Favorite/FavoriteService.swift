//
//  FavoriteService.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/8.
//

import Foundation
import UIKit

protocol ModelManagerProtocol {
	associatedtype Model: Hashable
	var list: [Model] { get }
	var set: Set<Model> { get }
	
	func contains(_ model: ExistMalIDProtocol) -> Bool
	func add(_ model: Model)
	func delete(_ model: Model)
}

final class FavoriteService: ModelManagerProtocol {
	static let shared: FavoriteService = FavoriteService()
	
	typealias Model = TopModel
	
	private var userDefaultService = UserDefaultsService()

	var list: [Model]
	var set: Set<Model>
	
	private init() {
		self.list = self.userDefaultService.favoriteList ?? []
		self.set = Set<Model>(self.list)
	}
}

extension FavoriteService {
	func contains(_ model: ExistMalIDProtocol) -> Bool {
		return self.set.contains { m in
			return m.mal_id == model.mal_id
		}
	}

	func add(_ model: Model) {
		guard false == self.contains(model) else { return }
		
		self.set.insert(model)
		self.list.insert(model, at: 0)

		self.userDefaultService.favoriteList = self.list
	}
	
	func delete(_ model: Model) {
		guard true == self.contains(model) else { return }
		
		self.set.remove(model)
		if let index = self.list.firstIndex(of: model) {
			self.list.remove(at: index)
		}
		
		self.userDefaultService.favoriteList = self.list
	}
}
