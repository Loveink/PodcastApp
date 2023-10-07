//
//  FavoriteCell.swift
//  PodcastApp
//
//  Created by Владимир on 07.10.2023.
//

import UIKit
import Kingfisher

class FavoriteCell: UICollectionViewCell {
    
    static let identifier = "FavoriteCell"
    var currentItem: PodcastItemCell?
    
    let imageView = UIImageView()
    let titleLabel = UILabel.makeLabel(font: .manropeBold(size: 14), textColor: .black)
    let authorLabel = UILabel.makeLabel(font: .manropeRegular(size: 12), textColor: .gray)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configureCell(_ item: PodcastItemCell) {
        currentItem = item
        titleLabel.text = item.title
        authorLabel.text = item.author
        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: URL(string: item.image))
        }
    }
    
    
    private func setupViews() {
        self.backgroundColor = UIColor(red: 0.9, green: 0.96, blue: 1, alpha: 1.0)
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.textAlignment = .center
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}


extension FavoriteCell {
    private func setupConstraints() {
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
                imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
//                imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 30),
                imageView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
                imageView.heightAnchor.constraint(equalToConstant: 60),
                imageView.widthAnchor.constraint(equalToConstant: 60),

                titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
                titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
                titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),

                authorLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
                authorLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
                authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
        ])
    }
}
