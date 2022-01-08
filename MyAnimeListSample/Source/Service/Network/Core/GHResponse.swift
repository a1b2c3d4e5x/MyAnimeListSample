//
//  GHResponse.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/7.
//

import Foundation

enum GHResult<T> {
	case success(T)
	case failure(Error)
	
	init(data: T?, error: Error?) {
		self = (nil == error) ? .success(data!) : .failure(error!)
	}
}

protocol ResponseProtocol {
	func responseModel<U: Decodable>(_ completion: @escaping (GHResult<U>) -> Void)
}

final class Response {
	private let data: GHRequestData
	
	init(data: GHRequestData) {
		self.data = data
	}
}

extension Response: ResponseProtocol {
	func responseModel<U: Decodable>(_ completion: @escaping (GHResult<U>) -> Void) {
		DispatchQueue.global().async {
			switch self.data {
			case .http(let http):
				http.fetchString { data, error in
					DispatchQueue.main.async {
						if let e = error {
							completion(GHResult(data: nil, error: e))
						} else if let rawData = data?.toModel(style: .json, type: U.self) {
							completion(GHResult(data: rawData, error: nil))
						} else {
							completion(GHResult(data: nil, error: GHError.modelMappingError))
						}
					}
				}
				
			case .mock(bundle: let bundle):
				let model = bundle.toModel(style: .bundle, type: U.self)
				DispatchQueue.main.async {
					if let m = model {
						completion(GHResult(data: m, error: nil))
					} else {
						completion(GHResult(data: nil, error: GHError.modelMappingError))
					}
				}
			}
		}
	}
}

protocol GHHttpResponseProtocol {
	func fetchString(completion: @escaping (String?, Error?) -> Void)
}

final class GHHttpResponse {
	private let url: String
	private let method: GHRequestMethod
	private let params: GHRequestParams?
	private let header: GHRequestHeader?
	
	init(url: String, method: GHRequestMethod,
		 params: GHRequestParams? = nil,
		 header: GHRequestHeader? = nil) {
		self.url = url
		self.method = method
		self.params = params
		self.header = header
	}
}

extension GHHttpResponse: GHHttpResponseProtocol {
	func fetchString(completion: @escaping (String?, Error?) -> Void) {
		guard let toUrl = URL(string: self.url) else {
			completion(nil, URLError(.badURL))
			return
		}
		
		var request = URLRequest(url: toUrl)
		request.httpMethod = self.method.rawValue
		
		if let body = self.params {
			request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
		}
		
		if let header = self.header {
			header.forEach { key, value in
				request.addValue(value, forHTTPHeaderField: key)
			}
		}
		
		let sessionConfig = URLSessionConfiguration.default
		sessionConfig.timeoutIntervalForRequest = CONFIG.NETWORK.REQUEST_TIMEOUT
		sessionConfig.timeoutIntervalForResource = CONFIG.NETWORK.RESOURCE_TIMEOUT
		let session = URLSession(configuration: sessionConfig)
		
		let task = session.dataTask(with: request) { data, response, error in
			do {
				if let e = error { throw e }
				if let json = String(data: data!, encoding: .utf8) {
					completion(json, nil)
				} else {
					throw URLError(.cannotParseResponse)
				}
			} catch {
				completion(nil, error)
			}
		}
	
		task.resume()
	}
}
