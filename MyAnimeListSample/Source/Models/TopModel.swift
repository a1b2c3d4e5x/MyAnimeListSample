//
//  TopModel.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/7.
//

import Foundation

struct ResponseTopModel: Codable {
	let request_hash: String
	let request_cached: Bool
	let request_cache_expiry: Int
	let top: [TopModel]
}

protocol ExistMalIDProtocol {
	var mal_id: Int { get set }
}

struct TopModel: ExistMalIDProtocol, Codable, Hashable {
	var mal_id: Int
	let rank: Int
	let title: String
	let url: String
	let image_url: String
	let type: String
	let episodes: Int?
	let start_date: String
	let end_date: String?
	let members: Int
	let score: Float
}
