//
//  AccountImageView.swift
//  PodcastApp
//
//  Created by Caroline Tikhomirova on 29.09.2023.
//

import UIKit

protocol AccountImageViewDelegate: AnyObject {
    func changePictureTapped()
}

class AccountImageView: UIView {
    
    weak var delegate: AccountImageViewDelegate?
    
    //MARK: - UI Components
    
    private var profileImage: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        image.backgroundColor = .pinkBackground
        image.layer.cornerRadius = 50
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "Edit")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Unit
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        setupConstraints()
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    
    private func addSubviews() {
        addSubview(profileImage)
        addSubview(editButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: self.topAnchor),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            profileImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            profileImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            editButton.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 0),
            editButton.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor,constant: 0),
            editButton.widthAnchor.constraint(equalToConstant: 32),
            editButton.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
    
    //MARK: - Methods
    
    @objc private func editButtonTapped() {
            delegate?.changePictureTapped()
        }
}
