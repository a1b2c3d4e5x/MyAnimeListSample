//
//  String+Localized.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

extension String {
	var localized: String {
		return Localizator.shared.localize(string: self)
	}
}
