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
    // Добавьте galleryViewController на основное представление
    galleryViewController.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(galleryViewController)

    // Добавьте podcast на основное представление
    podcast.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(podcast)

    // Установите констрейнты для galleryViewController
    NSLayoutConstraint.activate([
      galleryViewController.topAnchor.constraint(equalTo: view.topAnchor),
      galleryViewController.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      galleryViewController.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      galleryViewController.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7) // Регулируйте множитель для нужного размера
    ])

    // Установите констрейнты для podcast
    NSLayoutConstraint.activate([
      podcast.topAnchor.constraint(equalTo: galleryViewController.bottomAnchor, constant: -100),
      podcast.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      podcast.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//      podcast.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
      podcast.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
