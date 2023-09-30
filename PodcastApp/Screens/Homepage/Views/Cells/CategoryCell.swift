//
//  CategoryCell.swift
//  BestRecipes
//
//  Created by Александра Савчук on 31.08.2023.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {

  static let identifier = "CategoryCell"
  var liked: Bool = false
  var currentRecipe: PodcastItemCell?
  var audioURL: String?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Outlets


  private let dishImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFit
      imageView.clipsToBounds = true
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
  }()


  private let titleLabel = UILabel.makeLabel(text: "How to make sharwama at home", font: .manropeRegular(size: 16), textColor: .black)


  //MARK: - Functions


  let options: KingfisherOptionsInfo = [
    .cacheOriginalImage
  ]

  public func configureCell(_ data: PodcastItemCell) {
    DispatchQueue.main.async {
      self.titleLabel.text = data.title
      self.dishImageView.kf.setImage(with: URL(string: data.image), options: self.options)
      self.currentRecipe = data
      self.audioURL = data.audioURL
    }
  }

  private func setupViews() {

    contentView.addSubview(dishImageView)
    contentView.addSubview(titleLabel)

  }

  //MARK: - Constraints
  private func setupConstraints() {
    NSLayoutConstraint.activate([

      dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      dishImageView.centerYAnchor.constraint(equalTo: contentView.topAnchor),
      dishImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      dishImageView.heightAnchor.constraint(equalToConstant: 250),
      dishImageView.widthAnchor.constraint(equalToConstant: 300),

      titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      titleLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor),

    ])
  }
}
