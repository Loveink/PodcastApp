//
//  TrendingCollectionView.swift
//  BestRecipes
//
//  Created by Александра Савчук on 27.08.2023.
//

import UIKit

class TrendingCollectionView: UIView {
  
  var collectionView: UICollectionView!
  weak var delegate: TrendingCollectionViewDelegate?
  
  var podcasts: [CategoryInfoForCell] = []
  var categoryDictionary: [String: String] = [:] {
      didSet {
        for (categoryName, _) in categoryDictionary {
          let categoryInfo = CategoryInfoForCell(categoryName: categoryName, episodeCount: Int.random(in: 70...100))
          podcasts.append(categoryInfo)
        }
        collectionView.reloadData()
      }
    }

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureCollection()
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
    collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  private func setupConstraints() {
    self.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

//MARK: - Extensions
extension TrendingCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return podcasts.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.identifier, for: indexPath) as? CategoriesCell else {
          return UICollectionViewCell()
      }

      let category = podcasts[indexPath.row]
      cell.configureCell(categoryName: category.categoryName, episodeCount: category.episodeCount)
      return cell
  }

  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 144, height: 200)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if podcasts.count > 0 {
      let selectedPodcast = podcasts[indexPath.item]
      delegate?.didSelectPodcastName(selectedPodcast)
    }
  }
}

//MARK: - Protocols
protocol TrendingCollectionViewDelegate: AnyObject {
  func didSelectPodcastName(_ selectedPodcast: CategoryInfoForCell)
}