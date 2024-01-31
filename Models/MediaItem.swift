//
//  MediaItem.swift
//  FinalProject
//
//  Created by Zhanna Zhanashova on 23.12.2023.
//

import Foundation
struct MediaItem: Codable, Equatable {
    let trackName: String
    let artworkUrl100: String
    let previewUrl: String?
}
