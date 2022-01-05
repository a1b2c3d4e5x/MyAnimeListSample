//
//  UIViewController+Storyboard.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import Foundation
import UIKit

extension UIViewController {
	static func storyboard<T: UIViewController>(in name: String? = nil, with identifier: String? = nil) -> T {
		let storyboard = UIStoryboard(name: name ?? String(describing: T.self), bundle: nil)
		return storyboard.instantiateViewController(withIdentifier: identifier ?? String(describing: T.self)) as! T
	}
}
