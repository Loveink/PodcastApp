//
//  PopularCollectionView.swift
//  BestRecipes
//
//  Created by Александра Савчук on 31.08.2023.
//

import UIKit

class PopularCollectionView: UIView {

  var collectionView: UICollectionView!
  weak var delegate: PopularCollectionViewDelegate?

  var podcasts: [PodcastItemCell] = [] {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }

  var selectedCell: PodcastCell?
  var id: Int?

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
    layout.scrollDirection = .vertical
    collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(PodcastCell.self, forCellWithReuseIdentifier: PodcastCell.identifier)
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
extension PopularCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return podcasts.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PodcastCell.identifier, for: indexPath) as? PodcastCell else {
      return UICollectionViewCell()
    }
    cell.configureCell(podcasts[indexPath.row])
    cell.id = Int(podcasts[indexPath.row].id)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let cellWidth = collectionView.frame.width - 20
      return CGSize(width: cellWidth, height: 80)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if podcasts.count > 0 {
      if let selectedCell = collectionView.cellForItem(at: indexPath) as? PodcastCell,
         let id = selectedCell.id {
        delegate?.didSelectPodcast(id: id)
      }
    }
  }
}

//MARK: - Protocols
protocol PopularCollectionViewDelegate: AnyObject {
  func didSelectPodcast(id: Int)
}
