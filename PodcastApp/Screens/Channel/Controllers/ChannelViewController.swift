//
//  ChannelViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 25.09.2023.
//

import UIKit
import AVFoundation

class ChannelViewController: UIViewController {

// MARK: - User Interface
  var channelID: Int = 0
  var feeds: [EpisodeItem] = []
  private let musicPlayer = MusicPlayer.instance
  let miniPlayerVC = MiniPlayerVC()
  let songPageViewController = NowPlayingViewController()


  private lazy var titleLabel = UILabel.makeLabel(text: "Channel", font: UIFont.plusJakartaSansBold(size: 18), textColor: UIColor.black)

  private lazy var backButton: UIBarButtonItem = {
      let button = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
      button.tintColor = .symbolsPurple
      return button
  }()

  @objc private func backButtonTapped() {
      tabBarController?.tabBar.isHidden = false
      navigationController?.popViewController(animated: true)
  }

  private func setupNavigation() {
      navigationController?.navigationBar.isHidden = false
      navigationController?.navigationBar.prefersLargeTitles = true
      navigationController?.navigationBar.tintColor = UIColor.black
      navigationItem.leftBarButtonItem = backButton
      navigationItem.titleView = titleLabel
  }

     var channelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 21
        imageView.backgroundColor = UIColor(
            red: 0.68, green: 0.89, blue: 0.95, alpha: 1.00)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var channelTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Manrope", size: 16)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var numberOfEpisodes: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont(name: "Manrope", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dashLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .lightGray
        label.text = "|"
        label.font = UIFont(name: "Manrope", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var channelAuthor: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont(name: "Manrope", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = CGFloat(5)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var collectionTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "All Episodes"
        label.font = UIFont(name: "Manrope", size: 16)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var episodesCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()


// MARK: - private properties
  var episodes: [EpisodeItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
        self.setupCollectionView()
        setupNavigation()
      fetchPodcasts()
      miniPlayerVC.setupCurrentViewController(controller: self)
      miniPlayerVC.setupTargetController(controller: songPageViewController)
      miniPlayerVC.delegate = self
      musicPlayer.delegate = self
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(channelImageView)
        view.addSubview(channelTitleLabel)
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(numberOfEpisodes)
        stackView.addArrangedSubview(dashLabel)
        stackView.addArrangedSubview(channelAuthor)
        
        view.addSubview(collectionTitle)
        view.addSubview(episodesCollectionView)
    }
    
    private func setupCollectionView() {
        episodesCollectionView.dataSource = self
        episodesCollectionView.delegate = self
        
        episodesCollectionView.register(
            EpisodeCell.self,
            forCellWithReuseIdentifier: EpisodeCell.reuseIdentifier)
    }

    
    private func setupChannel() {
//        channelTitleLabel.text = "Baby Pesut Podcast"
        numberOfEpisodes.text = String(feeds.count) + " Esp"
//        channelAuthor.text = "Dr. Oi om jean"    songPageViewController.channelAuthor = channelAuthor.text
    }
    

}


// MARK: - collection protocols

extension ChannelViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    self.episodes.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: EpisodeCell.reuseIdentifier,
      for: indexPath) as? EpisodeCell else {
      let cell = EpisodeCell()
      return cell
    }
    
    let episode = self.episodes[indexPath.row]
    cell.setup(withEpisode: episode)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.musicPlayer.stopMusic()
    let episode = episodes[indexPath.row]
    let audioURLString = episode.enclosureUrl
    if URL(string: audioURLString) != nil {
      showMiniPlayer()
      if musicPlayer.isPlayingMusic(from: audioURLString) {
        musicPlayer.pauseMusic()
      } else {
        musicPlayer.loadPlayer(from: episode)
      }
    } else {
      print("Error: Invalid audio URL")
    }
  }
}


extension ChannelViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(
            top: 0,
            left: 32,
            bottom: 0,
            right: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width - 32*2
        
        return CGSize(width: width, height: 72)
    }
    
}

// MARK: - setup constraints
extension ChannelViewController {

  private func setupConstraints() {

    let constraints: [NSLayoutConstraint] = [

      channelImageView.heightAnchor.constraint(equalToConstant: 100),
      channelImageView.widthAnchor.constraint(equalToConstant: 100),
      channelImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      channelImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      channelTitleLabel.topAnchor.constraint(equalTo: channelImageView.bottomAnchor, constant: 20),
      channelTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      channelTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),

      stackView.topAnchor.constraint(equalTo: channelTitleLabel.bottomAnchor, constant: 5),
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      collectionTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
      collectionTitle.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 32),

      episodesCollectionView.topAnchor.constraint(equalTo: collectionTitle.bottomAnchor, constant: 16),
      episodesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      episodesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      episodesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ]

    NSLayoutConstraint.activate(constraints)
  }

  func fetchPodcasts() {
    let networkService = NetworkService()

    networkService.fetchData(forPath: "/episodes/byfeedid?id=\(channelID)") { [weak self] (result: Result<EpisodeFeed, APIError>) in
      guard let self = self else { return }

      switch result {
      case .success(let podcastResponse):
        self.feeds.append(contentsOf: podcastResponse.items)

        for podcast in self.feeds {
          let imageURL = podcast.feedImage
          let podcastItem = EpisodeItem(id: podcast.id, title: podcast.title, link: podcast.link, description: podcast.description, enclosureUrl: podcast.enclosureUrl, duration: podcast.duration, image: imageURL, feedImage: imageURL)
          self.episodes.append(podcastItem)
        }

        DispatchQueue.main.async {
          self.episodesCollectionView.reloadData()
          self.numberOfEpisodes.text = String(self.feeds.count) + " Esp"
          Music.shared.episodeResults = podcastResponse.items
//              self.newSongsView.update(with: Music.shared.musicResults)
//              self.recentlyMusicTableView.update(with: Music.shared.musicResults)
              self.musicPlayer.updateMusicResults(Music.shared.episodeResults)
          self.songPageViewController.channelAuthor = self.channelAuthor.text
        }

      case .failure(let error):
        print("Error: \(error)")
      }
    }
  }

  func showMiniPlayer() {
      miniPlayerVC.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(miniPlayerVC)
      NSLayoutConstraint.activate([
          miniPlayerVC.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
          miniPlayerVC.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
          miniPlayerVC.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
          miniPlayerVC.heightAnchor.constraint(equalToConstant: 70)
      ])
  }
}

extension ChannelViewController: MiniPlayerViewDelegate {
    func forwardButtonTapped() {
        musicPlayer.playNextSong()
    }

    func backwardButtonTapped() {
        musicPlayer.playPreviousSong()
    }

    func playButtonTapped() {
        musicPlayer.isPlayerPerforming() ? musicPlayer.pauseMusic() :  musicPlayer.playMusic()
    }
}

extension ChannelViewController: MusicPlayerDelegate {

    func updateCurrentURL(_ url: String) {
        guard let musicResult = getMusicResultFromURL(url)
        else {
            miniPlayerVC.updateSongTitle("")
            miniPlayerVC.updateSongImage(nil)
            return
        }
      miniPlayerVC.updateSongTitle(musicResult.title)
           let imageUrlString = musicResult.feedImage
          if let imageUrl = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                DispatchQueue.main.async {
                    if let imageData = data, let image = UIImage(data: imageData) {
                        self.miniPlayerVC.updateSongImage(image)
                      self.songPageViewController.trackInfo = musicResult
                    } else {
                        self.miniPlayerVC.updateSongImage(nil)
                    }
                }
            }.resume()
        } else {
            miniPlayerVC.updateSongImage(nil)
        }
    }

  private func getMusicResultFromURL(_ url: String) -> EpisodeItem? {
      let entry = Music.shared.episodeResults.first { episode in
          return episode.enclosureUrl == url
      }
      return entry
  }

    func updatePlayButtonState(isPlaying: Bool) {

        if isPlaying {
            miniPlayerVC.playButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            miniPlayerVC.playButton.tintColor = .black
        } else {
            miniPlayerVC.playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            miniPlayerVC.playButton.tintColor = .black
        }
    }
}

