//
//  Artists.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 27/07/2022.
//

import Foundation

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
