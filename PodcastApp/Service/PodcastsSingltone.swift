//
//  PodcastsSingltone.swift
//  PodcastApp
//
//  Created by Александра Савчук on 01.10.2023.
//

import Foundation

class Music {
  static let shared = Music()
  var podcastResults: [Feed] = []
  var episodeResults: [EpisodeItem] = []
}

struct EpisodeModel1 {
  var title: String
  var length: String
  var url: String
  var imageURL: String
  var category: String
}
