//
//  Int+Delay.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/6.
//

import Foundation

extension Int {
	@discardableResult
	func delay(task: @escaping () -> Void) -> GCDTaskProtocol {
		let time: TimeInterval = TimeInterval(self)
		let result: GCDTaskProtocol = GCDTask(time: time, task: task)
		result.start()
		return result
	}
}
