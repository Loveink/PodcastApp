//
//  TopGenresView.swift
//  PodcastApp
//
//  Created by Владимир on 25.09.2023.
//

import UIKit

class TopGenresView: UIView {
    
    var delegate: SearchCellsDelegate?
    
    var titleLabel = UILabel.makeLabel(text: "Top Genres", font: .manropeBold(size: 18), textColor: .black)
    let layout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView!
    let seeAllButton = UIButton.makeSeeAllButton()
    
    var standartConstraint = [NSLayoutConstraint]()
    var bigViewConstraint = [NSLayoutConstraint]()
    
    
    
    init() {
        super.init(frame: .zero)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setDirection(_ direction: UICollectionView.ScrollDirection) {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = direction
        }
        
        if direction == .horizontal {
            NSLayoutConstraint.deactivate(bigViewConstraint)
            NSLayoutConstraint.activate(standartConstraint)
            layout.sectionInset.left = 30
        } else {
            NSLayoutConstraint.deactivate(standartConstraint)
            NSLayoutConstraint.activate(bigViewConstraint)
            layout.sectionInset.left = 0
        }
    }
    
    
    
    private func configureUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .none
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        layout.scrollDirection = .horizontal
        layout.sectionInset.left = 30
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        collectionView.backgroundColor = .none  
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setConstraints() {
        self.addSubview(titleLabel)
        self.addSubview(seeAllButton)
        self.addSubview(collectionView)
        
        standartConstraint = [
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            seeAllButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30)
        ]
        bigViewConstraint = [
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            seeAllButton.rightAnchor.constraint(equalTo: self.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(standartConstraint)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            seeAllButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            seeAllButton.heightAnchor.constraint(equalToConstant: 30),
            
            collectionView.topAnchor.constraint(equalTo: seeAllButton.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }

}



extension TopGenresView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { topGenresList.count }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as? GenreCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(topGenresList[indexPath.row], indexPath.row)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if frame.minX == 0.0 {
            return CGSize(width: 150, height: 85)
        }
        return CGSize(width: frame.width / 2 - 5, height: 85)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let text = topGenresList[indexPath.item]
        delegate?.cellDidSelected(text)
        
    }
    
}
