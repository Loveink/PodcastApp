//
//  HomeViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 01.10.2023.
//

import UIKit
import AVFoundation
import CoreData

class HomeViewController: UIViewController {

  let topInfoView = TopInfoView()
  let categoryCollectionView = PopularCollectionView()
  let trendingCollectionView = TrendingCollectionView()
  let categoriesName = CategoriesNames()

  var feeds: [Feed] = []
  var id: [Int] = []

  var standartConstraints = [NSLayoutConstraint]()
  var trendingConstraints = [NSLayoutConstraint]()

  private let categoryPathMappings: [String: String] = [
    "Music": "/podcasts/bymedium?medium=music",
    "На русском": "/podcasts/trending?lang=ru",
    "🔥Popular": "/podcasts/trending?max=30"
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupConstraints()
    fetchPodcasts()
    trendingCollectionView.delegate = self
    categoryCollectionView.delegate = self
    categoriesName.delegateCollectionDidSelect = self
    trendingCollectionView.categoryDictionary = categoryDictionary
  }



  private func setupCollectionView() {
    categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
    trendingCollectionView.translatesAutoresizingMaskIntoConstraints = false
    categoriesName.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(categoryCollectionView)
    view.addSubview(trendingCollectionView)
    view.addSubview(categoriesName)
    view.addSubview(topInfoView)

    NSLayoutConstraint.activate([

      topInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      topInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
      topInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      topInfoView.heightAnchor.constraint(equalToConstant: 70),

      trendingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
      trendingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      trendingCollectionView.topAnchor.constraint(equalTo: topInfoView.bottomAnchor, constant: 10),
      trendingCollectionView.heightAnchor.constraint(equalToConstant: 250),

      categoriesName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
      categoriesName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      categoriesName.topAnchor.constraint(equalTo: trendingCollectionView.bottomAnchor),
      categoriesName.heightAnchor.constraint(equalToConstant: 70),

      categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
      categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      categoryCollectionView.topAnchor.constraint(equalTo: categoriesName.bottomAnchor, constant: 10),
      categoryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }

  func fetchPodcasts() {
    let networkService = NetworkService()

    networkService.fetchData(forPath: "/podcasts/trending?max=30") { [weak self] (result: Result<PodcastSearch, APIError>) in
      guard let self = self else { return }

      switch result {
      case .success(let podcastResponse):
        self.feeds.append(contentsOf: podcastResponse.feeds)

        for podcast in self.feeds {
          let imageURL = podcast.image
          let podcastItem = PodcastItemCell(title: podcast.title, image: imageURL, id: podcast.id, author: podcast.author, categories: podcast.categories)
          self.categoryCollectionView.podcasts.append(podcastItem)
          self.id.append(podcast.id)
        }

      case .failure(let error):
        print("Error: \(error)")
      }
    }
  }

  func likeButtonTapped(forPodcastId id: Int) {
    UserDefaultsManager.shared.setPodcastLiked(forPodcastId: id)
  }
}


// MARK: - constraints
extension HomeViewController {
  private func setupConstraints() {
    categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
    trendingCollectionView.translatesAutoresizingMaskIntoConstraints = false
    categoriesName.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(categoryCollectionView)
    view.addSubview(trendingCollectionView)
    view.addSubview(categoriesName)
    view.addSubview(topInfoView)

    standartConstraints = [
      topInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      topInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
      topInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      topInfoView.heightAnchor.constraint(equalToConstant: 70),

      trendingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
      trendingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      trendingCollectionView.topAnchor.constraint(equalTo: topInfoView.bottomAnchor, constant: 10),
      trendingCollectionView.heightAnchor.constraint(equalToConstant: 250),

      categoriesName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
      categoriesName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      categoriesName.topAnchor.constraint(equalTo: trendingCollectionView.bottomAnchor),
      categoriesName.heightAnchor.constraint(equalToConstant: 70),

      categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
      categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      categoryCollectionView.topAnchor.constraint(equalTo: categoriesName.bottomAnchor, constant: 10),
      categoryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ]

    trendingConstraints = [
      topInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      topInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
      topInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      topInfoView.heightAnchor.constraint(equalToConstant: 70),

      trendingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
      trendingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      trendingCollectionView.topAnchor.constraint(equalTo: topInfoView.bottomAnchor, constant: 10),
      trendingCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ]

    NSLayoutConstraint.activate(standartConstraints)
  }
}


// MARK: - PopularCollectionViewDelegate
extension HomeViewController: PopularCollectionViewDelegate {
  func didSelectPodcast(id: Int) {
    // Check if the podcast with the given ID exists in the feeds array
    guard let selectedFeed = feeds.first(where: { $0.id == id }) else {
      return
    }

    savePodcastToCoreData(selectedFeed)

    let channelVC = ChannelViewController()
    channelVC.channelID = id
    channelVC.channelTitleLabel.text = selectedFeed.title
    channelVC.channelAuthor.text = selectedFeed.author
    channelVC.placeholderImage = UIImage(named: "placeholder_image")

    if let imageURL = URL(string: selectedFeed.image) {
      URLSession.shared.dataTask(with: imageURL) { (data, _, _) in
        if let data = data, let image = UIImage(data: data) {
          DispatchQueue.main.async {
            channelVC.channelImageView.image = image
          }
        }
      }.resume()
    }
    self.navigationController?.pushViewController(channelVC, animated: true)
  }

  private func savePodcastToCoreData(_ podcast: Feed) {
    let imageURL = podcast.image
    let title = podcast.title
    let id = podcast.id
    let author = podcast.author
    if let firstCategory = podcast.categories?.first?.value {
      SaveToCoreData.saveRecentArrayToCoreData(imageURL, title, id, author, firstCategory)
    }
  }

  private func fetchRecentPodcasts() -> [RecentPodcast] {
    var recentPodcasts: [RecentPodcast] = []

    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return recentPodcasts
    }

    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<RecentPodcast> = RecentPodcast.fetchRequest()

    do {
      recentPodcasts = try context.fetch(fetchRequest)
    } catch {
      print("Error fetching recent podcasts: \(error)")
    }

    return recentPodcasts
  }

}



// MARK: - TrendingCollectionViewDelegate
extension HomeViewController: TrendingCollectionViewDelegate {
  func seeAllButtonPressed(_ isSelected: Bool) {
    UIView.animate(withDuration: 0.2, animations: {
      for view in [self.categoryCollectionView, self.categoriesName, self.trendingCollectionView] {
        view.alpha = 0.0
      }
    }) { (_) in

      if isSelected {
        NSLayoutConstraint.deactivate(self.trendingConstraints)
        NSLayoutConstraint.activate(self.standartConstraints)
      } else {
        NSLayoutConstraint.deactivate(self.standartConstraints)
        NSLayoutConstraint.activate(self.trendingConstraints)
      }
      UIView.animate(withDuration: 0.2) {
        for view in [self.trendingCollectionView, self.categoryCollectionView, self.categoriesName] {
          view.alpha = 1.0
        }
      }
    }
  }

  func didSelectPodcastName(_ selectedPodcast: CategoryInfoForCell) {
    let searchVC = SearchResultsViewController(selectedPodcast.categoryName)
    searchVC.searchBar.textField.isEnabled = false
    navigationController?.pushViewController(searchVC, animated: true)
  }
}

extension HomeViewController: CollectionDidSelectProtocol {

  func fetchSearch(categoryName: String) {

    if categoryName == "Recent" {
      let recentPodcasts = self.fetchRecentPodcasts()
      self.categoryCollectionView.podcasts.removeAll()

      for recentPodcast in recentPodcasts {
        let podcastItem = PodcastItemCell(title: recentPodcast.title ?? "", image: recentPodcast.image ?? "", id: Int(recentPodcast.id), author: recentPodcast.author ?? "", categories: nil)
        self.id.append(podcastItem.id)
        self.categoryCollectionView.podcasts.append(podcastItem)
      }
      self.categoryCollectionView.collectionView.reloadData()

    } else {

      let networkService = NetworkService()
      if let path = categoryPathMappings[categoryName] {

        networkService.fetchData(forPath: path) { [weak self] (result: Result<PodcastSearch, APIError>) in
          guard let self = self else { return }

          switch result {
          case .success(let podcastResponse):
            DispatchQueue.main.async {
              self.feeds.append(contentsOf: podcastResponse.feeds)
              self.categoryCollectionView.podcasts.removeAll()

              for podcast in podcastResponse.feeds {
                let imageURL = podcast.image
                let podcastItem = PodcastItemCell(title: podcast.title, image: imageURL, id: podcast.id, author: podcast.author, categories: podcast.categories)
                self.categoryCollectionView.podcasts.append(podcastItem)
                self.id.append(podcast.id)
              }

              self.categoryCollectionView.collectionView.reloadData()
            }

          case .failure(let error):
            print("Error: \(error)")
          }
        }
      }
    }
  }
}
