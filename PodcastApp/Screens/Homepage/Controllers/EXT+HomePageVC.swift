//
//  EXT+HomePageVC.swift
//  PodcastApp
//
//  Created by Максим Нурутдинов on 02.10.2023.
//

import UIKit

// MARK: - UICollectionViewDataSource
extension HomePageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.topСollectionView {
            return 5
        } else if collectionView == self.averageСollectionView {
            return 5
        } else {
            return 5 // Для новой коллекции
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.topСollectionView {
            let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath as IndexPath)
            
            myCell.backgroundColor = R.Colors.cellBackground
            myCell.layer.cornerRadius = 16
            myCell.layer.shadowColor = UIColor.black.cgColor
            myCell.layer.shadowOffset = CGSize(width: 0, height: 2) // Смещение тени (по горизонтали и вертикали)
            myCell.layer.shadowRadius = 4 // Радиус тени (чем больше, тем более размытой будет тень)
            myCell.layer.shadowOpacity = 0.2 // Прозрачность тени (0 - полностью прозрачная, 1 - полностью непрозрачная)
            myCell.layer.masksToBounds = false // Это позволяет тени выходить за границы ячейки
            
            return myCell
        } else if collectionView == self.averageСollectionView {
            let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath as IndexPath)
            myCell.backgroundColor = R.Colors.cellBackground
            myCell.layer.cornerRadius = 16
            myCell.layer.shadowColor = UIColor.black.cgColor
            myCell.layer.shadowOffset = CGSize(width: 0, height: 2) // Смещение тени (по горизонтали и вертикали)
            myCell.layer.shadowRadius = 4 // Радиус тени (чем больше, тем более размытой будет тень)
            myCell.layer.shadowOpacity = 0.2 // Прозрачность тени (0 - полностью прозрачная, 1 - полностью непрозрачная)
            myCell.layer.masksToBounds = false // Это позволяет тени выходить за границы ячейки
            return myCell
        } else {
            let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath as IndexPath)
            myCell.backgroundColor = R.Colors.cellBackground
            myCell.layer.cornerRadius = 16
            myCell.layer.shadowColor = UIColor.black.cgColor
            myCell.layer.shadowOffset = CGSize(width: 0, height: 2) // Смещение тени (по горизонтали и вертикали)
            myCell.layer.shadowRadius = 4 // Радиус тени (чем больше, тем более размытой будет тень)
            myCell.layer.shadowOpacity = 0.2 // Прозрачность тени (0 - полностью прозрачная, 1 - полностью непрозрачная)
            myCell.layer.masksToBounds = false // Это позволяет тени выходить за границы ячейки
            return myCell
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension HomePageViewController:  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.topСollectionView  {
            return CGSize(width: 144, height: 200)
            
        } else if collectionView == self.averageСollectionView{
            return CGSize(width: 120, height: 44)
        } else {
            return CGSize(width: view.bounds.width - 64, height: 72)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == self.topСollectionView {
            return UIEdgeInsets(top: 10, left: 32, bottom: 10, right: 10)
        } else if collectionView == self.averageСollectionView {
            return UIEdgeInsets(top: 10, left: 32, bottom: 10, right: 10)
        } else {
            return UIEdgeInsets(top: 10, left: 32, bottom: 10, right: 32)
        }
    }
}

extension HomePageViewController {
    
    func setupCollection() {
        view.backgroundColor = R.Colors.background
        
        view.addSubview(stackView1)
        stackView1.addArrangedSubview(title1)
        stackView1.addArrangedSubview(subtitle1)
        
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 57),
            stackView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView1.heightAnchor.constraint(equalToConstant: 49),
            stackView1.widthAnchor.constraint(equalToConstant: 186),
        ])
        
        
        view.addSubview(imagePinkView)
        imagePinkView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imagePinkView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56),
            imagePinkView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            imagePinkView.heightAnchor.constraint(equalToConstant: 56),
            imagePinkView.widthAnchor.constraint(equalToConstant: 56),
        ])
        
        view.addSubview(labelCategory)
        labelCategory.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelCategory.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 144),
            labelCategory.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
        ])
        
        view.addSubview(labelSeeAll)
        labelSeeAll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelSeeAll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 144),
            labelSeeAll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
        
        view.addSubview(topСollectionView)
        topСollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topСollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 184),
            topСollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topСollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0),
            topСollectionView.heightAnchor.constraint(equalToConstant: 216)
        ])
        
        topСollectionView.delegate = self
        topСollectionView.dataSource = self
        topСollectionView.register(TopСollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        topСollectionView.showsHorizontalScrollIndicator = false
        
        
        view.addSubview(averageСollectionView)
        averageСollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            averageСollectionView.topAnchor.constraint(equalTo: topСollectionView.bottomAnchor, constant: 10),
            averageСollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            averageСollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0),
            averageСollectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        averageСollectionView.delegate = self
        averageСollectionView.dataSource = self
        averageСollectionView.register(AverageСollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        averageСollectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(lowerCollectionView)
        lowerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let height = 74
        NSLayoutConstraint.activate([
            lowerCollectionView.topAnchor.constraint(equalTo: averageСollectionView.bottomAnchor, constant: 10),
            lowerCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            lowerCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0),
            lowerCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 30),
            lowerCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(height * 5))
        ])
        
        lowerCollectionView.delegate = self
        lowerCollectionView.dataSource = self
        lowerCollectionView.register(LowerCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        lowerCollectionView.showsVerticalScrollIndicator = false
        
    }
}

