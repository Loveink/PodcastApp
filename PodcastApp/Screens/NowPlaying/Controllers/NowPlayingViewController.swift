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
  var feeds: [EpisodeItem] = []

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

        dispatchGroup.enter() // Входим в группу
        let networkService = NetworkService()
        networkService.fetchData(forPath: "/episodes/byfeedid?id=6569768") { (result: Result<EpisodeFeed, APIError>) in
            defer {
                dispatchGroup.leave()
            }

            switch result {
            case .success(let podcastResponse):
              self.feeds.append(contentsOf: podcastResponse.items)

                for podcast in self.feeds {
                    let imageURL = podcast.feedImage
                    self.galleryViewController.images.append(imageURL)
                    self.musicArray.append(podcast.enclosureUrl)

                  print(self.musicArray)
                  print(podcast.enclosureLength)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }

        // Ожидаем завершения всех запросов
        dispatchGroup.notify(queue: .main) {
            // Этот код выполнится после завершения всех запросов
            self.galleryViewController.collectionView.reloadData()
          print("reload")
            if let audioURLString = self.musicArray.first,
               let audioURL = URL(string: audioURLString) {
                self.playAudio(withURL: audioURL)
//                self.podcast.dur = podcast.enclosureLength
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

extension NowPlayingViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            // Track finished, you can handle this event here.
            // For example, move to the next track if available.
            currentTrackIndex += 1
            if currentTrackIndex < musicArray.count {
              let audioURLString = musicArray[currentTrackIndex]
              if let audioURL = URL(string: audioURLString + ".mp3") {
                  playAudio(withURL: audioURL)
              }
            } else {
                // No more tracks to play, you can handle this case accordingly.
            }

            // Update the slider value to show the current position
            if let audioPlayer = audioPlayer {
                let duration = audioPlayer.duration
                let currentTime = audioPlayer.currentTime
                podcast.sliderView.value = Float(currentTime / duration)
            }
        }
    }
}
