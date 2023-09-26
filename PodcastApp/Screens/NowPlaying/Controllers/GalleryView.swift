//
//  GalleryView.swift
//  PodcastApp
//
//  Created by Александра Савчук on 26.09.2023.
//

import UIKit

class GalleryView: UIView {
  
  var collectionView: UICollectionView!
  var images: [UIImage] = [UIImage(named: "SongImage1")!, UIImage(named: "ImageLeft")!, UIImage(named: "ImageRight")!]
  var selectedIndexPath: IndexPath?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureCollection()
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureCollection() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10
    
    // Используйте let для инициализации collectionView
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func setupView() {
    selectedIndexPath = IndexPath(row: 0, section: 0)
    addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
    ])
  }
}

extension GalleryView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell else {
      fatalError("Unable to dequeue ImageCollectionViewCell")
    }
    cell.configure(with: images[indexPath.item])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let isSelected = indexPath == selectedIndexPath
    let itemWidth = isSelected ? (screenWidth * 0.7) : (screenWidth * 0.6)
    let itemHeight = isSelected ? screenHeight * 0.4 : screenHeight * 0.3
    return CGSize(width: itemWidth, height: itemHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedIndexPath = indexPath
    collectionView.reloadData()
  }
}
