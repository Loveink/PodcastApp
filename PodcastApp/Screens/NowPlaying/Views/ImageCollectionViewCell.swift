//
//  ImageCollectionViewCell.swift
//  PodcastApp
//
//  Created by Александра Савчук on 27.09.2023.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    return imageView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupViews()
  }

  private func setupViews() {
    addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  func configure(with image: UIImage) {
    imageView.image = image
  }
}
