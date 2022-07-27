//
//  Album.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 16/07/2022.
//

import Foundation

struct SearchAlbumsResponse: Codable {
    let query: String?
    let albums: Albums?
    let artists: ArtistList?
    let playlists: PlayList?
}

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
    let artists: Artists?
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

struct DateClass: Codable {
    let year: Int?
    let isoString: Date?
}

struct PagingInfo: Codable {
    let nextOffset: Int?
    let limit: Int?
}
