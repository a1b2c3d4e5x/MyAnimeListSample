//
//  FavoriteListViewController.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import Foundation
import UIKit

final class FavoriteListViewController: UIViewController {
	var presenter: ViewToPresenterFavoriteListProtocol? = nil
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		self._initialize()
		self.presenter?.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.presenter?.viewWillAppear()
	}
}

extension FavoriteListViewController: PresenterToViewFavoriteListProtocol {
	func reloadData() {
		self.tableView.reloadData()
	}
	
	func deleteData(at index: Int) {
		let indexPath = IndexPath(item: index, section: 0)
		self.tableView.deleteRows(at: [indexPath], with: .automatic)
	}
}

extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.presenter?.itemCount() ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return tableView.dequeue(cellClass: TableViewSmallCell.self) ?? TableViewSmallCell()
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		guard let model = self.presenter?.item(at: indexPath.row) else { return }
		guard let smallCell = cell as? TableViewSmallCell else { return }
		smallCell.setup(model: model)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.presenter?.tapItem(at: indexPath.row)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard .delete == editingStyle else { return }

		let generator = UIImpactFeedbackGenerator(style: .light)
		generator.impactOccurred()

		self.presenter?.removeFavorite(at: indexPath.row)
	}
	
	func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
		return "Delete".localized
	}
}

extension FavoriteListViewController: Viewable { }
extension FavoriteListViewController {
	private func _initialize() {
		self.tableView.dataSource = self
		self.tableView.delegate = self
		self.tableView.rowHeight = 180
		
		self.tableView.register(cellNib: TableViewSmallCell.self)
	}
}

