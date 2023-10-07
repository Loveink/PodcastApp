//
//  CreatePlaylistViewController.swift
//  PodcastApp
//
//  Created by Владимир on 07.10.2023.
//

import UIKit

class CreatePlaylistViewController: UIViewController {

    private let createPlaylistLabel = UILabel.makeLabel(text: "Create Playlist", font: .manropeBold(size: 16), textColor: .black)
    private let backButton = UIButton()
    private let settingsButton = UIButton.makeKebabMenuButton()
    private let imageView = UIImageView()
    private let textField = UITextField()
    private let divisionView = UIView()
    
    private let searchResultVC = SearchResultsViewController("")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    private func configureUI() {
        
    }
    

}


extension CreatePlaylistViewController {
    
    private func setConstraints() {
        createPlaylistLabel.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        divisionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
        ])
    }
}
