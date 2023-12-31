//
//  SearchResultsViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 25.09.2023.
//

import UIKit


protocol SearchResultCellsDelegate {
    func cellDidSelected(_ id: Int)
}


class SearchResultsViewController: UIViewController {
    
    var id: [Int] = []
    var feeds: [Feed] = []
    let dispatchGroup = DispatchGroup()

    let errorLabel = UILabel.makeLabel(text: "No results...", font: .manropeRegular(size: 14), textColor: .black)
    
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    

    func configureSearchResult(_ podcastItem: PodcastItemCell) {
        self.searchResult.configureView(podcastItem)
    }
    
    
    
    private func fetchPodcasts(_ text: String) {
        let networkService = NetworkService()
        dispatchGroup.enter()
        
        networkService.fetchData(forPath: "/podcasts/trending?cat=" + text + "&max=20") { [weak self] (result: Result<PodcastSearch, APIError>) in
            guard let self = self else { return }
            defer {
                self.dispatchGroup.leave()
            }
            switch result {
            case .success(let podcastResponse):
                self.feeds.append(contentsOf: podcastResponse.feeds)
                for podcast in self.feeds {
                    let imageURL = podcast.image
                    let item = PodcastItemCell(title: podcast.title, image: imageURL, id: podcast.id, author: podcast.author, categories: podcast.categories)
                    self.allPodcasts.podcasts.append(item)
                    DispatchQueue.main.async {
                        if self.searchResult.titleLabel.text == "" {
                            self.configureSearchResult(item)
                        }
                    }
                    id.append(podcast.id)
                }
                
            case .failure(let error):
                print("Error: \(error)")
                DispatchQueue.main.async {
                    self.allPodcasts.isHidden = true
                    self.searchResult.makeInvisible()
                    self.errorLabel.isHidden = false
                }
            }
        }
    }
    
  private func fetchPodcastsByTerm(_ term: String) {
      let networkService = NetworkService()
      dispatchGroup.enter()

      networkService.fetchData(forPath: "/search/byterm?q=" + term) { [weak self] (result: Result<PodcastSearch, APIError>) in
          guard let self = self else { return }
          defer {
              self.dispatchGroup.leave()
          }
          switch result {
          case .success(let podcastResponse):
              self.feeds.append(contentsOf: podcastResponse.feeds)
              for podcast in self.feeds {
                  let imageURL = podcast.image
                  let item = PodcastItemCell(title: podcast.title, image: imageURL, id: podcast.id, author: podcast.author, categories: podcast.categories)
                  self.allPodcasts.podcasts.append(item)
                  DispatchQueue.main.async {
                      if self.searchResult.titleLabel.text == "" {
                          self.configureSearchResult(item)
                      }
                  }
                  self.id.append(podcast.id)
              }

          case .failure(let error):
              print("Error: \(error)")
              DispatchQueue.main.async {
                  self.allPodcasts.isHidden = true
                  self.searchResult.makeInvisible()
                  self.errorLabel.isHidden = false
              }
          }
      }
  }

    
    private func makeRequest(_ text: String) {
        let encodedStr = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        fetchPodcastsByTerm(encodedStr)
        dispatchGroup.notify(queue: .main) {
            self.allPodcasts.collectionView.reloadData()
        }
    }
    
    
    @objc func searchButtonTapped() {
        id = []
        feeds = []
        allPodcasts.podcasts = []
        errorLabel.isHidden = true
        allPodcasts.isHidden = false
        searchResult.makeVisible()
        makeRequest(searchBar.textField.text ?? "")
    }
    
    private func configureUI() {
        searchBar.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        view.backgroundColor = .white
        
        errorLabel.isHidden = true
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        searchResult.button.addTarget(self, action: #selector(firstCellSelected), for: .touchUpInside)
        
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
    
    @objc private func firstCellSelected() {
        cellDidSelected(id[0])
    }
    
}




extension SearchResultsViewController: SearchResultCellsDelegate {
  func cellDidSelected(_ id: Int) {
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




extension SearchResultsViewController {
    private func setCostraints() {
        view.addSubview(backButton)
        view.addSubview(searchBar)
        view.addSubview(searchResult)
        view.addSubview(allPodcasts)
        view.addSubview(errorLabel)
        
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
            
            allPodcasts.topAnchor.constraint(equalTo: searchResult.bottomAnchor, constant: 30),
            allPodcasts.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            allPodcasts.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            allPodcasts.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
