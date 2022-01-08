//
//  SelectViewController.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/9.
//

import Foundation
import UIKit

final class SelectViewController: UIViewController {
	var presenter: ViewToPresenterSelectViewProtocol? = nil
	
	@IBOutlet weak var firstPullDownButton: UIButton!
	@IBOutlet weak var secondPullBownButton: UIButton!
	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var subtypeLabel: UILabel!
	@IBOutlet weak var goButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.presenter?.viewDidLoad()
	}
	
	@IBAction func tapGo(_ sender: UIButton) {
		guard let typeTitle = self.firstPullDownButton.currentTitle else { return }
		guard let subtypeTitle = self.secondPullBownButton.currentTitle else { return }
		
		self.presenter?.tapGo(with: typeTitle, with: subtypeTitle)
	}
}

extension SelectViewController: Viewable { }

extension SelectViewController: PresenterToViewSelectViewProtocol {
	func setTypeButton(enable: Bool) {
		self.firstPullDownButton.isEnabled = enable
	}
	
	func setTypeButton(text: String) {
		self.firstPullDownButton.setTitle(text, for: .normal)
	}
	
	func setTypeButton(actions: [UIAction]) {
		self.firstPullDownButton.menu = UIMenu(title: "Subtype", children: actions)
		self.firstPullDownButton.showsMenuAsPrimaryAction = true
	}
	
	func setSubTypeButton(enable: Bool) {
		self.secondPullBownButton.isEnabled = enable
	}
	
	func setSubTypeButton(text: String) {
		self.secondPullBownButton.setTitle(text, for: .normal)
	}
	
	func setSubTypeButton(actions: [UIAction]) {
		self.secondPullBownButton.menu = UIMenu(title: "Subtype", children: actions)
		self.secondPullBownButton.showsMenuAsPrimaryAction = true
	}
	
	func setGoButton(enable: Bool) {
		self.goButton.isEnabled = enable
	}
}
