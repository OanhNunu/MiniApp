//
//  AlbumModel.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 18/07/2022.
//

import Foundation

struct Albums: Codable {
    let totalCount: Int?
    let items: [AlbumsItem]?
}

struct AlbumsItem: Codable {
    let data: DataClass?
}

struct DataClass: Codable {
    let uri: String
    let name: String?
    let artists: ArtistList?
    let coverArt: CoverArt?
    let date: DateClass?
}

struct CoverArt: Codable {
    let sources: [Source]?
}

struct Source: Codable {
    let url: String?
    let width: Int?
    let height: Int?
}
