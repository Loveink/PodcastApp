//
//  HomeViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 23.09.2023.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController, CategoriesCollectionViewDelegate {
  func didSelectRecipe(_ audioURL: String) {
         vc?.getMusic(audioURL: audioURL)
     }

  var audioPlayer: AVAudioPlayer?
  var musicArray: [String] = []
  private let categoryCollectionView = CategoriesCollectionView()
  var feeds: [Feed] = []
  var vc: FetchFunc?

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
      categoryCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
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
                  var xmls = [String]()

                  for podcast in self.feeds {
                      let imageURL = podcast.image
                    let podcastItem = PodcastItemCell(title: podcast.title, image: imageURL, audioURL: podcast.url)
                      self.categoryCollectionView.recipes.append(podcastItem)
                      xmls.append(podcast.url)
                  }

                  if let vc = self.vc {
                      vc.fetchXMLs(xmls, dispatchGroup: dispatchGroup)
                  } else {
                      print("FetchFunc is nil.")
                  }
              case .failure(let error):
                  print("Error: \(error)")
              }
          }
      }
  }

