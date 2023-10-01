//
//  AccountSettingsViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 25.09.2023.
//

import UIKit

class AccountSettingsViewController: UIViewController {
    
    //MARK: - UI Components
    
    private lazy var accountSettingsView = AccountSettingsView()
    
    private lazy var titleLabel = UILabel.makeLabel(text: "Profile", font: UIFont.plusJakartaSansBold(size: 18), textColor: UIColor.black)
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        button.tintColor = .symbolsPurple
        return button
    }()
    
    private lazy var accountImageView = AccountImageView()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        addSubviews()
        setupConstraints()
        setupNavigation()
        
    }
    
    private func setupNavigation() {
    
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = titleLabel
        
    }
    
    //MARK: - Layout
    
    private func addSubviews() {
        view.addSubview(accountImageView)
        view.addSubview(scrollView)
        
        scrollView.addSubview(accountSettingsView)
    }
    
    private func setupConstraints() {
        
        let screenWidth = UIScreen.main.bounds.width
        
        NSLayoutConstraint.activate([
            
            accountImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 145),
            accountImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            accountImageView.widthAnchor.constraint(equalToConstant: 100),
            accountImageView.heightAnchor.constraint(equalToConstant: 100),
        
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 261),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            accountSettingsView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            accountSettingsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            accountSettingsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            accountSettingsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            accountSettingsView.heightAnchor.constraint(equalToConstant: 760),
            accountSettingsView.widthAnchor.constraint(equalToConstant: screenWidth)
        ])
    }
    
    //MARK: - Methods

    @objc private func backButtonTapped() {
        print("back button tapped")
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
}
