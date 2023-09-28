//
//  EpisodeModel.swift
//  PodcastApp
//
//  Created by Анастасия Рыбакова on 28.09.2023.
//

import Foundation

struct EpisodeModel {
    let episodeImageName: String
    let episodeTitle: String
    let episodeNumber: Int
    let episodeDutarion: String
    
    static func makeMockData() -> [Self] {
        [ EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 56, episodeDutarion: "1:20:23"),
          EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 55, episodeDutarion: "1:20:23"),
          EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 54, episodeDutarion: "1:20:23"),
          EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 53, episodeDutarion: "1:20:23"),
          EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 52, episodeDutarion: "1:20:23"),
          EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 51, episodeDutarion: "1:20:23"),
          EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 50, episodeDutarion: "1:20:23"),
          EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 49, episodeDutarion: "1:20:23"),
          EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 48, episodeDutarion: "1:20:23"),
          EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 47, episodeDutarion: "1:20:23"),
          EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 46, episodeDutarion: "1:20:23"),
          EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 45, episodeDutarion: "1:20:23"),
          EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 44, episodeDutarion: "1:20:23"),
          EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 43, episodeDutarion: "1:20:23"),
          EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 42, episodeDutarion: "1:20:23"),
          EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 41, episodeDutarion: "1:20:23"),
          EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 40, episodeDutarion: "1:20:23"),
          EpisodeModel(episodeImageName: "Home", episodeTitle: "The powerful way to move on", episodeNumber: 39, episodeDutarion: "1:20:23"),
        ]
    }
}
