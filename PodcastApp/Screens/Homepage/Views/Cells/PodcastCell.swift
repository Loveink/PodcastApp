//
//  PodcastCell.swift
//  BestRecipes
//
//  Created by Александра Савчук on 31.08.2023.
//

import UIKit
import Kingfisher
import CoreData

class PodcastCell: UICollectionViewCell {

  static let identifier = "PodcastCell"
  var liked: Bool = false
  var currentPodcast: PodcastItemCell?
  var id: Int?
  var audioURLs: [String] = []

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Outlets

  private let backgroundImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 12
    imageView.backgroundColor = .grayBackground
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private lazy var likeButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "heart"), for: .normal)
    button.tintColor = .gray
    button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  @objc private func likeButtonTapped() {
      liked.toggle()
      likeButton.tintColor = liked ? .red : .gray
      if liked {
          saveData()
        if let currentRecipe = currentPodcast {
          let id = currentRecipe.id
          UserDefaultsManager.shared.setPodcastLiked(forPodcastId: id)
        }
      } else {
          if let currentRecipe = currentPodcast {
              let id = currentRecipe.id
              deletePodcastFromCoreData(id: id)
          } else {
              print("currentRecipe is nil or id is missing")
          }
      }
  }


  private func saveData() {
    guard let currentRecipe = currentPodcast else {
      print("currentRecipe is nil")
      return
    }

    let image = currentRecipe.image
    let title = currentRecipe.title
    let id = currentRecipe.id

    SaveToCoreData.savePodcastInfoToCoreData(image, title, id)
  }


  private let podcastImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 12
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private var titleLabel = UILabel.makeLabelForCells(text: "How to make sharwama at home", font: .manropeBold(size: 16), textColor: .black, numberOfLines: 2)
  private var authorLabel = UILabel.makeLabel(text: "How to make sharwama at home", font: .manropeRegular(size: 14), textColor: .black)
  private var categoriesLabel = UILabel.makeLabelForCells(text: "How to make sharwama at home", font: .manropeRegular(size: 12), textColor: .textGrey, numberOfLines: 1)


  //MARK: - Functions
  let options: KingfisherOptionsInfo = [
    .cacheOriginalImage
  ]

  public func configureCell(_ data: PodcastItemCell) {
      DispatchQueue.main.async {
        self.titleLabel.text = data.title
        self.podcastImageView.kf.setImage(with: URL(string: data.image), options: self.options)
        self.currentPodcast = data
        self.authorLabel.text = data.author

        if let categories = data.categories {
          let categoryValues = categories.values.first
          self.categoriesLabel.text = categoryValues
        } else {
          self.categoriesLabel.text = ""
        }

          let id = data.id
          let isLiked = UserDefaultsManager.shared.isPodcastLiked(forPodcastId: id)
          self.liked = isLiked
          self.likeButton.tintColor = isLiked ? .red : .gray
          self.likeButton.addTarget(self, action: #selector(self.likeButtonTapped), for: .touchUpInside)
      }
    }

  private func setupViews() {
    contentView.addSubview(backgroundImageView)
    backgroundImageView.addSubview(podcastImageView)
    backgroundImageView.addSubview(titleLabel)
    contentView.addSubview(likeButton)
    backgroundImageView.addSubview(authorLabel)
    backgroundImageView.addSubview(categoriesLabel)
    categoriesLabel.textAlignment = .right
    authorLabel.adjustsFontSizeToFitWidth = false
  }

  //MARK: - Constraints
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      backgroundImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      backgroundImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      backgroundImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
      backgroundImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),

      podcastImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      podcastImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      podcastImageView.heightAnchor.constraint(equalToConstant: 60),
      podcastImageView.widthAnchor.constraint(equalToConstant: 60),

      titleLabel.leadingAnchor.constraint(equalTo: podcastImageView.trailingAnchor, constant: 10),
      titleLabel.topAnchor.constraint(equalTo: podcastImageView.topAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: authorLabel.topAnchor, constant: 2),
      titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.65),

      likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      likeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

      authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      authorLabel.bottomAnchor.constraint(equalTo: podcastImageView.bottomAnchor),
      authorLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),

      categoriesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      categoriesLabel.bottomAnchor.constraint(equalTo: authorLabel.bottomAnchor),
      categoriesLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
    ])
  }

  func deletePodcastFromCoreData(id: Int) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }

    let context = appDelegate.persistentContainer.viewContext

    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PodcastSave")
    fetchRequest.predicate = NSPredicate(format: "id == %d", id)


    do {
      if let result = try context.fetch(fetchRequest).first as? NSManagedObject {
        context.delete(result)
        try context.save()
      }
    } catch {
      print("Error deleting data from Core Data: \(error)")
    }
  }
}
