//
//  AccountSettingsViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 25.09.2023.
//

import UIKit

class AccountSettingsViewController: UIViewController {
    
    private lazy var accountSettintsView = AccountSettingsView()
    
    private lazy var titleLabel = UILabel.makeLabel(text: "Profile", font: UIFont.plusJakartaSansBold(size: 18), textColor: UIColor.black)
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        button.tintColor = .symbolsPurple
        return button
    }()
    
    private var profileImage: UIImageView = {
        let image = UIImageView()
        //image.image =
        //        image.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        image.backgroundColor = .pinkBackground
        image.layer.cornerRadius = 50
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "pencil.circle.fill")
        image?.withTintColor(.bluePlayer)
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        addSubviews()
        setupConstraints()
        setupNavigation()
        
    }
    
    private func setupNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.manropeRegular(size: 18) ?? UIFont.systemFont(ofSize: 18)
        ]
        
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Profile"
    }
    
    private func addSubviews() {
        view.addSubview(profileImage)
        profileImage.addSubview(editButton)
        view.addSubview(scrollView)
        
        scrollView.addSubview(accountSettintsView)
    }
    
    private func setupConstraints() {
        
        let screenWidth = UIScreen.main.bounds.width
        
        NSLayoutConstraint.activate([
            
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 145),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            
            editButton.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor),
            editButton.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 32),
            editButton.heightAnchor.constraint(equalToConstant: 32),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 261),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            accountSettintsView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            accountSettintsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            accountSettintsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            accountSettintsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            accountSettintsView.heightAnchor.constraint(equalToConstant: 800),
            accountSettintsView.widthAnchor.constraint(equalToConstant: screenWidth)
        ])
    }
    
    
    @objc private func backButtonTapped() {
        print("back button tapped")
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
}
