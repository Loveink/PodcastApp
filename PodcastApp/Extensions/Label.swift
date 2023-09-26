//
//  Label.swift
//  PodcastApp
//
//  Created by Александра Савчук on 24.09.2023.
//

import UIKit

extension UILabel {
  static func makeLabelForCells(text: String = "", font: UIFont?, textColor: UIColor, numberOfLines: Int) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = font
    label.textColor = textColor
    label.numberOfLines = numberOfLines
    label.adjustsFontSizeToFitWidth = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }

  static func makeLabel(text: String = "", font: UIFont?, textColor: UIColor) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = font
    label.textColor = textColor
    label.adjustsFontSizeToFitWidth = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }
}

//import UIKit

extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

