//
//  GHRequestData.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/7.
//

import Foundation

enum HttpMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case patch = "PATCH"
	case delete = "DELETE"
}

typealias GHRequestMethod = HttpMethod
typealias GHRequestParams = [String: Any]
typealias GHRequestHeader = [String: String]

enum GHRequestData {
	case http(GHHttpResponse)
	case mock(bundle: String)
	
	init(url: String,
		 method: GHRequestMethod,
		 params: GHRequestParams? = nil,
		 header: GHRequestHeader? = nil) {

		let http = GHHttpResponse(url: url, method: method, params: params, header: header)
		self = .http(http)
	}
	
	init(bundle: String) {
		self = .mock(bundle: bundle)
	}
}
