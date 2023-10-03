//
//  ChangePictureButton.swift
//  PodcastApp
//
//  Created by Caroline Tikhomirova on 03.10.2023.
//

import UIKit

final class ChangePictureButton: UIButton {
    
    //MARK: - Properties
    
    enum ButtonStyle: String {
        case takeAPhoto = "Take a photo"
        case chooseFrom = "Choose from your files"
        case deletePhoto = "Delete Photo"
    }
    
    private let style: ButtonStyle
    
    //MARK: - Unit
    
    init(withStyle style: ButtonStyle) {
        self.style = style
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func configure() {
        switch style {
        case .takeAPhoto:
            setImage(UIImage(named: "TakePhoto")!, for: .normal)
            setTitleColor(.black, for: .normal)
        case .chooseFrom:
            setImage(UIImage(named: "Folder")!, for: .normal)
            setTitleColor(.black, for: .normal)
        case .deletePhoto:
            setImage(UIImage(named: "Delete")!, for: .normal)
            setTitleColor(.textRed, for: .normal)
        }
        
        let imageInsets = UIEdgeInsets(top: 18, left: 16, bottom: 18, right: 259)
        let titleInsets = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 32)
        
        setTitle(style.rawValue, for: .normal)
        titleLabel?.font = UIFont.plusJakartaSansBold(size: 14)
        backgroundColor = .lightGray
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        contentHorizontalAlignment = .left
        imageEdgeInsets = imageInsets
        titleEdgeInsets = titleInsets
        layer.cornerRadius = 8
        layer.borderColor = UIColor.blueBorder.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
