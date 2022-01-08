//
//  SelectViewController.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/9.
//

import Foundation
import UIKit

class SelectViewController: UIViewController {
	@IBOutlet weak var firstPullDownButton: UIButton!
	@IBOutlet weak var secondPullBownButton: UIButton!
	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var subtypeLabel: UILabel!
	@IBOutlet weak var goButton: UIButton!
	
	override func viewDidLoad() {
		self.goButton.isEnabled = false
		self.secondPullBownButton.isEnabled = false
		
		let anime = UIAction(title: "anime") { [weak self] _ in
			self?.firstPullDownButton.setTitle("anime", for: .normal)
			self?.secondPullBownButton.setTitle("Option".localized, for: .normal)
			self?.secondPullBownButton.isEnabled = true
			self?.goButton.isEnabled = false
			let items = TopListType.AnimeSubtype.allCases.map { subtype in
				return UIAction(title: subtype.rawValue) { [weak self] action in
					self?.secondPullBownButton.setTitle(action.title, for: .normal)
					self?.goButton.isEnabled = true
				}
			}
			self?.secondPullBownButton.menu = UIMenu(title: "Subtype", children: items)
			self?.secondPullBownButton.showsMenuAsPrimaryAction = true
		}
		
		let manga = UIAction(title: "manga") { [weak self] _ in
			self?.firstPullDownButton.setTitle("manga", for: .normal)
			self?.secondPullBownButton.setTitle("Option".localized, for: .normal)
			self?.secondPullBownButton.isEnabled = true
			self?.goButton.isEnabled = false
			let items = TopListType.MangaSubtype.allCases.map { subtype in
				return UIAction(title: subtype.rawValue) { [weak self] action in
					self?.secondPullBownButton.setTitle(action.title, for: .normal)
					self?.goButton.isEnabled = true
				}
			}
			self?.secondPullBownButton.menu = UIMenu(title: "Subtype", children: items)
			self?.secondPullBownButton.showsMenuAsPrimaryAction = true
		}
		
		
		let menu = UIMenu(title: "Type", children: [anime, manga])
		self.firstPullDownButton.menu = menu
		self.firstPullDownButton.showsMenuAsPrimaryAction = true
	}
	
	@IBAction func tapGo(_ sender: UIButton) {
		guard let typeTitle = self.firstPullDownButton.currentTitle else { return }
		guard let subtypeTitle = self.secondPullBownButton.currentTitle else { return }

		if let type: TopListType? = {
			switch typeTitle {
			case "anime":
				return TopListType.anime(subtype: TopListType.AnimeSubtype(rawValue: subtypeTitle)!)
			case "manga":
				return TopListType.manga(subtype: TopListType.MangaSubtype(rawValue: subtypeTitle)!)
			default:
				return nil
			}
		}() {
			ObserverService.post(notification: .topTypeChanged, object: type, userInfo: nil)
			self.dismiss(animated: true, completion: nil)
		}
	}
}
