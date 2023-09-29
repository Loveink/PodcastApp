//
//  HomeViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 23.09.2023.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {
  var audioPlayer: AVAudioPlayer?
  var musicArray: [String] = []
  private let categoryCollectionView = CategoriesCollectionView()
  var feeds: [Feed] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupCollectionView()
    fetch()
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

  func fetch() {
      let dispatchGroup = DispatchGroup()
    let xmls = [String]()

      // Первый запрос к API
      dispatchGroup.enter() // Входим в группу

      fetchPodcasts(dispatchGroup: dispatchGroup)

      // Ожидаем завершения всех запросов
      dispatchGroup.notify(queue: .main) {
          // Этот код выполнится после завершения всех запросов
          self.handlePodcastFetchCompletion(xmls)
      }
  }

  func fetchPodcasts(dispatchGroup: DispatchGroup) {
      let networkService = NetworkService()
      networkService.fetchData(forPath: "/podcasts/trending?max=10") { [weak self] (result: Result<PodcastSearch, APIError>) in
          guard let self = self else { return }

          defer {
              dispatchGroup.leave()
          }

          switch result {
          case .success(let podcastResponse):
              self.feeds.append(contentsOf: podcastResponse.feeds)
              var xmls = [String]()

              for podcast in self.feeds {
                  let imageURL = podcast.image
                  let podcastItem = PodcastItemCell(title: podcast.title, image: imageURL)
                  self.categoryCollectionView.recipes.append(podcastItem)
                  xmls.append(podcast.url)
              }

              self.fetchXMLs(xmls, dispatchGroup: dispatchGroup)
          case .failure(let error):
              print("Error: \(error)")
          }
      }
  }

  func fetchXMLs(_ xmls: [String], dispatchGroup: DispatchGroup) {
      for xmlURLString in xmls {
          guard let xmlURL = URL(string: xmlURLString) else {
              continue // Пропустим неверный URL
          }

          dispatchGroup.enter() // Входим в группу
          let session = URLSession.shared
          let task = session.dataTask(with: xmlURL) { (data, response, error) in
              defer {
                  dispatchGroup.leave() // Покидаем группу после завершения запроса
              }

              if let error = error {
                  print("Error: \(error.localizedDescription)")
                  return
              }

              if let data = data {
                  self.parseXML(data)
              }
          }
          task.resume()
      }
  }

  func parseXML(_ data: Data) {
      let xmlParser = XMLParser(data: data)
      xmlParser.delegate = self
      xmlParser.parse() 

  }

  func handlePodcastFetchCompletion(_ xmls: [String]) {
      self.categoryCollectionView.collectionView.reloadData()
      if let audioURLString = self.musicArray.first,
         let audioURL = URL(string: audioURLString + ".mp3") {
          self.playAudio(withURL: audioURL)
          print("play")
      } else {
          print("Первый аудиофайл в массиве не найден.")
      }
  }

  func canPlayAudioFile(withURL audioURL: URL) {
      let session = URLSession.shared
      let task = session.dataTask(with: audioURL) { [weak self] (data, response, error) in
          if let error = error {
              print("Error loading audio data: \(error.localizedDescription)")
              return
          }

          if let data = data {
              do {
                  self?.audioPlayer = try AVAudioPlayer(data: data)
//                  self?.audioPlayer?.delegate = self
                  self?.audioPlayer?.play()
              } catch {
                  print("Error creating audio player: \(error)")
              }
          }
      }
      task.resume()
  }

  func playAudio(withURL audioURL: URL) {
      canPlayAudioFile(withURL: audioURL)
  }

}

extension HomeViewController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == "enclosure", let enclosureURL = attributeDict["url"] {
          musicArray.append(enclosureURL)
        }
    }
}
