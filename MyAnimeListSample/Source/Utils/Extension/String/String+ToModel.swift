//
//  String+ToModel.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/7.
//

import UIKit

extension String {
	enum SelfToModelStyle {
		case json
		case bundle
	}
	
	func toModel<T: Decodable>(style: SelfToModelStyle, type: T.Type) -> T? {
		switch style {
		case .json:
			return self.jsonToModel(T.self)
		case .bundle:
			return self.fileToModel(T.self)
		}
	}
}

extension String {
	fileprivate func jsonToModel<T: Decodable>(_ type: T.Type) -> T? {
		let decoder = JSONDecoder()
		return try? decoder.decode(type, from: self.data(using: .utf8)!)
	}

	fileprivate func fileToModel<T: Decodable>(_ type: T.Type) -> T? {
		guard let url = Bundle.main.path(forResource: "mockJson", ofType: "bundle") else { return nil }
		guard let bundle = Bundle(path: url) else { return nil }
		guard let file = bundle.path(forResource: self, ofType: "json") else { return nil }
		guard let json = try? String(contentsOfFile: file, encoding: .utf8) else { return nil }

		return json.jsonToModel(T.self)
	}
}
