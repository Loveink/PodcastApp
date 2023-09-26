//
//  NowPlayingViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 25.09.2023.
//

import UIKit

class NowPlayingViewController: UIViewController {

  var podcast = PodcastView()
  var galleryViewController = GalleryView()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    setupConstraints()

  }
  
  func setupConstraints() {
    galleryViewController.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(galleryViewController)

    NSLayoutConstraint.activate([
      galleryViewController.topAnchor.constraint(equalTo: view.topAnchor),
      galleryViewController.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      galleryViewController.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      galleryViewController.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}
