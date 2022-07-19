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

struct Artists: Codable {
    let items: [ArtistsItem]?
}

struct ArtistList: Codable {
    let items: [ArtistData]?
}

struct ArtistData: Codable {
    let data: ArtistsItem?
}

struct ArtistsItem: Codable {
    let uri: String?
    let profile: Profile?
    let visuals: Visuals?
}

struct Visuals: Codable {
    let avatarImage: AvatarImage?
}

struct AvatarImage: Codable {
    let sources: [Source]?
}

struct Profile: Codable {
    let name: String?
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
