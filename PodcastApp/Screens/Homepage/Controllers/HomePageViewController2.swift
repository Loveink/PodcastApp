//
//  HomePageViewController2.swift
//  4321Table
//
//  Created by Максим Нурутдинов on 30.09.2023.
//

import UIKit

class HomePageViewController2: UIViewController {
    
    let cellReuseIdentifier = "MyCollectionViewCell2"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
}

// MARK: - UICollectionViewDataSource
extension HomePageViewController2: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Верните количество ячеек, которые вы хотите отобразить
        return cellReuseIdentifier.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        customMyCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomePageViewController2:  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Установите размеры ячейки
        return CGSize(width: 144, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Установите отступы для левого и правого краев (32 пикселя с левой стороны)
        return UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
    }
}

@objc extension HomePageViewController2 {
    
    func customMyCell() -> UICollectionViewCell {
        let indexPath = IndexPath()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CollectionViewCell2
        cell.backgroundColor = R.Colors.cellBackground
        cell.layer.cornerRadius = 16
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2) // Смещение тени (по горизонтали и вертикали)
        cell.layer.shadowRadius = 4 // Радиус тени (чем больше, тем более размытой будет тень)
        cell.layer.shadowOpacity = 0.2 // Прозрачность тени (0 - полностью прозрачная, 1 - полностью непрозрачная)
        cell.layer.masksToBounds = false // Это позволяет тени выходить за границы ячейки
//        cell.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        return cell
    }
    
    func configureAppearance() {
        collectionView.backgroundColor = R.Colors.background
     
        collectionView.register(CollectionViewCell2.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
      
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: 220),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.backgroundColor = R.Colors.background
    }
}
