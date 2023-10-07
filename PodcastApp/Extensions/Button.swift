//
//  Button.swift
//  PodcastApp
//
//  Created by Владимир on 06.10.2023.
//

import Foundation
import UIKit

extension UIButton {
    static func makeSeeAllButton() -> UIButton {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitle("Hide", for: .selected)
        button.titleLabel?.textAlignment = .right
        button.titleLabel?.font = .manropeRegular(size: 16)
        button.setTitleColor(.darkGray, for: .normal)
        return button
    }
    
    static func makeCreatePlaylistButton() -> UIButton {
        let button = UIButton()
        let createPlaylistLabel = UILabel.makeLabel(text: "Create Playlist", font: .manropeBold(size: 14), textColor: .black)
        createPlaylistLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let plusImage = UIImage(systemName: "plus")
        let imageView = UIImageView(image: plusImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let imageViewBackground = UIView()
        imageViewBackground.backgroundColor = UIColor( red: 0.93, green: 0.94, blue: 0.99, alpha: 1.00)
        imageViewBackground.translatesAutoresizingMaskIntoConstraints = false
        imageViewBackground.tintColor = .gray
        imageViewBackground.layer.cornerRadius = 8
        imageViewBackground.clipsToBounds = true
        imageViewBackground.addSubview(imageView)
        
        button.addSubview(createPlaylistLabel)
        button.addSubview(imageViewBackground)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageViewBackground.leftAnchor.constraint(equalTo: button.leftAnchor),
            imageViewBackground.widthAnchor.constraint(equalToConstant: 48),
            imageViewBackground.topAnchor.constraint(equalTo: button.topAnchor),
            imageViewBackground.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            
            imageView.centerYAnchor.constraint(equalTo: imageViewBackground.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: imageViewBackground.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            
            createPlaylistLabel.leftAnchor.constraint(equalTo: imageViewBackground.rightAnchor, constant: 10),
            createPlaylistLabel.centerYAnchor.constraint(equalTo: imageViewBackground.centerYAnchor)
        ])
        button.backgroundColor = .brown
        return button
    }
    
    static func makeKebabMenuButton() -> UIButton {
        let button = UIButton()
        let settingsImage = UIImage(systemName: "ellipsis")!
        let rotatedSettingsImage = settingsImage.rotate(radians: CGFloat.pi / 2.0)
        button.setImage(rotatedSettingsImage, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
