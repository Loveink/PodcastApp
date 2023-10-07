//
//  PlaylistItemCell.swift
//  PodcastApp
//
//  Created by Владимир on 07.10.2023.
//

import Foundation

struct PlaylistItemCell: Decodable {
    let title: String
    let image: String
    let id: Int
    var episodeCounter: Int
    //  var podcasts: [PodcastCell]?
}
