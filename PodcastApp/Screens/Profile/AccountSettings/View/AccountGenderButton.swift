//
//  AccountGenderButton.swift
//  PodcastApp
//
//  Created by Caroline Tikhomirova on 01.10.2023.
//

import UIKit

class AccountGenderButton: UIButton {

    enum ButtonStyle: String {
        case male = "Male"
        case female = "Female"
    }
    
    private let style: ButtonStyle
    
    private let checkOn = UIImage(named: "checkOn")
    private let checkOff = UIImage(named: "checkOff")
    
    private var isOn: Bool
    
    let imageInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 116)
    let titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 32)
    
    init(withStyle style: ButtonStyle, isOn: Bool = false) {
        self.style = style
        self.isOn = isOn
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCheck(status: Bool) {
        if status {
            self.isOn = true
            setImage(checkOn, for: .normal)
        } else {
            self.isOn = false
            setImage(checkOff, for: .normal)
        }
    }
    
    private func configure() {
        if isOn {
            setImage(checkOn, for: .normal)
        } else {
            setImage(checkOff, for: .normal)
        }
        setTitle(style.rawValue, for: .normal)
        titleLabel?.font = UIFont.plusJakartaSansSemiBold(size: 16)
        heightAnchor.constraint(equalToConstant: 52).isActive = true
        setTitleColor(.black, for: .normal)
        imageEdgeInsets = imageInsets
        titleEdgeInsets = titleInsets
        layer.cornerRadius = 24
        layer.borderWidth = 1
        layer.borderColor = UIColor.blueBorder.cgColor
    }

}
