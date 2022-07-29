//
//  SettingsModel.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 29/07/2022.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
