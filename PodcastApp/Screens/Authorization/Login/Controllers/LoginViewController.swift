//
//  LoginViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 25.09.2023.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - UI Elements

    let loginView = LoginView()

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    // MARK: - Methods

    private func layout() {

        view.addSubview(loginView)

        NSLayoutConstraint.activate([

            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
