//
//  UIView+Embed.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/6.
//

import UIKit

extension UIView {
	func embed(child: UIView, atIndex: Int? = nil) {
		child.translatesAutoresizingMaskIntoConstraints = false
		
		if let index = atIndex {
			self.insertSubview(child, at: index)
		} else {
			self.addSubview(child)
		}
		
		NSLayoutConstraint.activate([
			child.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
			child.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
			child.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
			child.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
			])
	}
}
