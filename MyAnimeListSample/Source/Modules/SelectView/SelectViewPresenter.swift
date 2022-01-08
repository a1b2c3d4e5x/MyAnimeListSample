//
//  SelectViewPresenter.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/9.
//

import Foundation
import UIKit

final class SelectViewPresenter {
	weak var view: PresenterToViewSelectViewProtocol? = nil
	var interactor: PresenterToInteractorSelectViewProtocol
	var router: PresenterToRouterSelectViewProtocol
	
	init(view: PresenterToViewSelectViewProtocol,
		 interactor: PresenterToInteractorSelectViewProtocol,
		 router: PresenterToRouterSelectViewProtocol) {
		self.view = view
		self.router = router
		self.interactor = interactor
	}
}

extension SelectViewPresenter: ViewToPresenterSelectViewProtocol {
	func viewDidLoad() {
		self.view?.setGoButton(enable: false)
		self.view?.setSubTypeButton(enable: false)
		
		self.createTypeActions()
	}
	
	func tapGo(with type: String, with subtype: String) {
		if let type: TopListType? = {
			switch type {
			case "anime":
				return TopListType.anime(subtype: TopListType.AnimeSubtype(rawValue: subtype)!)
			case "manga":
				return TopListType.manga(subtype: TopListType.MangaSubtype(rawValue: subtype)!)
			default:
				return nil
			}
		}() {
			ObserverService.post(notification: .topTypeChanged, object: type, userInfo: nil)
			self.router.dismiss()
		}
	}
}

extension SelectViewPresenter: InteractorToPresenterSelectViewProtocol { }

extension SelectViewPresenter {
	private func createTypeActions() {
		let animeAction = self.createAnimeTypeAction()
		let mangaAction = self.createMangaTypeAction()
		
		self.view?.setTypeButton(actions: [animeAction, mangaAction])
	}
	
	private func createAnimeTypeAction() -> UIAction {
		let title: String = "anime"
		return UIAction(title: title) { [weak self] _ in
			self?.view?.setTypeButton(text: title)
			self?.view?.setSubTypeButton(text: "Option".localized)
			self?.view?.setSubTypeButton(enable: true)
			self?.view?.setGoButton(enable: false)
			   
			let items = TopListType.AnimeSubtype.allCases.map { subtype in
				return UIAction(title: subtype.rawValue) { [weak self] action in
					self?.view?.setSubTypeButton(text: action.title)
					self?.view?.setGoButton(enable: true)
				}
			}
			
			self?.view?.setSubTypeButton(actions: items)
		}
	}
	
	private func createMangaTypeAction() -> UIAction {
		let title: String = "manga"
		return UIAction(title: title) { [weak self] _ in
			self?.view?.setTypeButton(text: title)
			self?.view?.setSubTypeButton(text: "Option".localized)
			self?.view?.setSubTypeButton(enable: true)
			self?.view?.setGoButton(enable: false)
			   
			let items = TopListType.MangaSubtype.allCases.map { subtype in
				return UIAction(title: subtype.rawValue) { [weak self] action in
					self?.view?.setSubTypeButton(text: action.title)
					self?.view?.setGoButton(enable: true)
				}
			}
			
			self?.view?.setSubTypeButton(actions: items)
		}
	}
}
