//
//  SearchViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 23.09.2023.
//

import UIKit


protocol SearchViewControllerDelegate {
    func startTyping()
    func endTyping()
}

protocol SearchCellsDelegate {
    func cellDidSelected(_ text: String)
}



class SearchViewController: UIViewController {
    
    var gestureRecognizer = UITapGestureRecognizer()
    
    let searchBar = CustomSearchBar()
    var topGenresView = TopGenresView()
    var browseAllView = BrowseAllView()
    
    var standartConstraints = [NSLayoutConstraint]()
    var bigTopGenresConstraints = [NSLayoutConstraint]()
    
    var cellDidSelected: (_ text: String) -> () = {_ in }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setBackgroundGradient()
        configureUI()
        configureConstraints()
        addGestureRecognizer()
        
        topGenresView.delegate = self
        browseAllView.delegate = self
    }
    
    
    
    private func configureUI() {
        searchBar.delegate = self
        searchBar.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        topGenresView.seeAllButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
    }
    
    
    private func addGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endTyping))
        gestureRecognizer.isEnabled = false
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc func seeAllButtonTapped() {
        browseAllView.isHidden = !browseAllView.isHidden
        topGenresView.seeAllButton.isSelected = !topGenresView.seeAllButton.isSelected
        
        UIView.animate(withDuration: 0.3, delay: 0.3) {
            if self.browseAllView.isHidden {
                    NSLayoutConstraint.deactivate(self.standartConstraints)
                    self.topGenresView.setDirection(.vertical)
                    NSLayoutConstraint.activate(self.bigTopGenresConstraints)
            } else {
                    NSLayoutConstraint.deactivate(self.bigTopGenresConstraints)
                    self.topGenresView.setDirection(.horizontal)
                    NSLayoutConstraint.activate(self.standartConstraints)
            }
        }
        
        gestureRecognizer.isEnabled = false
        _ = searchBar.resignFirstResponder()
    }
    
}


extension SearchViewController: SearchViewControllerDelegate {
    
    func startTyping() {
        gestureRecognizer.isEnabled = true
    }
    
    @objc func endTyping() {
        gestureRecognizer.isEnabled = false
        _ = searchBar.resignFirstResponder()
    }
    
    @objc func searchButtonTapped() {
        endTyping()
        guard let text = searchBar.textField.text else { return }
        if text != "" {
            let resultVC = SearchResultsViewController(text)
            navigationController?.pushViewController(resultVC, animated: true)
        }
    }
}


extension SearchViewController: SearchCellsDelegate {
    func cellDidSelected(_ text: String) {
        endTyping()
        let resultVC = SearchResultsViewController(text)
        navigationController?.pushViewController(resultVC, animated: true)
    }
}



extension SearchViewController {
    private func configureConstraints() {
        view.addSubview(searchBar)
        view.addSubview(topGenresView)
        view.addSubview(browseAllView)
        
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        standartConstraints = [
            topGenresView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            topGenresView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topGenresView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topGenresView.heightAnchor.constraint(equalToConstant: 150),
            
            browseAllView.topAnchor.constraint(equalTo: topGenresView.bottomAnchor, constant: 10),
            browseAllView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            browseAllView.leftAnchor.constraint(equalTo: view.leftAnchor),
            browseAllView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        
        bigTopGenresConstraints = [
            topGenresView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            topGenresView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            topGenresView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            topGenresView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(standartConstraints)
    }
}
