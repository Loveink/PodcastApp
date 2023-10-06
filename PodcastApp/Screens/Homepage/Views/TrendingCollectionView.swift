//
//  TrendingCollectionView.swift
//  BestRecipes
//
//  Created by Александра Савчук on 27.08.2023.
//

import UIKit

class TrendingCollectionView: UIView {
    
    private lazy var categoryLabel = UILabel.makeLabel(
        text: "Category",
        font: UIFont.plusJakartaSansBold(size: 16),
        textColor: UIColor.black
    )
    
    private lazy var seeAllButton = UIButton.makeSeeAllButton()
    
    let layout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView!
    weak var delegate: TrendingCollectionViewDelegate?
    
    var podcasts: [CategoryInfoForCell] = []
    var categoryDictionary: [String: String] = [:] {
        didSet {
            for (categoryName, _) in categoryDictionary {
                let categoryInfo = CategoryInfoForCell(categoryName: categoryName, episodeCount: Int.random(in: 70...100))
                podcasts.append(categoryInfo)
            }
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollection()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollection() {
        seeAllButton.addTarget(self, action: #selector(seeAllButtomPressed), for: .touchUpInside)
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    @objc private func seeAllButtomPressed(_ sender: UIButton) {
        if sender.isSelected {
            layout.scrollDirection = .horizontal
        } else {
            layout.scrollDirection = .vertical
        }
        delegate?.seeAllButtonPressed(sender.isSelected)
        sender.isSelected = !sender.isSelected
    }
    
    
    private func setupConstraints() {
        addSubview(categoryLabel)
        addSubview(seeAllButton)
        self.addSubview(collectionView)
    
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: topAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
//            seeAllButton.topAnchor.constraint(equalTo: topAnchor),
            seeAllButton.rightAnchor.constraint(equalTo: rightAnchor),
            seeAllButton.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
//            seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//MARK: - Extensions
extension TrendingCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.identifier, for: indexPath) as? CategoriesCell else {
            return UICollectionViewCell()
        }
        
        let category = podcasts[indexPath.row]
        cell.configureCell(categoryName: category.categoryName, episodeCount: category.episodeCount)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if seeAllButton.isSelected {
            return CGSize(width: frame.width / 2 - 5, height: 200)
        }
        return CGSize(width: 144, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPodcast = podcasts[indexPath.item]
        delegate?.didSelectPodcastName(selectedPodcast)
    }
}

//MARK: - Protocols
protocol TrendingCollectionViewDelegate: AnyObject {
    func didSelectPodcastName(_ selectedPodcast: CategoryInfoForCell)
    func seeAllButtonPressed(_ isSelected: Bool)
}
