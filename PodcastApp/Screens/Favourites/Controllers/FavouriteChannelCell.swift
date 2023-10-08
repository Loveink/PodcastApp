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

  let options: KingfisherOptionsInfo = [.cacheOriginalImage]

  // MARK: - User Interface
  var id: Int?

  private let backgroundImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 12
    imageView.backgroundColor = .grayBackground
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

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

  private lazy var authorLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.numberOfLines = 1
    label.textColor = .darkGray
    label.font = UIFont(name: "Manrope", size: 12)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
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

  private func setupCell() {
    contentView.clipsToBounds = true
    contentView.layer.cornerRadius = 16
    contentView.backgroundColor = UIColor(red: 0.93, green: 0.94, blue: 0.99, alpha: 1.00)
    contentView.addSubview(backgroundImageView)
    backgroundImageView.addSubview(favChannelImageView)
    backgroundImageView.addSubview(favChannelTitleLabel)
    backgroundImageView.addSubview(authorLabel)
  }

  func setup(withChanel chanel: PodcastItemCell) {
    DispatchQueue.main.async {
      self.favChannelImageView.kf.setImage(with: URL(string: chanel.image), options: self.options)
      self.favChannelTitleLabel.text = chanel.title
      self.authorLabel.text = chanel.author
      self.id = chanel.id
    }
  }
}

extension FavouriteChannelCell {

  private func setupConstraints() {

    NSLayoutConstraint.activate([
      backgroundImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      backgroundImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      backgroundImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
      backgroundImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),

      favChannelImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      favChannelImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      favChannelImageView.heightAnchor.constraint(equalToConstant: 60),
      favChannelImageView.widthAnchor.constraint(equalToConstant: 60),

      favChannelTitleLabel.leadingAnchor.constraint(equalTo: favChannelImageView.trailingAnchor, constant: 10),
      favChannelTitleLabel.topAnchor.constraint(equalTo: favChannelImageView.topAnchor),
      favChannelTitleLabel.bottomAnchor.constraint(equalTo: authorLabel.topAnchor, constant: 2),
      favChannelTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.65),

      authorLabel.leadingAnchor.constraint(equalTo: favChannelTitleLabel.leadingAnchor),
      authorLabel.bottomAnchor.constraint(equalTo: favChannelImageView.bottomAnchor),
      authorLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
    ])
  }
}

extension FavouriteChannelCell: Reusable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
