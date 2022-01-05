//
//  URL.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/4.
//

protocol CONFIG_URL {
	var API_DOMAIN: String { get }
}

extension CONFIG_URL {
	var API_DOMAIN: String {
		return "https://api.jikan.moe"
	}
}
