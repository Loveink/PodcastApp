//
//  PodcastViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 26.09.2023.
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
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

  func configure(with image: UIImage) {
      imageView.image = image
  }
}

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    let images: [UIImage] = [UIImage(named: "SongImage1")!, UIImage(named: "ImageLeft")!, UIImage(named: "ImageRight")!]
    var selectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        selectedIndexPath = IndexPath(row: 0, section: 0)
      
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }



    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell else {
            fatalError("Unable to dequeue ImageCollectionViewCell")
        }

        let isSelected = indexPath == selectedIndexPath
        cell.configure(with: images[indexPath.item])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let isSelected = indexPath == selectedIndexPath
        let itemWidth = isSelected ? (screenWidth * 0.7) : (screenWidth * 0.6)
        let itemHeight = isSelected ? screenHeight * 0.5 : screenHeight * 0.4
        return CGSize(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        collectionView.reloadData()
    }
}
