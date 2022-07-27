//
//  PlayLists.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 27/07/2022.
//

import Foundation

struct PlayList: Codable {
    let totalCount: Int?
    let items: [PlayListItem]?
    let pagingInfo: PagingInfo?
}

struct PlayListItem: Codable {
    let data: PlayListData?
}

struct PlayListData: Codable {
    let uri, name, dataDescription: String?
    let images: PlayListImages?
    let owner: Owner?
    
    enum CodingKeys: String, CodingKey {
        case uri, name
        case dataDescription = "description"
        case images, owner
    }
}

struct PlayListImages: Codable {
    let items: [PlayListImagesItem]?
}

struct PlayListImagesItem: Codable {
    let sources: [PlayListSource]?
}

struct PlayListSource: Codable {
    let url: String?
    let width, height: Int?
}

struct Owner: Codable {
    let name: String?
}
