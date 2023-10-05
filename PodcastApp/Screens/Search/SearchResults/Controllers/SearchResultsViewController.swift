//
//  SearchResultsViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 25.09.2023.
//

import UIKit


protocol SearchResultCellsDelegate {
    func cellDidSelected(_ podcastItem: PodcastItemCell)
}


class SearchResultsViewController: UIViewController {
    
    var id: [Int] = []
    var feeds: [Feed] = []
    let dispatchGroup = DispatchGroup()
    var fetchFunc: FetchFunc!
    
    
    let searchBar = CustomSearchBar()
    let searchResult = SearchResultView()
    let allPodcasts = AllPodcastsView()
    
    let backButton = UIButton()
    
    
    
    init(_ text: String) {
        super.init(nibName: nil, bundle: nil)
        makeRequest(text)
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
        allPodcasts.delegate = self
    }
    
    

    func configureView() {
//        after API response
//        searchResult.configureView()
        
    }
    
    
    
    func fetchPodcasts(_ text: String) {
        let networkService = NetworkService()
        dispatchGroup.enter()
        
        networkService.fetchData(forPath: "/podcasts/trending?cat=" + text + "&max=15") { [weak self] (result: Result<PodcastSearch, APIError>) in
            guard let self = self else { return }
            
            defer {
                self.dispatchGroup.leave()
            }
            
            switch result {
            case .success(let podcastResponse):
                self.feeds.append(contentsOf: podcastResponse.feeds)
                for podcast in self.feeds {
                    let imageURL = podcast.image
                    
                    DispatchQueue.main.sync {
                        self.fetchFunc = FetchFunc(collectionView: self.allPodcasts.collectionView)
                    }
                    
                    let item = PodcastItemCell(title: podcast.title, image: imageURL, id: podcast.id)
                    
                    self.allPodcasts.podcasts.append(item)
                    
                    id.append(podcast.id)
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    
    
    private func makeRequest(_ text: String) {
        let encodedStr = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        fetchPodcasts(encodedStr)
        dispatchGroup.notify(queue: .main) {
            self.allPodcasts.collectionView.reloadData()
        }
    }
    
    
    private func configureUI() {
        view.backgroundColor = .white
        
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.tintColor = .gray
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchResult.translatesAutoresizingMaskIntoConstraints = false
        allPodcasts.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}




extension SearchResultsViewController: SearchResultCellsDelegate {
    func cellDidSelected(_ podcastItem: PodcastItemCell) {
        let channelVC = ChannelViewController()
        self.navigationController?.pushViewController(channelVC, animated: true)
        
    }
}




extension SearchResultsViewController {
    private func setCostraints() {
        view.addSubview(backButton)
        view.addSubview(searchBar)
        view.addSubview(searchResult)
        view.addSubview(allPodcasts)
        
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
            searchResult.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            searchResult.bottomAnchor.constraint(equalTo: searchResult.topAnchor, constant: 100),
            
            allPodcasts.topAnchor.constraint(equalTo: searchResult.bottomAnchor),
            allPodcasts.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            allPodcasts.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            allPodcasts.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
