//
//  CustomTabBar.swift
//  PodcastApp
//
//  Created by Александра Савчук on 23.09.2023.
//

import UIKit

class CustomTabBar: UITabBarController, UITabBarControllerDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
    setupItems()
    setTabBarAppearance()
  }

  private func setupItems() {

    let homepage = HomeViewController()
    homepage.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "HomeFill")?.withRenderingMode(.alwaysOriginal))

    let search = SearchViewController()
    search.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Search")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "SearchFill")?.withRenderingMode(.alwaysOriginal))

    let favorites = FavoritesViewController()
    favorites.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Bookmark")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "BookmarkFill")?.withRenderingMode(.alwaysOriginal))

    let settings = ProfileSettingsViewController()
    settings.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Setting")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "SettingFill")?.withRenderingMode(.alwaysOriginal))

    setViewControllers([homepage, search, favorites, settings], animated: true)
  }

  private func setTabBarAppearance() {
    let positionOnX: CGFloat = 30
    let positionOnY: CGFloat = 7
    let width = tabBar.bounds.width - positionOnX * 2
    let height = tabBar.bounds.height + positionOnY * 2 - 7

    let roundLayer = CAShapeLayer()

    let bezierPath = UIBezierPath(
      roundedRect: CGRect(
        x: positionOnX,
        y: tabBar.bounds.minY + positionOnY - 7,
        width: width,
        height: height
      ),
      cornerRadius: 20
    )
    roundLayer.path = bezierPath.cgPath

    tabBar.itemWidth = width / 6
    tabBar.itemPositioning = .centered

    roundLayer.fillColor = UIColor.white.cgColor
    tabBar.tintColor = .gray

    tabBar.layer.insertSublayer(roundLayer, at: 0)
    tabBar.layer.shadowColor = UIColor.black.cgColor
    tabBar.layer.shadowOffset = CGSize(width: 0, height: 4)
    tabBar.layer.shadowOpacity = 0.3
    tabBar.layer.shadowRadius = 6
  }
}
