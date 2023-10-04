//
//  HomeViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 01.10.2023.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController, CategoriesCollectionViewDelegate {

  func didSelectRecipe(id: Int) {
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
                  } else {
                  }
              }.resume()
          }
      }
  }


  var audioPlayer: AVAudioPlayer?
  var musicArray: [String] = []
  private let categoryCollectionView = CategoriesCollectionView()
  var feeds: [Feed] = []
  var vc: FetchFunc?
  var id: [Int] = []
  var selectedIndexPath: IndexPath?
  private let musicPlayer = MusicPlayer.instance
  private let miniPlayerVC = MiniPlayerVC()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupCollectionView()
    vc = FetchFunc(collectionView: categoryCollectionView.collectionView)
    let dispatchGroup = DispatchGroup()
    fetchPodcasts(dispatchGroup: dispatchGroup)
    dispatchGroup.notify(queue: .main) {
      print("All tasks are completed.")
    }
      categoryCollectionView.delegate = self
  }

  private func setupCollectionView() {
    categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(categoryCollectionView)
    NSLayoutConstraint.activate([
      categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      categoryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      categoryCollectionView.heightAnchor.constraint(equalToConstant: 300),
    ])
  }


  func fetchPodcasts(dispatchGroup: DispatchGroup) {
            let networkService = NetworkService()
            dispatchGroup.enter() // Входим в группу

            networkService.fetchData(forPath: "/podcasts/trending?max=10") { [weak self] (result: Result<PodcastSearch, APIError>) in
                guard let self = self else { return }

                defer {
                    dispatchGroup.leave() // Покидаем группу после завершения запроса
                }

                switch result {
                case .success(let podcastResponse):
                    self.feeds.append(contentsOf: podcastResponse.feeds)

                  for podcast in self.feeds {
                      let imageURL = podcast.image
                      let podcastItem = PodcastItemCell(title: podcast.title, image: imageURL, id: podcast.id)
                      self.categoryCollectionView.recipes.append(podcastItem)
                      id.append(podcast.id)
                  }

                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
