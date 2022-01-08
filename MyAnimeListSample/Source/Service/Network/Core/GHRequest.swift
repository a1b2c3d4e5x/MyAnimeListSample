//
//  GHRequest.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/7.
//

import Foundation

protocol RequestProtocol {
	func call(_ api: GHRequestData) -> ResponseProtocol
}

extension RequestProtocol {
	func call(_ api: GHRequestData) -> ResponseProtocol {
		return Response(data: api)
	}
}

final class GHRequest { }
extension GHRequest: RequestProtocol { }
