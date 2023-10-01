//
//  CategoriesCollectionView.swift
//  BestRecipes
//
//  Created by Александра Савчук on 31.08.2023.
//

import UIKit

class CategoriesCollectionView: UIView {

  var collectionView: UICollectionView!

  weak var delegate: CategoriesCollectionViewDelegate?

  var recipes: [PodcastItemCell] = [] {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }

  var selectedCell: CategoryCell?
  var audioURLs: [Int: String] = [:]



  override init(frame: CGRect) {
    super.init(frame: frame)
    configureCollection()
    addSubview(collectionView)
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configureCollection() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

//MARK: - Extensions
extension CategoriesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return recipes.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
      return UICollectionViewCell()
    }
    cell.configureCell(recipes[indexPath.row])
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 300, height: 300)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      if recipes.count > 0 {
          if let selectedCell = collectionView.cellForItem(at: indexPath) as? CategoryCell,
             let audioURL = selectedCell.audioURLs.first { // Получаем первый URL из массива audioURLs
              delegate?.didSelectRecipe(audioURL)
          }
      }
  }




}

//MARK: - Protocols
protocol CategoriesCollectionViewDelegate: AnyObject {
  func didSelectRecipe(_ audioURL: String)
}
