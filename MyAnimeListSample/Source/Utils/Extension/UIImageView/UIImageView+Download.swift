//
//  UIImageView+Download.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/8.
//

import UIKit

extension UIImageView {
	func downloaded(from url: URL, placeholder: UIImage? = nil) {
		self.image = nil
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
				else {
					self.image = placeholder
					return
				}
			DispatchQueue.main.async() {
				self.image = image
			}
		}.resume()
	}
	
	func downloaded(from link: String, placeholder: UIImage? = nil) {
		guard let url = URL(string: link) else {
			self.image = placeholder
			return
		}
		self.downloaded(from: url, placeholder: placeholder)
	}
}
