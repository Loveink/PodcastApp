//
//  CollectionViewCell2.swift
//  WorkoutApp
//
//  Created by Максим Нурутдинов on 28.09.2023.
//

import UIKit

final class CollectionViewCell2: UICollectionViewCell {
    static let id = "CollectionViewCell2"
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 3
        return view
    }()
    
    private let imagePinkView2: UIImageView = {
        let imagePinkView = UIImageView()
        imagePinkView.image = R.Images.Overview.imagePink
        imagePinkView.layer.cornerRadius = 16
        imagePinkView.layer.masksToBounds = true
        return imagePinkView
    }()
    private let imageWhiteView2: UIImageView = {
        let imagePinkView = UIImageView()
        imagePinkView.image = R.Images.Overview.imageWhite?.alpha(0.3)
        imagePinkView.layer.cornerRadius = 16
        imagePinkView.layer.masksToBounds = true
        return imagePinkView
    }()
    

    private let title2 = UILabel.makeLabel(text: "title2", font: R.Fonts.helvelticaRegular(with: 14), textColor: R.Colors.titleGray)

    private let subtitle2 = UILabel.makeLabel(text: "subtitle2", font: R.Fonts.helvelticaRegular(with: 14), textColor: R.Colors.titleGray)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        constaintViews()
//                configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
                setupViews()
                constaintViews()
//                configureAppearance()
    }
}

private extension CollectionViewCell2 {
    func setupViews() {
        setupView(imagePinkView2)
        setupView(imageWhiteView2)
        imageWhiteView2.setupView(title2)
        imageWhiteView2.setupView(subtitle2)
    }
    
    func constaintViews() {
        NSLayoutConstraint.activate([
            
            imagePinkView2.heightAnchor.constraint(equalToConstant: 200),
            imagePinkView2.widthAnchor.constraint(equalToConstant: 144),
            
            imageWhiteView2.heightAnchor.constraint(equalToConstant: 64),
            imageWhiteView2.widthAnchor.constraint(equalToConstant: 144),
            imageWhiteView2.bottomAnchor.constraint(equalTo: imagePinkView2.bottomAnchor),
      
            title2.topAnchor.constraint(equalTo: imageWhiteView2.topAnchor,constant: 14),
            title2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            subtitle2.leadingAnchor.constraint(equalTo: title2.leadingAnchor),
            subtitle2.topAnchor.constraint(equalTo: title2.bottomAnchor, constant: 5),
        
            
        ])
    }
}

