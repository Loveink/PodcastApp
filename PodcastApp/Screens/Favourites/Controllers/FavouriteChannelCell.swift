//
//  FavouriteChanelCell.swift
//  PodcastApp
//
//  Created by Анастасия Рыбакова on 28.09.2023.
//

import UIKit
import Kingfisher

protocol Reusable {
    static var reuseIdentifier: String { get }
}

class FavouriteChannelCell: UITableViewCell {
    
    var channel: ChannelModel?
    let options: KingfisherOptionsInfo = [
    .cacheOriginalImage
  ]
    
// MARK: - User Interface
    
    private let favChannelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = UIColor(
            red: 0.93, green: 0.94, blue: 0.99, alpha: 1.00)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var favChannelTitleLabel: UILabel = {
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = CGFloat(5)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
    
// MARK: - cell initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCell()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.channel = nil
    }
    
    private func setupCell() {
        contentView.backgroundColor = .white
        self.addSubview(favChannelImageView)
        self.addSubview(stackView)
        stackView.addArrangedSubview(favChannelTitleLabel)
        stackView.addArrangedSubview(episodesNumberLabel)
    }
    
//    func setup(withChanel chanel: ChannelModel) {
//        favChannelImageView.image = UIImage(named: chanel.imageName)
//        favChannelTitleLabel.text = chanel.channelName
//        episodesNumberLabel.text = "\(chanel.numberOfEpisodes) Eps"
//    }
    

    func setup(withChanel chanel: PodcastItemCell) {
      DispatchQueue.main.async {
        self.favChannelImageView.kf.setImage(with: URL(string: chanel.image), options: self.options)
        self.favChannelTitleLabel.text = chanel.title
      }
    }
    
}

extension FavouriteChannelCell {
    
    private func setupConstraints() {
        
        let constraints: [NSLayoutConstraint] = [
            
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            
            favChannelImageView.heightAnchor.constraint(equalToConstant: 48),
            favChannelImageView.widthAnchor.constraint(equalToConstant: 48),
            favChannelImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 47),
            favChannelImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: favChannelImageView.trailingAnchor, constant: 15),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -47),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension FavouriteChannelCell: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    
}
