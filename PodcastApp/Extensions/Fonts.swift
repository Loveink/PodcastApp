//
//  Fonts.swift
//  PodcastApp
//
//  Created by Александра Савчук on 24.09.2023.
//

import UIKit

extension UIFont {

  static func sfProRegular(size: CGFloat) -> UIFont? {
    return UIFont(name: "SF-Pro-Display-Regular", size: size)
  }

  static func sfProSemiBold(size: CGFloat) -> UIFont? {
    return UIFont(name: "SF-Pro-Display-Semibold", size: size)
  }

  static func manropeBold(size: CGFloat) -> UIFont? {
    return UIFont(name: "Manrope-Bold", size: size)
  }

  static func manropeRegular(size: CGFloat) -> UIFont? {
    return UIFont(name: "Manrope-Regular", size: size)
  }

  static func plusJakartaSansBold(size: CGFloat) -> UIFont? {
    return UIFont(name: "PlusJakartaSans-Bold", size: size)
  }

  static func plusJakartaSansMedium(size: CGFloat) -> UIFont? {
    return UIFont(name: "PlusJakartaSans-Medium", size: size)
  }

  static func plusJakartaSansSemiBold(size: CGFloat) -> UIFont? {
    return UIFont(name: "PlusJakartaSans-SemiBold", size: size)
  }
}
