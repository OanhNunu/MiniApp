//
//  AlbumModel.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 18/07/2022.
//

import Foundation

struct AlbumsResponse: Codable {
    let albums: [AlbumModel]?
}

struct AlbumModel: Codable {
    let albumType: String?
    let artists: [Artist]?
    let copyrights: [Copyright]?
    let externalIDS: ExternalIDS?
    let externalUrls: ExternalUrls?
    let id: String?
    let images: [Image]?
    let label, name: String?
    let popularity: Int?
    let releaseDate, releaseDatePrecision: String?
    let totalTracks: Int?
    let tracks: Tracks?
    let type, uri: String?

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists, copyrights
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case id, images, label, name, popularity
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case tracks, type, uri
    }
}

struct Artist: Codable {
    let externalUrls: ExternalUrls?
    let id, name, type, uri: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case id, name, type, uri
    }
}

struct ExternalUrls: Codable {
    let spotify: String?
}

struct Copyright: Codable {
    let text, type: String?
}

struct ExternalIDS: Codable {
    let upc: String?
}

struct Image: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

struct Tracks: Codable {
    let items: [Item]?
    let limit: Int?
    let offset: Int?
    let total: Int?
}

struct Item: Codable {
    let artists: [Artist]?
    let discNumber, durationMS: Int?
    let explicit: Bool?
    let externalUrls: ExternalUrls?
    let id: String?
    let isLocal, isPlayable: Bool?
    let name: String?
    let previewURL: String?
    let trackNumber: Int?
    let type, uri: String?

    enum CodingKeys: String, CodingKey {
        case artists
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalUrls = "external_urls"
        case id
        case isLocal = "is_local"
        case isPlayable = "is_playable"
        case name
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
    }
}
