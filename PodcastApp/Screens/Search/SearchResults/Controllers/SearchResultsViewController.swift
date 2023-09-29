//
//  SearchResultsViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 25.09.2023.
//

import UIKit

class SearchResultsViewController: UIViewController {

    let searchBar = CustomSearchBar()
    let searchResult = SearchResultView()
    
    let backButton = UIButton()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    
    init(_ text: String) {
        super.init(nibName: nil, bundle: nil)
//            -----------
//            API REQUEST
//            -----------
        searchBar.textField.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setCostraints()
        searchBar.setCloseSquare()
    }
    
    

    func configureView() {
//        after API response
//        searchResult.configureView(<#T##title: String##String#>, <#T##image: UIImage##UIImage#>, <#T##episodes: String##String#>, <#T##creator: String##String#>)
        
    }
    
    
    
    private func configureUI() {
        view.backgroundColor = .white
        
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.tintColor = .gray
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchResult.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func setCostraints() {
        view.addSubview(backButton)
        view.addSubview(searchBar)
        view.addSubview(searchResult)
        
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            backButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            searchResult.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            searchResult.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            searchResult.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
    }
    
}
