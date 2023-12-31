//
//  EposideCell.swift
//  PodcastApp
//
//  Created by Анастасия Рыбакова on 28.09.2023.
//

import UIKit
import Kingfisher

class EpisodeCell: UICollectionViewCell {
    
    var episode: EpisodeItem?
    let options: KingfisherOptionsInfo = [.cacheOriginalImage]
  var placeholderImage: UIImage?
// MARK: - User Interface
    
    private let episodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "placeholder_image")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var episodeTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.clipsToBounds = true
        label.font = UIFont(name: "Manrope", size: 14)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var episodeDetaisLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.font = UIFont(name: "Manrope", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = CGFloat(5)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
// MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewCell()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.episode = nil
    }
    
    private func setupViewCell() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = UIColor(red: 0.93, green: 0.94, blue: 0.99, alpha: 1.00)
        
        self.addSubview(episodeImageView)
        self.addSubview(stackView)
        stackView.addArrangedSubview(episodeTitleLabel)
        stackView.addArrangedSubview(episodeDetaisLabel)
    }


  func setup(withEpisode episode: EpisodeItem) {
    DispatchQueue.main.async {
      self.episodeImageView.kf.setImage(with: URL(string: episode.image), options: self.options)
      self.episodeTitleLabel.text = episode.title
      let formattedDuration = self.formatDuration(length: episode.duration)
      self.episodeDetaisLabel.text = formattedDuration
    }
  }
}

extension EpisodeCell {
    
    private func setupConstraints() {
        
        let constraints: [NSLayoutConstraint] = [
            
//            self.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            
            episodeImageView.heightAnchor.constraint(equalToConstant: 56),
            episodeImageView.widthAnchor.constraint(equalToConstant: 56),
            episodeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            episodeImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: episodeImageView.trailingAnchor, constant: 15),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        
            
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }

  func formatDuration(length: Int) -> String {
       let minutes = length / 60
       let seconds = length % 60
      return String(format: "%02d:%02d", minutes, seconds)
    }
}


extension EpisodeCell: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    
}
