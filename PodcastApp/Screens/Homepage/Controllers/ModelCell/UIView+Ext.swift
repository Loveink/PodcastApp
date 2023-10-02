//
//  UIView + ext.swift
//  WorkoutApp
//
//  Created by Максим Нурутдинов on 28.09.2023.
//

import UIKit

extension UIView {

    @objc func setupView(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

    }

}
