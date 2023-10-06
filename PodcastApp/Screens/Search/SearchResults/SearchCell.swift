//
//  SearchCell.swift
//  PodcastApp
//
//  Created by Владимир on 04.10.2023.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    static let identifier = "SearchCollectionViewCell"
    
    
    let titleLabel = UILabel.makeLabel(font: .manropeBold(size: 14), textColor: .black)
    
    let timeLabel = UILabel.makeLabel(font: .manropeRegular(size: 12), textColor: .gray)
    
    let episodeCounterLabel = UILabel.makeLabel(font: .manropeRegular(size: 12), textColor: .gray)
    
    let imageView = UIImageView()
    let divisionCircle = UIView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configureCell(title: String, time: Int, episodesCount: String, image: String) {
        configureUI()
        setupConstraints()
        
        titleLabel.text = title
        timeLabel.text = "\(time)"
        episodeCounterLabel.text = "\(episodesCount) Eps"
        
        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: URL(string: image))
        }
    }
    
    
    func configureCell(_ podcastItem: PodcastItemCell) {
        configureUI()
        setupConstraints()
        
        titleLabel.text = podcastItem.title
        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: URL(string: podcastItem.image))
        }
        fetchEpisodes(podcastItem.id)
    }
    
    
    private func configureUI() {
        self.backgroundColor = .grayBackground
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        
        titleLabel.adjustsFontSizeToFitWidth = false
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(timeLabel)
        
        episodeCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(episodeCounterLabel)
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.backgroundColor = .black
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        divisionCircle.layer.cornerRadius = 2
        divisionCircle.backgroundColor = .lightGray
        divisionCircle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(divisionCircle)
    }
    
}



extension SearchCell {
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 56),
            imageView.heightAnchor.constraint(equalToConstant: 56),

            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 15),
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.centerYAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),

            episodeCounterLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            episodeCounterLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            episodeCounterLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }
}



extension SearchCell {
    func fetchEpisodes(_ channelID: Int) {
        let networkService = NetworkService()
        networkService.fetchData(forPath: "/episodes/byfeedid?id=\(channelID)") { [weak self] (result: Result<EpisodeFeed, APIError>) in
            guard self != nil else { return }
            switch result {
            case .success(let podcastResponse):
                DispatchQueue.main.async {
                    self!.episodeCounterLabel.text = "\(podcastResponse.count) Eps"
                }
            case .failure(let error):
                print("SearchCell Error: \(error)")
            }
        }
    }
}
