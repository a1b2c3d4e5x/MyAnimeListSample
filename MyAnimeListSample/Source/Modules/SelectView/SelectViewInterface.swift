//
//  SelectViewInterface.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/9.
//

import Foundation
import UIKit

protocol WireframeSelectViewProtocol: AnyObject {
	static func createModule() -> SelectViewController
}

protocol PresenterToRouterSelectViewProtocol: AnyObject {
	func dismiss()
}

protocol PresenterToInteractorSelectViewProtocol: AnyObject {
}

protocol PresenterToViewSelectViewProtocol: AnyObject {
	func setTypeButton(enable: Bool)
	func setTypeButton(text: String)
	func setTypeButton(actions: [UIAction])
	
	func setSubTypeButton(enable: Bool)
	func setSubTypeButton(text: String)
	func setSubTypeButton(actions: [UIAction])
	
	func setGoButton(enable: Bool)
}

protocol InteractorToPresenterSelectViewProtocol: AnyObject {
}

protocol ViewToPresenterSelectViewProtocol: AnyObject {
	func viewDidLoad()
	func viewWillAppear()
	
	func tapGo(with type: String, with subtype: String)
}

extension ViewToPresenterSelectViewProtocol {
	func viewDidLoad() {}
	func viewWillAppear() {}
}
