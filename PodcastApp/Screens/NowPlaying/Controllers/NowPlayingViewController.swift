//
//  NowPlayingViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 25.09.2023.
//

import UIKit

class NowPlayingViewController: UIViewController {

  var podcast = PodcastView()
  var galleryViewController = GalleryView()
  var feeds: [Podcast] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white


    let networkService = NetworkService()
    networkService.fetchData(forPath: "/search/byterm?q=bastiat") { (result: Result<PodcastResponse, APIError>) in
        switch result {
        case .success(let podcastResponse):
          self.feeds.append(contentsOf: podcastResponse.feeds)

            for podcast in self.feeds {
                let imageURL = podcast.image
                self.galleryViewController.images.append(imageURL)
            }

            DispatchQueue.main.async {
                self.galleryViewController.collectionView.reloadData()
            }
        case .failure(let error):
            print("Error: \(error)")
        }
      print(self.galleryViewController.images)
    }


    setupConstraints()




  }

  func setupConstraints() {

    galleryViewController.translatesAutoresizingMaskIntoConstraints = false
    podcast.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(galleryViewController)
    view.addSubview(podcast)

    NSLayoutConstraint.activate([
      galleryViewController.topAnchor.constraint(equalTo: view.topAnchor),
      galleryViewController.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      galleryViewController.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      galleryViewController.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),

      podcast.topAnchor.constraint(equalTo: galleryViewController.bottomAnchor, constant: -100),
      podcast.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      podcast.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      podcast.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
