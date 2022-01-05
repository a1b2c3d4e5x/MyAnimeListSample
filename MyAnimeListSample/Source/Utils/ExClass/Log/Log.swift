//
//  Log.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/4.
//

import Foundation

let Log = GHTool.shared

class GHTool {
	static let shared: GHTool = GHTool()
	private init () { }
}

extension GHTool: GHLogToPrintProtocol { }
