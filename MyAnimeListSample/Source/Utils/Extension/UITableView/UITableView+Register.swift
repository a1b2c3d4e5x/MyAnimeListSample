//
//  UITableView+Register.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/7.
//

import UIKit

extension UITableViewCell {
	static var reuseIdentifier: String {
		return String(describing: self)
	}
}

extension UITableView {
	public func register<T: UITableViewCell>(cellNib: T.Type) {
		let nib = UINib(nibName: String(describing: cellNib), bundle: Bundle(for: cellNib))
		self.register(nib, forCellReuseIdentifier: cellNib.reuseIdentifier)
	}
	
	public func register<T: UITableViewCell>(cellClass: T.Type) {
		self.register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
	}
	
	public func dequeue<T: UITableViewCell>(cellClass: T.Type) -> T? {
		return dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier) as? T
	}

	public func dequeue<T: UITableViewCell>(cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier,
											 for: indexPath) as? T else {
			fatalError("Error: cell with id: \(cellClass.reuseIdentifier) for indexPath: \(indexPath) is not \(T.self)")
		}
		return cell
	}
}
