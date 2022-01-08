//
//  ExtraTableView.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/5.
//

import UIKit

protocol ExtraTableViewDataSource: UITableViewDataSource {
	func extraView(in tableView: ExtraTableView) -> UIView
}

protocol ExtraTableViewDelegate: UITableViewDelegate {
	func contentWillEnd(in tableView: ExtraTableView)
}

final class ExtraTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
	weak var extraDataSource: ExtraTableViewDataSource? = nil
	weak var extraDelegate: ExtraTableViewDelegate? = nil
	
	private var maxSection: Int = -1
	
	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		self.dataSource = self
		self.delegate = self
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.dataSource = self
		self.delegate = self
	}
	
	lazy var infiniteCell: UITableViewCell = {
		let cell: UITableViewCell = UITableViewCell()
		cell.indicator(start: true)
		return cell
	}()
	
	func numberOfSections(in tableView: UITableView) -> Int {
		self.maxSection = self.extraDataSource?.numberOfSections?(in: self) ?? 1
		return self.maxSection + 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard section == self.maxSection else {
			return self.extraDataSource?.tableView(self, numberOfRowsInSection: section) ?? 0
		}
		
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard indexPath.section == self.maxSection else {
			return self.extraDataSource?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
		}
		
		let cell: UITableViewCell = UITableViewCell()
		guard let extraView: UIView = self.extraDataSource?.extraView(in: self) else {
			return cell
		}
		cell.contentView.embed(child: extraView)
		return cell
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		guard indexPath.section == self.maxSection else {
			self.extraDelegate?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
			return
		}
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		guard indexPath.section == self.maxSection else {
			return self.extraDelegate?.tableView?(tableView, heightForRowAt: indexPath) ?? self.estimatedRowHeight
		}
		return self.extraDataSource?.extraView(in: self).bounds.height ?? CGFloat.leastNonzeroMagnitude
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		guard section == self.maxSection else {
			return self.extraDataSource?.tableView?(tableView, titleForHeaderInSection: section)
		}
		return nil
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard indexPath.section == self.maxSection else {
			self.extraDelegate?.tableView?(tableView, didSelectRowAt: indexPath)
			return
		}
	}
}

extension ExtraTableView: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
			
		if (offsetY > (contentHeight - scrollView.frame.height * 2)) {
			self.extraDelegate?.contentWillEnd(in: self)
		}
	}
}

extension ExtraTableView {
	public func reloadExtraView() {
		let indexPath: IndexPath = IndexPath(row: 0, section: 1)
		self.reloadRows(at: [indexPath], with: .none)
	}
}
