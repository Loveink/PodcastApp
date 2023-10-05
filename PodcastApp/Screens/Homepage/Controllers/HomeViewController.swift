//
//  HomeViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 01.10.2023.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {

  let categoryCollectionView = PopularCollectionView()
  let trendingCollectionView = TrendingCollectionView()
  let categoriesName = CategoriesNames()

  var feeds: [Feed] = []
  var vc: FetchFunc?
  var id: [Int] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupCollectionView()
    vc = FetchFunc(collectionView: categoryCollectionView.collectionView)
    let dispatchGroup = DispatchGroup()
    fetchPodcasts(dispatchGroup: dispatchGroup)
    categoryCollectionView.delegate = self
    trendingCollectionView.categoryDictionary = categoryDictionary
  }

  private func setupCollectionView() {
    categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
    trendingCollectionView.translatesAutoresizingMaskIntoConstraints = false
    categoriesName.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(categoryCollectionView)
    view.addSubview(trendingCollectionView)
    view.addSubview(categoriesName)

    NSLayoutConstraint.activate([
      categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      categoryCollectionView.topAnchor.constraint(equalTo: categoriesName.bottomAnchor),
      categoryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      trendingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      trendingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      trendingCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      trendingCollectionView.heightAnchor.constraint(equalToConstant: 200),

      categoriesName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      categoriesName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      categoriesName.topAnchor.constraint(equalTo: trendingCollectionView.bottomAnchor),
      categoriesName.heightAnchor.constraint(equalToConstant: 55),
    ])
  }


  func fetchPodcasts(dispatchGroup: DispatchGroup) {
    let networkService = NetworkService()
    dispatchGroup.enter()

    networkService.fetchData(forPath: "/podcasts/trending?max=10") { [weak self] (result: Result<PodcastSearch, APIError>) in
      guard let self = self else { return }

      defer {
        dispatchGroup.leave()
      }

      switch result {
      case .success(let podcastResponse):
        self.feeds.append(contentsOf: podcastResponse.feeds)

        for podcast in self.feeds {
          let imageURL = podcast.image
          let podcastItem = PodcastItemCell(title: podcast.title, image: imageURL, id: podcast.id, author: podcast.author, categories: podcast.categories)
          self.categoryCollectionView.podcasts.append(podcastItem)
          id.append(podcast.id)
        }

      case .failure(let error):
        print("Error: \(error)")
      }
    }
  }
}

extension HomeViewController: PopularCollectionViewDelegate {
  func didSelectPodcast(id: Int) {
    let channelVC = ChannelViewController()
    channelVC.channelID = id

    if let index = feeds.firstIndex(where: { $0.id == id }) {
      let selectedFeed = feeds[index]
      channelVC.channelTitleLabel.text = selectedFeed.title
      let imageURLString = selectedFeed.image

      if let imageURL = URL(string: imageURLString) {
        URLSession.shared.dataTask(with: imageURL) { (data, _, _) in
          if let data = data, let image = UIImage(data: data) {
            DispatchQueue.main.async {
              channelVC.channelImageView.image = image
              self.navigationController?.pushViewController(channelVC, animated: true)
            }
          }
        }.resume()
      }
    }
  }
}
