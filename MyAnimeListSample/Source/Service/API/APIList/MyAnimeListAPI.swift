//
//  MyAnimeListAPI.swift
//  MyAnimeListSample
//
//  Created by GUO-HAO CHEN on 2022/1/7.
//

enum TopListType {
	case anime(subtype: AnimeSubtype)
	case manga(subtype: MangaSubtype)
	
	enum AnimeSubtype: String, CaseIterable {
		case airing
		case upcoming
		case tv
		case movie
		case ova
		case special
		case bypopularity
		case favorite
	}
	
	enum MangaSubtype: String, CaseIterable {
		case manga
		case novels
		case oneshots
		case doujin
		case manhwa
		case manhua
		case bypopularity
		case favorite
	}
	
	var rawValue: String {
		switch self {
		case .manga(_): return "manga"
		case .anime(_): return "anime"
		}
	}	
}

protocol MyAnimeListAPIProtocol {
	func topList(type: TopListType, page: Int) -> GHRequestData
}

extension MyAnimeListAPIProtocol {
	func topList(type: TopListType, page: Int) -> GHRequestData {
		let tempHeader: GHRequestHeader = [
			"Content-Type": "application/json"
		]
		
		let subtype: String = {
			switch type {
			case .anime(let subtype): return subtype.rawValue
			case .manga(let subtype): return subtype.rawValue
			}
		}()

		let tempUrl = "\(CONFIG.URL.DOMAIN_JIKAN)/v3/top/\(type.rawValue)/\(page)/\(subtype)"
		return GHRequestData(url: tempUrl, method: .get, header: tempHeader)
	}
}
