//
//  TableViewCellRouter.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/7.
//

import UIKit

final class TableViewCellRouter { }

extension TableViewCellRouter: PresenterToRouterCellProtocol { }

extension TableViewCellRouter: WireframeCellProtocol {
	static func createModule() -> UITableViewCell {
		let cell = TableViewSmallCell()
		cell.presenter = Self.bind(view: cell)
		return cell
	}
	
	static func bind(view: PresenterToViewCellProtocol) -> ViewToPresenterCellProtocol {
		let interator = TableViewCellInteractor(favoriteService: FavoriteService.shared)
		let router = TableViewCellRouter()
		let presenter = TableViewCellPresenter(view: view, router: router, interactor: interator)
		
		return presenter
	}
}

