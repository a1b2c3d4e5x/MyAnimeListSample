//
//  UIViewController+Viewable.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/8.
//

import UIKit

protocol Viewable: AnyObject {
	func push(_ vc: UIViewController, animated: Bool)
	func push(_ vcs: [UIViewController], animated: Bool)
	func present(_ vc: UIViewController, animated: Bool, completion: (() -> Void)?)
	func detail(_ vc: UIViewController)
	func pop(animated: Bool)
	func dismiss(animated: Bool, completion: (() -> Void)?)
}

extension Viewable where Self: UIViewController {
	func push(_ vc: UIViewController, animated: Bool) {
		self.navigationController?.pushViewController(vc, animated: animated)
	}
	
	func push(_ vcs: [UIViewController], animated: Bool) {
		if var controllers = self.navigationController?.viewControllers {
			vcs.forEach { (vc) in
				controllers.append(vc)
			}
			self.navigationController?.setViewControllers(controllers, animated: true)
		}
	}

	func present(_ vc: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
		self.present(vc, animated: animated, completion: completion)
	}
	
	func detail(_ vc: UIViewController) {
		self.showDetailViewController(vc, sender: self)
	}

	func pop(animated: Bool) {
		self.navigationController?.popViewController(animated: animated)
	}

	func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
		self.dismiss(animated: animated, completion: completion)
	}
}
