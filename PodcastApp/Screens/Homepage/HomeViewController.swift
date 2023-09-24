//
//  HomeViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 23.09.2023.
//

import UIKit

class HomeViewController: UIViewController {

  let mainLabel = UILabel.makeLabel(text: "Home", font: .plusJakartaSansBold(size: 40), textColor: .bluePlayer)
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = .white
      view.addSubview(mainLabel)
      mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }


}
