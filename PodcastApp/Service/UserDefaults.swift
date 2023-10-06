//
//  UserDefaults.swift
//  PodcastApp
//
//  Created by Александра Савчук on 06.10.2023.
//

import Foundation


class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    private let likedPodcastsKey = "LikedPodcasts"

    private init() {}

    func isPodcastLiked(forPodcastId podcastId: Int) -> Bool {
        let likedPodcasts = getLikedPodcasts()
        return likedPodcasts.contains(podcastId)
    }

    func setPodcastLiked(forPodcastId podcastId: Int) {
        var likedPodcasts = getLikedPodcasts()
        likedPodcasts.insert(podcastId)
        saveLikedPodcasts(likedPodcasts)
    }

    func removePodcastLiked(forPodcastId podcastId: Int) {
        var likedPodcasts = getLikedPodcasts()
        likedPodcasts.remove(podcastId)
        saveLikedPodcasts(likedPodcasts)
    }

    private func getLikedPodcasts() -> Set<Int> {
        if let likedPodcastsData = UserDefaults.standard.data(forKey: likedPodcastsKey),
           let likedPodcasts = try? JSONDecoder().decode(Set<Int>.self, from: likedPodcastsData) {
            return likedPodcasts
        } else {
            return Set()
        }
    }

    private func saveLikedPodcasts(_ likedPodcasts: Set<Int>) {
        if let likedPodcastsData = try? JSONEncoder().encode(likedPodcasts) {
            UserDefaults.standard.set(likedPodcastsData, forKey: likedPodcastsKey)
        }
    }
}
