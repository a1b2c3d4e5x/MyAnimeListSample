//
//  Button+XIBLocalizable.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import UIKit

extension UIButton: XIBLocalizable {
	@IBInspectable var xibLocKey: String? {
		get { return nil }
		set(key) { self.setTitle(key?.localized, for: .normal) }
	}
}
