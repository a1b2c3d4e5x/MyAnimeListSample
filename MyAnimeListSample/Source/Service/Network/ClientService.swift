//
//  ClientService.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/7.
//

protocol ClientServiceProtocol {
	var client: RequestProtocol { get }
}

extension ClientServiceProtocol {
	var client: RequestProtocol {
		return GHRequest()
	}
}
