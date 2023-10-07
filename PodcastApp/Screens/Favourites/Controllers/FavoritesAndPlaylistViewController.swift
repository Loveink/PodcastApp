//
//  FavoritesAndPlaylistViewController.swift
//  PodcastApp
//
//  Created by Владимир on 07.10.2023.
//

import UIKit
import CoreData

class FavoritesAndPlaylistViewController: UIViewController {
    
    // MARK: - User Interface
    private lazy var playlistsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        //        tableView.backgroundColor = .red.withAlphaComponent(0.5)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var favoritesCollectionView: UICollectionView!
    private var layout = UICollectionViewFlowLayout()
    
    private let favoritesLabel = UILabel.makeLabel(text: "Favorites", font: .manropeBold(size: 16), textColor: .black)
    private let playlistLabel = UILabel.makeLabel(text: "Playlist", font: .manropeBold(size: 16), textColor: .black)
    private let yourPlaylistLabel = UILabel.makeLabel(text: "Your Playlist", font: .manropeBold(size: 16), textColor: .black)
    
    private let seeAllButton = UIButton.makeSeeAllButton()
    private let settingsButton = UIButton.makeKebabMenuButton()
    
    private let createPlaylistButton = UIButton.makeCreatePlaylistButton()
    
    // MARK: - properties
    var favouritePodcasts: [PodcastItemCell] = []
    var playlists: [PlaylistItemCell] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.setupView()
        self.setupTableView()
        self.setLabels()
        self.setButtons()
        self.setupConstraints()
//        setCreatePlaylistButton()
        
//        loadPodcastDataFromCoreData()
        
        
        // mock data
        favouritePodcasts.append(PodcastItemCell(title: "test", image: "", id: 123, author: "test", categories: ["Food": "Politics"]))
        favouritePodcasts.append(PodcastItemCell(title: "test", image: "", id: 123, author: "test", categories: ["Food": "Politics"]))
        favouritePodcasts.append(PodcastItemCell(title: "test", image: "", id: 123, author: "test", categories: ["Food": "Politics"]))
        favouritePodcasts.append(PodcastItemCell(title: "test", image: "", id: 123, author: "test", categories: ["Food": "Politics"]))
        favouritePodcasts.append(PodcastItemCell(title: "test", image: "", id: 123, author: "test", categories: ["Food": "Politics"]))
        favouritePodcasts.append(PodcastItemCell(title: "test", image: "", id: 123, author: "test", categories: ["Food": "Politics"]))
        playlistsTableView.reloadData()
        
        playlists.append(PlaylistItemCell(title: "TEST", image: "", id: 123, episodeCounter: 32))
        playlists.append(PlaylistItemCell(title: "TEST", image: "", id: 123, episodeCounter: 32))
        playlists.append(PlaylistItemCell(title: "TEST", image: "", id: 123, episodeCounter: 32))
        playlists.append(PlaylistItemCell(title: "TEST", image: "", id: 123, episodeCounter: 32))
        playlists.append(PlaylistItemCell(title: "TEST", image: "", id: 123, episodeCounter: 32))
        playlists.append(PlaylistItemCell(title: "TEST", image: "", id: 123, episodeCounter: 32))
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = false
//        loadPodcastDataFromCoreData()
    }
    
    
    // MARK: - Private methodes
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(playlistsTableView)
        view.addSubview(favoritesCollectionView)
        view.addSubview(playlistLabel)
        view.addSubview(favoritesLabel)
        view.addSubview(yourPlaylistLabel)
        view.addSubview(settingsButton)
        view.addSubview(seeAllButton)
        view.addSubview(createPlaylistButton)
    }
    
    private func setLabels() {
        playlistLabel.translatesAutoresizingMaskIntoConstraints = false
        favoritesLabel.translatesAutoresizingMaskIntoConstraints = false
        yourPlaylistLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setButtons() {
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        seeAllButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        createPlaylistButton.addTarget(self, action: #selector(createPlaylistButtonTapped), for: .touchUpInside)
        
    }
    
    private func setCreatePlaylistButton() {
        let createPlaylistLabel = UILabel.makeLabel(text: "Create Playlist", font: .manropeBold(size: 14), textColor: .black)
        createPlaylistLabel.translatesAutoresizingMaskIntoConstraints = false
        let plusImage = UIImage(systemName: "plus")
        let imageView = UIImageView(image: plusImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor( red: 0.93, green: 0.94, blue: 0.99, alpha: 1.00)
        createPlaylistButton.addSubview(imageView)
        createPlaylistButton.addSubview(createPlaylistLabel)
        createPlaylistButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: createPlaylistButton.leftAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 48),
            imageView.topAnchor.constraint(equalTo: createPlaylistButton.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: createPlaylistButton.bottomAnchor),
            
            createPlaylistLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10),
            createPlaylistLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        playlistsTableView.dataSource = self
        playlistsTableView.delegate = self
        
        playlistsTableView.register(
            PlaylistCell.self,
            forCellReuseIdentifier: PlaylistCell.reuseIdentifier)
    }
    
    
    private func setupCollectionView() {
        layout.sectionInset.left = 32
        layout.scrollDirection = .horizontal
        
        favoritesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        favoritesCollectionView.showsVerticalScrollIndicator = false
        favoritesCollectionView.showsHorizontalScrollIndicator = false
        favoritesCollectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.identifier)
        favoritesCollectionView.backgroundColor = .none
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.delegate = self
        favoritesCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
//    MARK: - button actions
    @objc private func seeAllButtonTapped() {
        print("seeAllButtonTapped")
    }
    
    @objc private func settingsButtonTapped() {
        print("settingsButtonTapped")
    }
    
    @objc private func createPlaylistButtonTapped() {
        print("createPlaylistButtonTapped")
    }
    
    
    
//    MARK: - data load
    private func loadPodcastDataFromCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let fetchRequest: NSFetchRequest<PodcastSave> = PodcastSave.fetchRequest()
            let podcastData = try context.fetch(fetchRequest)
            
            favouritePodcasts = podcastData.map { podcast in
                return PodcastItemCell(
                    title: podcast.title ?? "",
                    image: podcast.image ?? "",
                    id: Int(podcast.id),
                    author: "",
                    categories: ["": ""]
                )
            }
            
            playlistsTableView.reloadData()
        } catch {
            print("Ошибка при загрузке данных из Core Data: \(error)")
        }
    }
    
    
}



// MARK: - CollectionView protocols
extension FavoritesAndPlaylistViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouritePodcasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else {
            return UICollectionViewCell()
        }
        let currentPodcast = favouritePodcasts[indexPath.row]
        cell.configureCell(currentPodcast)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}


    
    
// MARK: - table protocols
extension FavoritesAndPlaylistViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PlaylistCell.reuseIdentifier,
            for: indexPath) as? PlaylistCell else {
            return UITableViewCell()
        }
        
        let playlist = self.playlists[indexPath.row]
        cell.setup(playlist)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48+16
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected playlist #\(indexPath.row)!")
    }
}



// MARK: - setup constraints
extension FavoritesAndPlaylistViewController {
    
    private func setupConstraints() {
        
        let constraints: [NSLayoutConstraint] = [
            
            playlistLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            playlistLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            settingsButton.heightAnchor.constraint(equalToConstant: 20),
            settingsButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            settingsButton.widthAnchor.constraint(equalToConstant: 20),

            favoritesLabel.topAnchor.constraint(equalTo: playlistLabel.bottomAnchor, constant: 20),
            favoritesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),

            seeAllButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            seeAllButton.centerYAnchor.constraint(equalTo: favoritesLabel.centerYAnchor),

            favoritesCollectionView.topAnchor.constraint(equalTo: favoritesLabel.bottomAnchor, constant: 20),
            favoritesCollectionView.heightAnchor.constraint(equalToConstant: 160),
            favoritesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            favoritesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            yourPlaylistLabel.topAnchor.constraint(equalTo: favoritesCollectionView.bottomAnchor, constant: 20),
            yourPlaylistLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),

            createPlaylistButton.topAnchor.constraint(equalTo: yourPlaylistLabel.bottomAnchor, constant: 20),
            createPlaylistButton.heightAnchor.constraint(equalToConstant: 48),
            createPlaylistButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            createPlaylistButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            playlistsTableView.topAnchor.constraint(equalTo: createPlaylistButton.bottomAnchor, constant: 8),
            playlistsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            playlistsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            playlistsTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
