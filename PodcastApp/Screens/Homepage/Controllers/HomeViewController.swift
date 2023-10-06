//
//  HomeViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 01.10.2023.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {
    
    let topInfoView = TopInfoView()
    let categoryCollectionView = PopularCollectionView()
    let trendingCollectionView = TrendingCollectionView()
    let categoriesName = CategoriesNames()
    
    var feeds: [Feed] = []
    var id: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        fetchPodcasts()
        categoryCollectionView.delegate = self
        trendingCollectionView.categoryDictionary = categoryDictionary
    }
    
    private func setupCollectionView() {
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        trendingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoriesName.translatesAutoresizingMaskIntoConstraints = false
        
//        view.addSubview(topInfoView)
        view.addSubview(categoryCollectionView)
        view.addSubview(trendingCollectionView)
        view.addSubview(categoriesName)
        view.addSubview(topInfoView)
        
        NSLayoutConstraint.activate([
            
            topInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            topInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            topInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            topInfoView.heightAnchor.constraint(equalToConstant: 70),
            
            trendingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            trendingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            trendingCollectionView.topAnchor.constraint(equalTo: topInfoView.bottomAnchor, constant: 10),
            trendingCollectionView.heightAnchor.constraint(equalToConstant: 250),
            
            categoriesName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            categoriesName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categoriesName.topAnchor.constraint(equalTo: trendingCollectionView.bottomAnchor),
            categoriesName.heightAnchor.constraint(equalToConstant: 70),
            
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            categoryCollectionView.topAnchor.constraint(equalTo: categoriesName.bottomAnchor, constant: 10),
            categoryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    func fetchPodcasts() {
        let networkService = NetworkService()
        
        networkService.fetchData(forPath: "/podcasts/trending?max=10") { [weak self] (result: Result<PodcastSearch, APIError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let podcastResponse):
                self.feeds.append(contentsOf: podcastResponse.feeds)
                
                for podcast in self.feeds {
                    let imageURL = podcast.image
                    let podcastItem = PodcastItemCell(title: podcast.title, image: imageURL, id: podcast.id, author: podcast.author, categories: podcast.categories)
                    self.categoryCollectionView.podcasts.append(podcastItem)
                    self.id.append(podcast.id)
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

extension HomeViewController: PopularCollectionViewDelegate {
    func didSelectPodcast(id: Int) {
        let channelVC = ChannelViewController()
        channelVC.channelID = id
        
        if let index = feeds.firstIndex(where: { $0.id == id }) {
            let selectedFeed = feeds[index]
            channelVC.channelTitleLabel.text = selectedFeed.title
            let imageURLString = selectedFeed.image
            
            if let imageURL = URL(string: imageURLString) {
                URLSession.shared.dataTask(with: imageURL) { (data, _, _) in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            channelVC.channelImageView.image = image
                            self.navigationController?.pushViewController(channelVC, animated: true)
                        }
                    }
                }.resume()
            }
        }
    }
}
