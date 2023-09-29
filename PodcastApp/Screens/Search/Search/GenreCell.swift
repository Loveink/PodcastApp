//
//  GenreCell.swift
//  PodcastApp
//
//  Created by Владимир on 25.09.2023.
//

import UIKit

class GenreCell: UICollectionViewCell {
    
    static let identifier = "GenreCollectionViewCell"

    let nameLabel = UILabel.makeLabel(font: .manropeRegular(size: 18), textColor: .white)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configureCell(_ text: String,_ index: Int?) {
        configureUI()
        setupConstraints()
        nameLabel.text = text
        if let index = index {
            configureColour(index)
        }
    }
    
    
    
    private func configureUI() {
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.textAlignment = .center
        self.backgroundColor = .blueMiniPlayer
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.addSubview(nameLabel)
    }
    
    
    private func configureColour(_ indexInt: Int) {
        let index = CGFloat(indexInt)
        let redColour: CGFloat = (204.0 + index * 1.0) / 255
        let greenColour: CGFloat = (226.0 - index * 2.0) / 255
        let blueColour: CGFloat = (252.0 - index * 0.0) / 255
        self.backgroundColor = UIColor(red: redColour, green: greenColour, blue: blueColour, alpha: 1.0)
    }
    
    
    private func setupConstraints() {
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
}
