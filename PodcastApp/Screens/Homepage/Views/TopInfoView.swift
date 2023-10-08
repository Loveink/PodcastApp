//
//  TopInfoView.swift
//  PodcastApp
//
//  Created by Анастасия Рыбакова on 06.10.2023.
//

import UIKit

class TopInfoView: UIView {
    
    
    private lazy var nameLabel = UILabel.makeLabel(
        text: "Abigael Amaniah",
        font: UIFont.plusJakartaSansBold(size: 16),
        textColor: UIColor.black
    )
    
    private lazy var credoLabel = UILabel.makeLabel(
        text: "Love,life and chill",
        font: UIFont.plusJakartaSansMedium(size: 14),
        textColor: UIColor.darkGray
    )
    
    private lazy var avatarImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFill
       imageView.layer.cornerRadius = 10
       imageView.backgroundColor = UIColor(
           red: 0.68, green: 0.89, blue: 0.95, alpha: 1.00)
       imageView.clipsToBounds = true
       imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
   }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupView()
      setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
//        self.backgroundColor = .red
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        addSubview(credoLabel)
        addSubview(avatarImageView)
    }
    
    private func setupConstraints() {
        
        let constraints: [NSLayoutConstraint] = [
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            credoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor ,constant: 5),
            credoLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            
            
            avatarImageView.heightAnchor.constraint(equalToConstant: 48),
            avatarImageView.widthAnchor.constraint(equalToConstant: 48),
            avatarImageView.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}


