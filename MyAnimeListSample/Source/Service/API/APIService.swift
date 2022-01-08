//
//  APIService.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/7.
//

protocol APIServiceProtocol {
	var api: APIListProtocol { get }
}
extension APIServiceProtocol {
	var api: APIListProtocol { return APIService.shared }
}

struct APIService {
	static let shared = APIService()
}
extension APIService: APIListProtocol { }

protocol APIListProtocol: MyAnimeListAPIProtocol { }
