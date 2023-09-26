//
//  CustomTabBar.swift
//  PodcastApp
//
//  Created by Александра Савчук on 23.09.2023.
//

import UIKit

class CustomTabBar: UITabBarController, UITabBarControllerDelegate {

  override func viewDidLoad() {
      setupTabBar()
      super.viewDidLoad()
      self.delegate = self
      setupItems()
  }

  private func setupTabBar() {
    tabBar.backgroundColor = .white
    tabBar.layer.cornerRadius = 30
  }

  private func setupItems() {

    let homepage = HomeViewController()
    homepage.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "HomeFill")?.withRenderingMode(.alwaysOriginal))

    let search = NowPlayingViewController()
    search.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Search")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "SearchFill")?.withRenderingMode(.alwaysOriginal))

    let favorites = FavoritesViewController()
    favorites.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Bookmark")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "BookmarkFill")?.withRenderingMode(.alwaysOriginal))

    let settings = ProfileSettingsViewController()
    settings.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Setting")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "SettingFill")?.withRenderingMode(.alwaysOriginal))

    setViewControllers([homepage, search, favorites, settings], animated: true)
  }
}
