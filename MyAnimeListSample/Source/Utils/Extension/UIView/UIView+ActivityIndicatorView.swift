//
//  UIView+ActivityIndicatorView.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/6.
//

import UIKit

protocol ViewIndicator {
	func indicator(start: Bool)
}

extension ViewIndicator where Self: UIView {
	func indicator(start: Bool) {
		(true == start) ? self._startIndicator() : self._stopIndicator()
	}
	
	fileprivate func _startIndicator() {
		self._stopIndicator()
		
		let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
		indicator.hidesWhenStopped = true
		indicator.tag = self.hash
		
		self.addSubview(indicator)
		indicator.translatesAutoresizingMaskIntoConstraints = false
		indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		
		indicator.startAnimating()
	}
	
	fileprivate func _stopIndicator() {
		self.subviews.forEach { (view) in
			if view.tag == (view as? UIActivityIndicatorView)?.hash {
				view.removeFromSuperview()
			}
		}
	}
}

extension UIView: ViewIndicator {}
