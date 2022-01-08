//
//  TopListViewInteractorTests.swift
//  MyAnimeListSampleTests
//
//  Created by GUO-HAO CHEN on 2022/1/9.
//

import XCTest
@testable import MyAnimeListSample

extension TopListViewInteractor {
	var api: APIListProtocol {
		return MockAPIList()
	}
}

class MockAPIList: APIListProtocol {
	func topList(type: TopListType, page: Int) -> GHRequestData {
		return GHRequestData(bundle: "FetchTopListSuccess")
	}
}

class MockPresenter: InteractorToPresenterTopListProtocol {
	var interactor: PresenterToInteractorTopListProtocol
	
	let modelSource = "Rank1TopModelSuccess".toModel(style: .bundle, type: TopModel.self)!
	let typeSource = TopListType.manga(subtype: .novels)
	
	init(interactor: PresenterToInteractorTopListProtocol) {
		self.interactor = interactor
	}
	
	func modelDidChange(model: TopModel) {
		XCTAssertEqual(self.modelSource, model)
	}
	
	func typeDidChang(type: TopListType) {
		XCTAssertEqual(self.typeSource, type)
	}
}

class TopListViewInteractorTests: XCTestCase {
	var sut: TopListViewInteractor? = nil
	var presenter: MockPresenter? = nil
	
	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
		let interactor = TopListViewInteractor()
		self.presenter = MockPresenter(interactor: interactor)
		interactor.presenter = self.presenter
		self.sut = interactor
	}

	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}

	func testParseModelSuccess() throws {
		let type = TopListType.anime(subtype: .upcoming)
		self.sut?.fetchTopList(type: type, page: 1, completion: { (response: GHResult<ResponseTopModel>) in
			switch response {
			case .failure(let error):
				XCTFail(error.localizedDescription)

			case .success(let result):
				XCTAssertNotNil(result)
			}
		})
	}
	
	func testReceiveAddFavoriteNotification() throws {
		let name = NSNotification.Name(rawValue: "ObserverService.addFavorite")
		let e = XCTNSNotificationExpectation(name: name, object: nil, notificationCenter: .default)
		e.notificationCenter.post(name: name, object: self.presenter?.modelSource, userInfo: nil)
		wait(for: [e], timeout: 0.5)
	}
	
	func testReceiveRemoveFavoriteNotification() throws {
		let name = NSNotification.Name(rawValue: "ObserverService.removeFavorite")
		let e = XCTNSNotificationExpectation(name: name, object: nil, notificationCenter: .default)
		e.notificationCenter.post(name: name, object: self.presenter?.modelSource, userInfo: nil)
		wait(for: [e], timeout: 0.5)
	}
	
	func testReceiveTopTypeChangedNotification() throws {
		let name = NSNotification.Name(rawValue: "ObserverService.topTypeChanged")
		let e = XCTNSNotificationExpectation(name: name, object: nil, notificationCenter: .default)
		e.notificationCenter.post(name: name, object: self.presenter?.typeSource, userInfo: nil)
		wait(for: [e], timeout: 0.5)
	}

	func testPerformanceExample() throws {
		// This is an example of a performance test case.
		self.measure {
			// Put the code you want to measure the time of here.
		}
	}

}
