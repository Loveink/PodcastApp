//
//  PlaylistCell.swift
//  PodcastApp
//
//  Created by Владимир on 07.10.2023.
//

import UIKit
import Kingfisher

class PlaylistCell: UITableViewCell {

    let options: KingfisherOptionsInfo = [
        .cacheOriginalImage
    ]
    
    private var currentPlaylist: PlaylistItemCell?
    
    private let podcastImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = UIColor(
            red: 0.93, green: 0.94, blue: 0.99, alpha: 1.00)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "Manrope", size: 14)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var episodesNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.font = UIFont(name: "Manrope", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setup(_ playlist: PlaylistItemCell) {
        currentPlaylist = playlist
        DispatchQueue.main.async {
            self.titleLabel.text = playlist.title
            self.episodesNumberLabel.text = "\(playlist.episodeCounter) Eps"
            self.podcastImageView.kf.setImage(with: URL(string: playlist.image), options: self.options)
        }
    }
    
}

extension PlaylistCell {
    private func setupConstraints() {
        self.selectionStyle = .none
        addSubview(podcastImageView)
        addSubview(titleLabel)
        addSubview(episodesNumberLabel)
        
        NSLayoutConstraint.activate([
            podcastImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            podcastImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            podcastImageView.heightAnchor.constraint(equalToConstant: 48),
            podcastImageView.widthAnchor.constraint(equalToConstant: 48),
            
            titleLabel.topAnchor.constraint(equalTo: podcastImageView.topAnchor, constant: 2),
            titleLabel.leftAnchor.constraint(equalTo: podcastImageView.rightAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            
            episodesNumberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            episodesNumberLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor)
        ])
    }
}



extension PlaylistCell: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


extension PlaylistCell {
    func fetchEpisodes(_ channelID: Int) {
        let networkService = NetworkService()
        networkService.fetchData(forPath: "/episodes/byfeedid?id=\(channelID)") { [weak self] (result: Result<EpisodeFeed, APIError>) in
            guard self != nil else { return }
            switch result {
            case .success(let podcastResponse):
                DispatchQueue.main.async {
                    self!.episodesNumberLabel.text = "\(podcastResponse.count) Eps"
                }
            case .failure(let error):
                print("SearchCell Error: \(error)")
            }
        }
    }
}
