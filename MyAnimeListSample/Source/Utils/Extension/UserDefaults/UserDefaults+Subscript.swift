//
//  UserDefaults+Subscript.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/8.
//

import Foundation

extension UserDefaults {
	subscript<T>(key: String) -> T? {
		get { return value(forKey: key) as? T }
		set { set(newValue, forKey: key) }
	}
	
	subscript<T: RawRepresentable>(key: String) -> T? {
		get {
			guard let rawValue = value(forKey: key) as? T.RawValue else { return nil }
			return T(rawValue: rawValue)
		}
		set {
			set(newValue?.rawValue, forKey: key)
		}
	}
}
