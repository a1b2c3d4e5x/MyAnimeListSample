//
//  Localizator.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import Foundation

final class Localizator {
	static let shared = Localizator()

	func localize(string: String, comment: String = "") -> String {
		return NSLocalizedString(string, comment: comment)
	}
}

protocol XIBLocalizable {
	var xibLocKey: String? { get set }
}
