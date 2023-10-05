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
  var audioPlayer: AVAudioPlayer?
  var miniPlayerVC = MiniPlayerVC()

  private lazy var titleLabel = UILabel.makeLabel(text: "Channel", font: UIFont.plusJakartaSansBold(size: 18), textColor: UIColor.black)

  private lazy var backButton: UIBarButtonItem = {
      let button = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
      button.tintColor = .symbolsPurple
      return button
  }()

  @objc private func backButtonTapped() {
      print("back button tapped")
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
    
    private lazy var channelAuthor: UILabel = {
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
    
  var vc: FetchFunc?

// MARK: - private properties
  var episodes: [EpisodeItemCell] = []
//  EpisodeModel.makeMockData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
        self.setupCollectionView()
        setupNavigation()

      vc = FetchFunc(collectionView: episodesCollectionView)
      let dispatchGroup = DispatchGroup()
      fetchPodcasts(dispatchGroup: dispatchGroup)
      dispatchGroup.notify(queue: .main) {
        print("All tasks are completed.")
      }
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
        channelAuthor.text = "Dr. Oi om jean"
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
    self.audioPlayer?.stop()
    let episode = episodes[indexPath.row]
    let audioURLString = episode.audioURL
    if let audioURL = URL(string: audioURLString) {
      canPlayAudioFile(withURL: audioURL)
      showMiniPlayer()
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

  func fetchPodcasts(dispatchGroup: DispatchGroup) {
    let networkService = NetworkService()
    dispatchGroup.enter() // Входим в группу

    networkService.fetchData(forPath: "/episodes/byfeedid?id=\(channelID)") { [weak self] (result: Result<EpisodeFeed, APIError>) in
      guard let self = self else { return }

      defer {
        dispatchGroup.leave() // Покидаем группу после завершения запроса
      }

      switch result {
      case .success(let podcastResponse):
        self.feeds.append(contentsOf: podcastResponse.items)
        var xmls = [String]()

        for podcast in self.feeds {
          let imageURL = podcast.feedImage
          let podcastItem = EpisodeItemCell(title: podcast.title, image: imageURL, audioURL: podcast.enclosureUrl, duration: podcast.enclosureLength)
          self.episodes.append(podcastItem)
          xmls.append(podcast.enclosureUrl)
        }

        if let vc = self.vc {
          vc.fetchXMLs(xmls, dispatchGroup: dispatchGroup)
        } else {
          print("FetchFunc is nil.")
        }

        DispatchQueue.main.async {
          self.episodesCollectionView.reloadData()
          self.numberOfEpisodes.text = String(self.feeds.count) + " Esp"
        }

      case .failure(let error):
        print("Error: \(error)")
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
                  self?.audioPlayer?.play()
              } catch {
                  print("Error creating audio player: \(error)")
              }
          }
      }
      task.resume()
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
