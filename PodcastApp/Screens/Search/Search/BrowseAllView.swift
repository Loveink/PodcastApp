//
//  BrowseAllView.swift
//  PodcastApp
//
//  Created by Владимир on 26.09.2023.
//

import UIKit

class BrowseAllView: UIView {
    
    var titleLabel = UILabel()
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
        self.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel = UILabel.makeLabel(text: "Browse all", font: .manropeBold(size: 18), textColor: .black)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .none
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setConstraints() {
        self.addSubview(titleLabel)
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30)
        ])
    }
    
}



extension BrowseAllView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { categoryList.count }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as? GenreCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(categoryList[indexPath.row], indexPath.row)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2 - 35, height: 85)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected Browse All Cell #\(indexPath.item)!")
    }
    
    
}
