//
//  TopListViewController.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import Foundation
import UIKit

final class TopListViewController: UIViewController {
	var presenter: ViewToPresenterTopListProtocol? = nil
	
	@IBOutlet weak var tableView: ExtraTableView!

	enum TailViewStyle {
		case loading
		case empty
	}
	var tailView: TailViewStyle = .loading {
		didSet { self.tableView.reloadExtraView() }
	}
	
	lazy var emptyView: UILabel = {
		let size: CGSize = CGSize(width: tableView.bounds.width, height: 150)
		let label = UILabel(frame: CGRect(origin: .zero, size: size))
		label.text = "Oh! It is no more date!".localized
		label.numberOfLines = 0
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 20)
		return label
	}()
	
	lazy var loadingView: UIView = {
		let size: CGSize = CGSize(width: self.tableView.bounds.width, height: 150)
		let view: UIView = UIView(frame: CGRect(origin: .zero, size: size))
		view.indicator(start: true)
		return view
	}()
	
	private var currentTitle: String? = nil
	
	override func viewDidLoad() {
		self._initialize()
		self.presenter?.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.presenter?.viewWillAppear()
	}
	
	@IBAction func tapFavorite(_ sender: UIBarButtonItem) {
		self.presenter?.tapFavorite()
	}
	
	@IBAction func tapSearch(_ sender: UIBarButtonItem) {
		self.presenter?.tapSearch()
	}
}

extension TopListViewController: PresenterToViewTopListProtocol {
	func reloadData() {
		self.tableView.reloadData()
	}
	
	func reloadData(at index: Int) {
		let indexPath = IndexPath(item: index, section: 0)
		self.tableView.reloadRows(at: [indexPath], with: .none)
	}
	
	func appendData(lastCount: Int) {
		let total: Int = self.presenter?.itemCount() ?? 0
		var indexPaths: [IndexPath] = []
		for i in lastCount ..< total {
			indexPaths.append(IndexPath(row: i, section: 0))
		}

		self.tableView.insertRows(at: indexPaths, with: .automatic)
	}
	
	func showEmptyView() {
		self.tailView = .empty
	}
	
	func showLoadingView() {
		self.tailView = .loading
	}
	
	func setCurrentDetail(for type: String, subtype: String) {
		self.currentTitle = "type: \(type) / subtype: \(subtype)"
	}
}

extension TopListViewController: ExtraTableViewDataSource, ExtraTableViewDelegate {
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
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		guard let title = self.currentTitle else { return nil }
		return "   \(title)"
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.presenter?.tapItem(at: indexPath.row)
	}
	
	func extraView(in tableView: ExtraTableView) -> UIView {
		switch self.tailView {
		case .loading: return self.loadingView
		case .empty: return self.emptyView
		}
	}
	
	func contentWillEnd(in tableView: ExtraTableView) {
		self.presenter?.moreDataSource()
	}
}

extension TopListViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height

		if (offsetY > contentHeight - scrollView.frame.height * 4) {
			self.presenter?.moreDataSource()
		}
	}
}

extension TopListViewController: Viewable { }
extension TopListViewController {
	private func _initialize() {
		self.tableView.extraDataSource = self
		self.tableView.extraDelegate = self
		self.tableView.estimatedRowHeight = 180
		self.tableView.rowHeight = 180
		
		self.tableView.register(cellNib: TableViewSmallCell.self)
	}
}

