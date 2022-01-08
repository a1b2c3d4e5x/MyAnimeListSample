//
//  UserDefaultService.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/8.
//

import Foundation
import UIKit

final class UserDefaultsService: NSObject {
	enum UDSType: String {
		case favoriteList
	}
	
	private var observes: [String: (Any?) -> Void] = [:]
	
	deinit {
		self.observes.forEach { (key, _) in
			UserDefaults.standard.removeObserver(self, forKeyPath: key)
		}
	}
}

extension UserDefaultsService {
	func observe(key: UDSType, options: NSKeyValueObservingOptions, changeHandler: @escaping (Any?) -> Void) {
		guard false == self.observes.keys.contains(key.rawValue) else { return }
		
		self.observes[key.rawValue] = changeHandler
		UserDefaults.standard.addObserver(self, forKeyPath: key.rawValue, options: options, context: nil)
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		guard let key = keyPath else { return }
		guard let handler = self.observes[key] else { return }
		handler(change?[.newKey])
	}
	
	var favoriteList: [TopModel]? {
		get {
			guard let encoded = UserDefaults.standard[UDSType.favoriteList.rawValue] as Data? else { return nil }
			return try? JSONDecoder().decode([TopModel].self, from: encoded)
		}
		set(models) {
			guard let topModels = models else {
				UserDefaults.standard.removeObject(forKey: UDSType.favoriteList.rawValue)
				return
			}
			
			let encoded = try? JSONEncoder().encode(topModels)
			UserDefaults.standard[UDSType.favoriteList.rawValue] = encoded
		}
	}
}

