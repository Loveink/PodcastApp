//
//  WABaseController.swift
//  4321Table
//
//  Created by Максим Нурутдинов on 30.09.2023.
//

import UIKit

class HomePageViewController3: UIViewController {
    let cellReuseIdentifier = "MyCollectionViewCell3"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
}

// MARK: - UICollectionViewDataSource
extension HomePageViewController3: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Верните количество ячеек, которые вы хотите отобразить
        return cellReuseIdentifier.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        customMyCell()
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomePageViewController3:  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Установите размеры ячейки
        return CGSize(width: 311, height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Установите отступы для левого и правого краев (32 пикселя с левой стороны)
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

@objc extension HomePageViewController3 {

    func customMyCell() -> UICollectionViewCell {
        let indexPath = IndexPath()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CollectionViewCell3
        cell.backgroundColor = R.Colors.cellBackground
        cell.layer.cornerRadius = 16
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2) // Смещение тени (по горизонтали и вертикали)
        cell.layer.shadowRadius = 4 // Радиус тени (чем больше, тем более размытой будет тень)
        cell.layer.shadowOpacity = 0.2 // Прозрачность тени (0 - полностью прозрачная, 1 - полностью непрозрачная)
        cell.layer.masksToBounds = false // Это позволяет тени выходить за границы ячейки
        return cell
    }

    func configureAppearance() {
        collectionView.backgroundColor = R.Colors.background

        collectionView.register(CollectionViewCell3.self, forCellWithReuseIdentifier: cellReuseIdentifier)

        collectionView.dataSource = self
        collectionView.delegate = self

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        view.backgroundColor = R.Colors.background
    }
}

