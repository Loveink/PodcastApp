//
//  AllPodcatsView.swift
//  PodcastApp
//
//  Created by Владимир on 03.10.2023.
//

import UIKit


class AllPodcastsView: UIView {
    
    let dispatchGroup = DispatchGroup()
    
    var podcasts: [PodcastItemCell] = [] {
      didSet {
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    }
    
    let titleLabel = UILabel.makeLabel(text: "All Podcasts", font: .manropeRegular(size: 14), textColor: .black)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    
    init() {
        super.init(frame: .zero)
        configureUI()
        setConstraints()
        podcasts.append(PodcastItemCell(title: "TITLE", image: "image", id: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func appendCell(_ cell: PodcastItemCell, _ url: String) {
//        let episodeCell = EpisodeItemCell(title: cell.title, image: cell.image, audioURL: <#T##String#>, duration: <#T##Int#>)
    }
    
    
    private func configureUI() {
        addSubview(titleLabel)
        collectionView.backgroundColor = .brown
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            EpisodeCell.self, forCellWithReuseIdentifier: EpisodeCell.reuseIdentifier)
        addSubview(collectionView)

    }
    
}



extension AllPodcastsView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


extension AllPodcastsView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { podcasts.count }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCell.reuseIdentifier, for: indexPath) as? EpisodeCell else {
            let cell = EpisodeCell()
            return cell
        }
        let podcast = self.podcasts[indexPath.row]
        cell.setup(withEpisode: EpisodeItemCell(title: podcast.title, image: podcast.image, audioURL: "", duration: 0))
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(frame)
        return CGSize(width: frame.width - 35, height: 85)
    }
    
}

