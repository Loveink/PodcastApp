//
//  GalleryView.swift
//  PodcastApp
//
//  Created by Александра Савчук on 26.09.2023.
//

import UIKit
import Kingfisher


//class GalleryView: UIView {
//
//  var collectionView: UICollectionView!
//  var images: [String] = [] {
//    didSet {
//      collectionView.reloadData()
//    }
//  }
//  var selectedIndexPath: IndexPath?
//
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//    configureCollection()
//    setupView()
//  }
//
//  required init?(coder aDecoder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//
//  func configureCollection() {
//    let layout = UICollectionViewFlowLayout()
//    layout.scrollDirection = .horizontal
//    layout.minimumLineSpacing = 10
//    layout.minimumInteritemSpacing = 10
//
//    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//    collectionView.showsHorizontalScrollIndicator = false
//    collectionView.dataSource = self
//    collectionView.delegate = self
//    collectionView.backgroundColor = .clear
//    collectionView.translatesAutoresizingMaskIntoConstraints = false
//    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: nil)
//  }
//
//  private func setupView() {
//    selectedIndexPath = IndexPath(row: 0, section: 0)
//    addSubview(collectionView)
//
//    NSLayoutConstraint.activate([
//      collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
//      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//      collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
//    ])
//  }
//
//  func setImages(_ images: [String]) {
//    self.images = images
//  }
//}
//
//extension GalleryView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    print(images.count)
//    return images.count
//  }
//
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nil, for: indexPath)
//    cell.contentView.subviews.forEach { $0.removeFromSuperview() } // Удаляем все предыдущие вложенные представления
//
//    let imageView = UIImageView()
//    imageView.contentMode = .scaleToFill
//    imageView.layer.cornerRadius = 20
//    imageView.clipsToBounds = true
//
//    let imageUrlString = images[indexPath.item]
//    if let imageUrl = URL(string: imageUrlString) {
//      imageView.kf.setImage(with: imageUrl) { result in
//        switch result {
//        case .success(_): break
//        case .failure(let error):
//          print("Error downloading image: \(error.localizedDescription)")
//        }
//      }
//    }
//
//    cell.contentView.addSubview(imageView)
//    imageView.translatesAutoresizingMaskIntoConstraints = false
//
//    NSLayoutConstraint.activate([
//      imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
//      imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
//      imageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
//      imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
//    ])
//
//    return cell
//  }
//
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    let screenWidth = UIScreen.main.bounds.width
//    let screenHeight = UIScreen.main.bounds.height
//    let isSelected = indexPath == selectedIndexPath
//    let itemWidth = isSelected ? (screenWidth * 0.7) : (screenWidth * 0.6)
//    let itemHeight = isSelected ? screenHeight * 0.5 : screenHeight * 0.4
//    return CGSize(width: itemWidth, height: itemHeight)
//  }
//
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    selectedIndexPath = indexPath
//    collectionView.reloadData()
//
//    guard let selectedIndexPath = selectedIndexPath else { return }
//    let centerX = collectionView.bounds.width / 2
//    if let attributes = collectionView.layoutAttributesForItem(at: selectedIndexPath) {
//      let cellCenterX = attributes.center.x
//      let offsetX = cellCenterX - centerX
//      collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
//    }
//  }
//}
