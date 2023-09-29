//
//  Podcast.swift
//  PodcastApp
//
//  Created by Александра Савчук on 27.09.2023.
//

import Foundation

struct PodcastResponse: Decodable {
    let status: String
    let feeds: [Podcast]
    let description: String
}

struct Podcast: Decodable {
    let id: Int
    let title: String
    let url: String
//    let originalUrl: String
//    let link: String
    let description: String
    let author: String
    let ownerName: String
    let image: String
    let artwork: String
//    let lastUpdateTime: Int
//    let lastCrawlTime: Int
//    let lastParseTime: Int
//    let inPollingQueue: Int
//    let priority: Int
//    let lastGoodHttpStatusTime: Int
//    let lastHttpStatus: Int
//    let contentType: String
    let itunesId: Int?
//    let generator: String
//    let language: String
//    let type: Int
//    let dead: Int
//    let crawlErrors: Int
//    let parseErrors: Int
    let categories: [String: String]?
//    let locked: Int
//    let explicit: Bool
//    let podcastGuid: String
//    let medium: String
    let episodeCount: Int
//    let imageUrlHash: Int
    let newestItemPubdate: Int
}
