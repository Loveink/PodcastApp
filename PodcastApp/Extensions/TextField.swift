//
//  TextField.swift
//  PodcastApp
//
//  Created by Caroline Tikhomirova on 28.09.2023.
//

import UIKit

extension UITextField {

    static func makeBlueTextField(text: String = "") -> UITextField {

        let field = UITextField()
        field.placeholder = text
        field.textColor = .black
        field.backgroundColor = .white
        field.layer.cornerRadius = 24
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.blueBorder.cgColor
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }
}
