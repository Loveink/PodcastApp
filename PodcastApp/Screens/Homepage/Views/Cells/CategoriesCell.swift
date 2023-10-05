//
//  CategoriesCell.swift
//  BestRecipes
//
//  Created by Александра Савчук on 27.08.2023.
//

import UIKit
import Kingfisher

class CategoriesCell: UICollectionViewCell {

  static let identifier = "CategoriesCell"
  var currentCategory: CategoryInfoForCell?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Outlets
  private let categoryImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.layer.cornerRadius = 12
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
  }()

  private let backgroundImageView: UIImageView = {
      let imageView = UIImageView()

      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.layer.cornerRadius = 12
      imageView.layer.masksToBounds = true

    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
      blurView.alpha = 1
      blurView.translatesAutoresizingMaskIntoConstraints = false
      imageView.addSubview(blurView)

      NSLayoutConstraint.activate([
          blurView.topAnchor.constraint(equalTo: imageView.topAnchor),
          blurView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
          blurView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
          blurView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
      ])

      return imageView
  }()


  let categoryNameLabel = UILabel.makeLabel(text: "Music", font: .manropeBold(size: 12), textColor: .black)
  let countPodcastLabel = UILabel.makeLabel(text: "3 podcasts", font: .manropeRegular(size: 12), textColor: .darkGray)

  //MARK: - Functions


  public func configureCell(categoryName: String, episodeCount: Int) {
      DispatchQueue.main.async {
          self.categoryNameLabel.text = categoryName
          self.categoryImageView.image = UIImage(named: categoryName)
          self.countPodcastLabel.text = String(episodeCount) + " Eps"
      }
  }


  private func setupViews() {
    contentView.addSubview(categoryImageView)
    contentView.addSubview(backgroundImageView)
    backgroundImageView.addSubview(categoryNameLabel)
    backgroundImageView.addSubview(countPodcastLabel)
  }

  //MARK: - Constraints
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      categoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      categoryImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

      backgroundImageView.topAnchor.constraint(equalTo: categoryNameLabel.topAnchor, constant: -10),
      backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

      categoryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      categoryNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      categoryNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),

      countPodcastLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      countPodcastLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
    ])
  }
}
