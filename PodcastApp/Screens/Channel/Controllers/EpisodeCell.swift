//
//  EposideCell.swift
//  PodcastApp
//
//  Created by Анастасия Рыбакова on 28.09.2023.
//

import UIKit

class EpisodeCell: UICollectionViewCell {
    
    var episode: EpisodeModel?
    
// MARK: - User Interface
    
    private let episodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = UIColor(
            red: 0.94, green: 0.84, blue: 0.83, alpha: 1.00)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var episodeTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
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
    
    func setup(withEpisode episode: EpisodeModel) {
        episodeImageView.image = UIImage(named: episode.episodeImageName)
        episodeTitleLabel.text = episode.episodeTitle
        episodeDetaisLabel.text = "\(episode.episodeDutarion) | \(episode.episodeNumber) Eps"
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
//            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -47),
        
            
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}


extension EpisodeCell: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    
}
