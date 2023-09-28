//
//  ChannelViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 25.09.2023.
//

import UIKit

class ChannelViewController: UIViewController {

// MARK: - User Interface
    
    private let channelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 21
        imageView.backgroundColor = UIColor(
            red: 0.68, green: 0.89, blue: 0.95, alpha: 1.00)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var channelTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Manrope", size: 16)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var numberOfEpisodes: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont(name: "Manrope", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dashLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .lightGray
        label.text = "|"
        label.font = UIFont(name: "Manrope", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var channelAuthor: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont(name: "Manrope", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = CGFloat(5)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var collectionTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "All Episodes"
        label.font = UIFont(name: "Manrope", size: 16)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var episodesCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
// MARK: - private properties
    private let episodes = EpisodeModel.makeMockData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
        self.setupCollectionView()
        self.setupNavigationBar()
        self.setupChannel()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(channelImageView)
        view.addSubview(channelTitleLabel)
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(numberOfEpisodes)
        stackView.addArrangedSubview(dashLabel)
        stackView.addArrangedSubview(channelAuthor)
        
        view.addSubview(collectionTitle)
        view.addSubview(episodesCollectionView)
    }
    
    private func setupCollectionView() {
        episodesCollectionView.dataSource = self
        episodesCollectionView.delegate = self
        
        episodesCollectionView.register(
            EpisodeCell.self,
            forCellWithReuseIdentifier: EpisodeCell.reuseIdentifier)
    }

    private func setupNavigationBar() {
        self.navigationItem.title = "Channel"
    }
    
    private func setupChannel() {
        channelTitleLabel.text = "Baby Pesut Podcast"
        numberOfEpisodes.text = "56 Esp"
        channelAuthor.text = "Dr. Oi om jean"
    }
    

}


// MARK: - collection protocols

extension ChannelViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EpisodeCell.reuseIdentifier,
            for: indexPath) as? EpisodeCell else {
            let cell = EpisodeCell()
            return cell
        }
        
        let episode = self.episodes[indexPath.row]
        cell.setup(withEpisode: episode)
        return cell
    }
}


extension ChannelViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(
            top: 0,
            left: 32,
            bottom: 0,
            right: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width - 32*2
        
        return CGSize(width: width, height: 72)
    }
    
}

// MARK: - setup constraints
extension ChannelViewController {
    
    private func setupConstraints() {
        
        let constraints: [NSLayoutConstraint] = [
            
            channelImageView.heightAnchor.constraint(equalToConstant: 84),
            channelImageView.widthAnchor.constraint(equalToConstant: 84),
            channelImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            channelImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            channelTitleLabel.topAnchor.constraint(equalTo: channelImageView.bottomAnchor, constant: 20),
            channelTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: channelTitleLabel.bottomAnchor, constant: 5),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            collectionTitle.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 32),
            
            episodesCollectionView.topAnchor.constraint(equalTo: collectionTitle.bottomAnchor, constant: 16),
            episodesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            episodesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            episodesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
