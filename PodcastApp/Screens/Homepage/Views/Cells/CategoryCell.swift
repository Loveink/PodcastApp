//
//  CategoryCell.swift
//  BestRecipes
//
//  Created by Александра Савчук on 31.08.2023.
//

import UIKit
import Kingfisher
import CoreData

class CategoryCell: UICollectionViewCell {

  static let identifier = "CategoryCell"
  var liked: Bool = false
  var currentRecipe: PodcastItemCell?
  var id: Int?
  var audioURLs: [String] = []
  var vc: FetchFunc?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Outlets

  private lazy var likeButton: UIButton = {
      let button = UIButton()
      button.setImage(UIImage(systemName: "heart"), for: .normal)
      button.tintColor = .gray // Цвет сердца при нажатии (можете выбрать другой цвет)
      button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
  }()

  @objc private func likeButtonTapped() {
        liked.toggle()
        likeButton.tintColor = liked ? .red : .gray
        if liked {
            saveData()
        } else {
          if let currentRecipe = currentRecipe {
              let id = currentRecipe.id
              deletePodcastFromCoreData(id: id)
          } else {
              print("currentRecipe is nil or id is missing")
          }
        }
    }

  private func saveData() {
      guard let currentRecipe = currentRecipe else {
          print("currentRecipe is nil")
          return
      }

      let image = currentRecipe.image
      let title = currentRecipe.title
      let id = currentRecipe.id

      SaveToCoreData.saveRecipeInfoToCoreData(image, title, id)
      printSavedPodcasts()
  }


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
      }
  }


  private func setupViews() {

    contentView.addSubview(dishImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(likeButton)
  }

  //MARK: - Constraints
  private func setupConstraints() {
    NSLayoutConstraint.activate([

      dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      dishImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      dishImageView.heightAnchor.constraint(equalToConstant: 250),
      dishImageView.widthAnchor.constraint(equalToConstant: 300),

      titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      titleLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor),

      likeButton.leadingAnchor.constraint(equalTo: dishImageView.leadingAnchor),
      likeButton.bottomAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 20),

    ])
  }


  func printSavedPodcasts() {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
      }

      let context = appDelegate.persistentContainer.viewContext

      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PodcastSave")

      do {
          if let results = try context.fetch(fetchRequest) as? [NSManagedObject] {
              for result in results {
                  if let title = result.value(forKey: "title") as? String,
                     let imageURL = result.value(forKey: "image") as? String,
                     let id = result.value(forKey: "id") as? Int {
                      print("Title: \(title)")
                      print("Image URL: \(imageURL)")
                      print("Id: \(id)")
                  }
              }
          }
      } catch {
          print("Error fetching data from Core Data: \(error)")
      }
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
