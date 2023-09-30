//
//  Episode.swift
//  PodcastApp
//
//  Created by Александра Савчук on 27.09.2023.
//

import Foundation

struct Episode: Decodable {
    let status: Bool
    let liveItems: [LiveEpisodeItem]?
    let items: [EpisodeItem]
    let count: Int
    let query: String?
    let description: String
}

struct LiveEpisodeItem: Decodable {
    let id: Int
    let title: String
    let link: String
    let description: String
    let guid: String
    let datePublished: TimeInterval
    let datePublishedPretty: String
    let dateCrawled: TimeInterval
    let enclosureUrl: String
    let enclosureType: String
    let enclosureLength: Int
    let startTime: TimeInterval
    let endTime: TimeInterval
    let status: String
    let contentLink: String
    let duration: Int?
    let explicit: Int
    let episode: String?
    let episodeType: String?
    let season: String?
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

struct EpisodeItem: Decodable {
    let id: Int
    let title: String
    let link: String
    let description: String
    let guid: String
    let datePublished: TimeInterval
    let datePublishedPretty: String
    let dateCrawled: TimeInterval
    let enclosureUrl: String
    let enclosureType: String
    let enclosureLength: Int
    let duration: Int?
    let explicit: Int
    let episode: String?
    let episodeType: String?
    let season: String?
    let image: String
    let feedItunesId: Int
    let feedImage: String
    let feedId: Int
    let feedLanguage: String
    let feedDead: Int
    let feedDuplicateOf: String?
    let chaptersUrl: String?
    let transcriptUrl: String?
    let persons: [Person]
    let transcripts: [Transcript]
    let value: Value
}

struct Person: Decodable {
    let id: Int
    let name: String
    let role: String
    let group: String
    let href: String
    let img: String
}

struct Transcript: Decodable {
    let url: String
    let type: String
}

struct Value: Decodable {
    let model: Model
    let destinations: [Destination]
}

struct Model: Decodable {
    let type: String
    let method: String
    let suggested: String
}

struct Destination: Decodable {
    let name: String
    let type: String
    let address: String
    let split: Int
    let customKey: String?
    let customValue: String?
}
