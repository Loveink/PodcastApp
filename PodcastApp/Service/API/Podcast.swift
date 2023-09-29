//
//  Podcast.swift
//  PodcastApp
//
//  Created by Александра Савчук on 27.09.2023.
//

import Foundation

struct PodcastSearch: Decodable {
    let status: String
    let feeds: [Feed]
    let description: String
}

struct PodcastResponse: Decodable {
    let status: String
    let feed: Feed
    let description: String
}

struct Feed: Decodable {
    let id: Int
    let title: String
    let url: String
    let description: String
    let author: String
    let image: String
    let categories: [String: String]?
    let episodeCount: Int?
    let medium: String?
}
