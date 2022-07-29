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


struct DateClass: Codable {
    let year: Int?
    let isoString: Date?
}

struct PagingInfo: Codable {
    let nextOffset: Int?
    let limit: Int?
}
