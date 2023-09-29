//
//  NowPlayingViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 25.09.2023.
//

import UIKit
import AVFoundation

class NowPlayingViewController: UIViewController {

  var podcast = PodcastView()
  var galleryViewController = GalleryView()
  var feeds: [Feed] = []

  var audioPlayer: AVAudioPlayer?
  var currentTrackIndex: Int = 0
  var musicArray: [String] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    fetch()
    setupConstraints()
  }

  func fetch() {
        let dispatchGroup = DispatchGroup()
        var xmls = [String]()

        // Первый запрос к API
        dispatchGroup.enter() // Входим в группу
        let networkService = NetworkService()
        networkService.fetchData(forPath: "/search/byterm?q=man") { (result: Result<PodcastSearch, APIError>) in
            defer {
                dispatchGroup.leave()
            }

            switch result {
            case .success(let podcastResponse):
                self.feeds.append(contentsOf: podcastResponse.feeds)

                for podcast in self.feeds {
                    let imageURL = podcast.image
                    self.galleryViewController.images.append(imageURL)
                    xmls.append(podcast.url)
                }

                // Запускаем запросы к XML для каждого URL из xmls
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
                            let xmlParser = XMLParser(data: data)
                            xmlParser.delegate = self

                            if xmlParser.parse() {
  //                              print("XML parsing complete")
                            } else {
                                print("XML parsing failed")
                            }
                        }
                    }
                    task.resume()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }

        // Ожидаем завершения всех запросов
        dispatchGroup.notify(queue: .main) {
            // Этот код выполнится после завершения всех запросов
            self.galleryViewController.collectionView.reloadData()
            if let audioURLString = self.musicArray.first,
               let audioURL = URL(string: audioURLString + ".mp3") {
                self.playAudio(withURL: audioURL)
            } else {
                print("Первый аудиофайл в массиве не найден.")
            }
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
                  self?.audioPlayer?.delegate = self
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

extension NowPlayingViewController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == "enclosure", let enclosureURL = attributeDict["url"] {
          musicArray.append(enclosureURL)
        }
    }
}

extension NowPlayingViewController: AVAudioPlayerDelegate {
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    // Ваш код обработки завершения воспроизведения аудио
  }
}
