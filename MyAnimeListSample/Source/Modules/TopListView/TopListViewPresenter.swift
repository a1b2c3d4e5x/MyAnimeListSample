//
//  TopListViewPresenter.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import Foundation

final class TopListViewPresenter {
	weak var view: PresenterToViewTopListProtocol? = nil
	var interactor: PresenterToInteractorTopListProtocol
	var router: PresenterToRouterTopListProtocol
	
	private var currentType: TopListType = .anime(subtype: .airing) {
		didSet { self.updateTypeTitle() }
	}
	private var currentPage: Int = 1
	private var isLoading: Bool = false
	private var isAllFinish: Bool = false
	
	private var models: [TopModel]? = nil
	
	init(view: PresenterToViewTopListProtocol,
		 interactor: PresenterToInteractorTopListProtocol,
		 router: PresenterToRouterTopListProtocol) {
		self.view = view
		self.router = router
		self.interactor = interactor
	}
}

extension TopListViewPresenter: ViewToPresenterTopListProtocol {
	func viewDidLoad() {
		self.updateTypeTitle()
		self.reloadDataSource()
	}

	func itemCount() -> Int {
		return self.models?.count ?? 0
	}
	
	func item(at index: Int) -> TopModel? {
		guard self.itemCount() > index else { return nil }
		return self.models?[index]
	}
	
	func tapItem(at index: Int) {
		guard let model = self.item(at: index) else { return }
		self.router.showDetailView(for: model)
	}
	
	func tapFavorite() {
		self.router.showFavoriteListView()
	}
	
	func tapSearch() {
		self.router.showSelectView()
	}
	
	func reloadDataSource() {
		guard false == self.isLoading else { return }
		self.isLoading = true
		self.isAllFinish = false

		self.models = nil
		self.view?.showLoadingView()
		self.fetchList(page: 1, reset: true) { [weak self] isSucceed in
			switch isSucceed {
			case true:
				self?.view?.reloadData()
			case false:
				self?.view?.showEmptyView()
				self?.isAllFinish = true
			}
			self?.isLoading = false
		}
	}
	
	func moreDataSource() {
		guard false == self.isLoading, false == self.isAllFinish else { return }
		self.isLoading = true
		
		let count: Int = self.itemCount()
		self.view?.showLoadingView()
		self.fetchList(page: self.currentPage, reset: false) { [weak self] isSucceed in
			switch isSucceed {
			case true:
				self?.view?.appendData(lastCount: count)
				self?.currentPage += 1
			case false:
				self?.view?.showEmptyView()
				self?.isAllFinish = true
			}
			self?.isLoading = false
		}
	}
}

extension TopListViewPresenter: InteractorToPresenterTopListProtocol {
	func modelDidChange(model: TopModel) {
		guard let index = self.models?.firstIndex(of: model) else { return }
		self.view?.reloadData(at: index)
	}
	
	func typeDidChang(type: TopListType) {
		self.models = nil
		self.isLoading = true
		self.isAllFinish = false
		self.view?.reloadData()
		
		self.currentType = type
		
		self.fetchList(page: self.currentPage, reset: true) { [weak self] isSucceed in
			switch isSucceed {
			case true:
				self?.view?.reloadData()
			case false:
				self?.view?.showEmptyView()
				self?.isAllFinish = true
			}
			self?.isLoading = false
		}
	}
}

extension TopListViewPresenter {
	private func updateTypeTitle() {
		let subtype: String = {
			switch self.currentType {
			case .anime(let subtype): return subtype.rawValue
			case .manga(let subtype): return subtype.rawValue
			}
		}()
		self.view?.setCurrentDetail(for: self.currentType.rawValue, subtype: subtype)
	}
	
	private func fetchList(page: Int, reset: Bool, completion: @escaping (Bool) -> Void) {
		DispatchQueue.global().async {
			self.interactor.fetchTopList(type: self.currentType, page: page) { (response: GHResult<ResponseTopModel>) in
				DispatchQueue.main.async { [weak self] in
					switch response {
					case .failure(let error):
						Log.print(error)
						completion(false)

					case .success(let result):
						if true == reset {
							self?.models = result.top
						} else {
							self?.models?.append(contentsOf: result.top)
						}
						
						completion(true)
					}
				}
			}
		}
	}
}

