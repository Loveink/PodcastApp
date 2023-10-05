//
//  AllPodcatsView.swift
//  PodcastApp
//
//  Created by Владимир on 03.10.2023.
//

import UIKit


class AllPodcastsView: UIView {
    
    var delegate: SearchResultCellsDelegate?
    
    let dispatchGroup = DispatchGroup()
    
    var podcasts: [PodcastItemCell] = []
    
    let titleLabel = UILabel.makeLabel(text: "All Podcasts", font: .manropeRegular(size: 14), textColor: .black)
    var collectionView: UICollectionView!
    
    
    
    init() {
        super.init(frame: .zero)
        configureUI()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configureUI() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        addSubview(titleLabel)
        collectionView.backgroundColor = .none
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
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
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


extension AllPodcastsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { podcasts.count - 1}
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else {
            return UICollectionViewCell()
        }
        let podcast = self.podcasts[indexPath.row + 1]
        cell.configureCell(podcast)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 76)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let podcast = self.podcasts[indexPath.row + 1]
        delegate?.cellDidSelected(podcast.id)
    }
    
}

