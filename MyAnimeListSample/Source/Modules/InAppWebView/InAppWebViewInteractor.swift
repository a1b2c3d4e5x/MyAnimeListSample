//
//  InAppWebViewInteractor.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/8.
//

import Foundation

final class InAppWebViewInteractor {
	weak var presenter: InteractorToPresenterWebViewProtocol? = nil
}

extension InAppWebViewInteractor: PresenterToInteractorWebViewProtocol { }
