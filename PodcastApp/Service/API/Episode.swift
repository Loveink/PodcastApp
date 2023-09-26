//
//  Episode.swift
//  PodcastApp
//
//  Created by Александра Савчук on 27.09.2023.
//

import Foundation

struct PodcastEpisode: Codable {
    let status: String
    let liveItems: [String]
    let items: [PodcastItem]
    let count: Int
    let query: String
    let description: String
}

struct PodcastItem: Codable {
    let id: Int
    let title: String
    let link: String
    let description: String
    let guid: String
    let datePublished: Int
    let datePublishedPretty: String
    let dateCrawled: Int
    let enclosureUrl: String
    let enclosureType: String
    let enclosureLength: Int
    let duration: String?
    let explicit: Int
    let episode: String?
    let episodeType: String?
    let season: Int
    let image: String
    let feedItunesId: Int
    let feedImage: String
    let feedId: Int
    let feedLanguage: String
    let feedDead: Int
    let feedDuplicateOf: String?
    let chaptersUrl: String?
    let transcriptUrl: String?
}
