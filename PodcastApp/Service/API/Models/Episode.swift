//
//  Episode.swift
//  PodcastApp
//
//  Created by Александра Савчук on 27.09.2023.
//

import Foundation

struct EpisodeRandom: Decodable {
    let status: String
    let episodes: [EpisodeItem]
    let count: Int
    let max: Int
    let description: String
}

struct EpisodeFeed: Decodable {
    let status: String
    let items: [EpisodeItem]
    let count: Int
    let query: String
    let description: String
}

struct EpisodeItem: Decodable {
    let id: Int
    let title: String
    let link: String
    let description: String
    let enclosureUrl: String
    let enclosureLength: Int
    let image: String
    let feedImage: String
}
