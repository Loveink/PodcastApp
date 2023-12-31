//
//  PodcastItem.swift
//  PodcastApp
//
//  Created by Александра Савчук on 29.09.2023.
//

import Foundation

struct PodcastItemCell: Decodable {

  let title: String
  let image: String
  let id: Int
  let author: String
  let categories: [String: String]?
}
