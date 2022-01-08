//
//  InAppWebView.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/8.
//

import Foundation
import UIKit
import WebKit

final class InAppWebView: UIViewController {
	var presenter: ViewToPresenterWebViewProtocol? = nil
	
	lazy var webView: WKWebView = {
		let webView = WKWebView()
		self.view.embed(child: webView)
		return webView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self._initialize()
		self.presenter?.viewDidLoad()
	}
}

extension InAppWebView: PresenterToViewWebViewProtocol {
	func load(url: URL) {
		self.webView.load(URLRequest(url: url))
	}
}

extension InAppWebView {
	private func _initialize() { }
}
