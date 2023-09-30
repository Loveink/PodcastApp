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
        // Остановите предыдущий аудиоплеер, если он существует
        audioPlayer?.stop()

        // Определите индекс выбранной ячейки
        if let indexPath = selectedIndexPath {
            // Получите URL аудиофайла для выбранной ячейки
            let audioURLString = categoryCollectionView.recipes[indexPath.row].audioURL

            // Проверьте, что URL совпадает с переданным URL
            if audioURLString == audioURL {
                // Если это тот же самый URL, то остановите аудиоплеер
                audioPlayer?.stop()
                selectedIndexPath = nil
            } else {
                // Если URL различается, создайте новый аудиоплеер и проиграйте музыку
                if let audioURL = URL(string: audioURL) {
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
                        audioPlayer?.play()
                        selectedIndexPath = indexPath
                    } catch {
                        print("Error creating audio player: \(error)")
                    }
                }
            }
        }
    }


  var audioPlayer: AVAudioPlayer?
  var musicArray: [String] = []
  private let categoryCollectionView = CategoriesCollectionView()
  var feeds: [Feed] = []
  var vc: FetchFunc?
  var selectedIndexPath: IndexPath?

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
    if let vc = self.vc {
      print("start")
      vc.audioURLHandler = { [weak self] audioURL in
        // Вызывается при получении URL из parser(_:didStartElement:namespaceURI:qualifiedName:attributes:)
        vc.getMusic(audioURL: audioURL)
      }

      categoryCollectionView.delegate = self
    }
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
                  var xmls = [String]()

                for (index, podcast) in self.feeds.enumerated() {
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
