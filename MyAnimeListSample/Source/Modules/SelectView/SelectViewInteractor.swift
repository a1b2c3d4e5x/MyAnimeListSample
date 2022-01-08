//
//  SelectViewInteractor.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/9.
//

import Foundation

final class SelectViewInteractor {
	weak var presenter: InteractorToPresenterSelectViewProtocol? = nil
}

extension SelectViewInteractor: PresenterToInteractorSelectViewProtocol { }
