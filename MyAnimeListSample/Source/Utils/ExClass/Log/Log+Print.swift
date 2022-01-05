//
//  Log+Print.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/4.
//

import Foundation

protocol GHLogToPrintProtocol {
	func print(
		_ items: Any...,
		file: String,
		line: Int)
}

extension GHLogToPrintProtocol {
	public func print(
		_ items: Any...,
		file: String = #file,
		line: Int = #line
		) {
		#if DEBUG
		let output = items.map { "\($0)" }.joined(separator: " ")
		let fileName = ((file as NSString).lastPathComponent).split(separator: ".").first
		Swift.print("🪲 [\(fileName!), \(line)]:\n", output, terminator: "\n")
		#endif
	}
}
