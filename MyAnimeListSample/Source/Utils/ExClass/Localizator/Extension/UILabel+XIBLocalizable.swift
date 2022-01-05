//
//  UILabel+XIBLocalizable.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import UIKit

extension UILabel: XIBLocalizable {
	@IBInspectable var xibLocKey: String? {
		get { return nil }
		set(key) { self.text = key?.localized }
	}
}
