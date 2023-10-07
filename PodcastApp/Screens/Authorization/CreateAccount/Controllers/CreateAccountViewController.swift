//
//  CreateAccountViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 25.09.2023.
//

import UIKit

class CreateAccountViewController: UIViewController {

    // MARK: - UI Elements
    
    private lazy var createAccountView = CreateAccountView()

    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .done, target: self, action: #selector(backButtonAction))
        button.tintColor = .purple
        return button
    }()

    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        createAccountView.navigationController = navigationController
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Methods

    private func layout() {

        view.addSubview(createAccountView)

        NSLayoutConstraint.activate([

            createAccountView.topAnchor.constraint(equalTo: view.topAnchor),
            createAccountView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            createAccountView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            createAccountView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        ])
    }

    //MARK: - Selectors

    @objc private func backButtonAction() {
        print("back button tapped")
        self.navigationController?.popViewController(animated: true)
    }
}
