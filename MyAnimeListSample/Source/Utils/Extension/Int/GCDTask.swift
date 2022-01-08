//
//  GCDTask.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/6.
//

import Foundation

protocol GCDTaskProtocol {
	func start()
	func cancel()
}

final class GCDTask {
	private var task: (() -> Void)? = nil
	private var time: TimeInterval? = nil
	
	init(time: TimeInterval? = nil, task: @escaping () -> Void) {
		self.task = task
		self.time = time
	}
}

extension GCDTask: GCDTaskProtocol {
	func start() {
		guard nil != self.task else {
			return
		}
		guard let ti = self.time else {
			DispatchQueue.main.async(execute: self.finish)
			return
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + ti, execute: self.finish)
	}
	
	func cancel() {
		self.task = nil
	}
}

extension GCDTask {
	fileprivate func finish() {
		self.task?()
		self.task = nil
	}
}
