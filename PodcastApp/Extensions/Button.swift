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
}
