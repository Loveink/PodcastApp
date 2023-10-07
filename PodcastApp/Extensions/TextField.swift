//
//  TextField.swift
//  PodcastApp
//
//  Created by Caroline Tikhomirova on 28.09.2023.
//

import UIKit

extension UITextField {
    
    static func makeBlueBorderTextField(text: String = "", textPlaceholder: String = "") -> UITextField {
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        
        let field = UITextField()
        field.text = text
        field.textColor = .black
        field.attributedPlaceholder = NSAttributedString(
            string: textPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.textLightGray])
        field.backgroundColor = .white
        field.layer.cornerRadius = 24
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.blueBorder.cgColor
        field.leftViewMode = .always
        field.leftView = padding
        field.rightView = padding
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }
}
