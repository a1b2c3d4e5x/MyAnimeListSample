//
//  ObserverService.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/8.
//

import Foundation

protocol Notifier {
	associatedtype NotificationName: RawRepresentable
}

extension Notifier where NotificationName.RawValue == String {
	internal static func nameFor(notification: NotificationName) -> String {
		return "\(self).\(notification.rawValue)"
	}
}

class ObserverService: Notifier {
	static func post(notification: NotificationName, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
		let name = NSNotification.Name(rawValue: nameFor(notification: notification))
		NotificationCenter.default.post(name: name, object: object, userInfo: userInfo)
	}
	
	static func add(observer: AnyObject, selector: Selector, notification: NotificationName, object: Any? = nil) {
		let name = NSNotification.Name(rawValue: nameFor(notification: notification))
		NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
	}
	
	static func remove(observer: AnyObject, notification: NotificationName, object: Any? = nil) {
		let name = NSNotification.Name(rawValue: nameFor(notification: notification))
		NotificationCenter.default.removeObserver(observer, name: name, object: object)
	}
}

extension ObserverService {
	enum NotificationName: String {
		case addFavorite
		case removeFavorite
	}
}
