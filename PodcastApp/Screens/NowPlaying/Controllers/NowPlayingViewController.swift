//
//  NowPlayingViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 25.09.2023.
//

import UIKit

class NowPlayingViewController: UIViewController {

  var podcast = PodcastView()
  var galleryViewController = GalleryViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = .white

      view.addSubview(galleryViewController.collectionView)

      galleryViewController.collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      galleryViewController.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
      galleryViewController.didMove(toParent: self)

    }


}
