//
//  ErrorModel.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/7.
//

import Foundation

struct ErrorModel: Codable {
	let status: Int
	let type: String
	let message: String
	let error: String?
	let trace: String?
	let report_url: String?
}
