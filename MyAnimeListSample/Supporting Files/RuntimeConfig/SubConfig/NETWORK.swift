//
//  NETWORK.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/8.
//

import Foundation

final class CONFIG_NETWORK {
	static var shared: CONFIG_NETWORK = CONFIG_NETWORK()
	
	var REQUEST_TIMEOUT: TimeInterval = 15.0
	var RESOURCE_TIMEOUT: TimeInterval = 30.0
}

