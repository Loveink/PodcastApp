//
//  EpisodeItemCell.swift
//  PodcastApp
//
//  Created by Александра Савчук on 01.10.2023.
//

import Foundation

struct EpisodeItemCell: Decodable {

  let title: String
  let image: String
  let audioURL: String
  let duration: Int
}
