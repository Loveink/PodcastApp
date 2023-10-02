//
//  WABaseController.swift
//  4321Table
//
//  Created by Максим Нурутдинов on 30.09.2023.
//

import UIKit

class collectionViews {

    
    
    static func collectionViewTwo() -> UICollectionView {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionViewTwo = UICollectionView(frame: CGRect(x: 32, y: 0, width: 250, height: 250), collectionViewLayout: layout)
        collectionViewTwo.showsHorizontalScrollIndicator = false
        return collectionViewTwo
        
    }
    
    static func collectionViewOne() -> UICollectionView {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionViewOne = UICollectionView(frame: CGRect(x: 32, y: 250, width: 311, height: 216), collectionViewLayout: layout)
        collectionViewOne.showsHorizontalScrollIndicator = false
        return collectionViewOne
        
    }
    
    
}

class HomePageViewController3: UIViewController {
    
    
    let collectionViewOne = collectionViews.collectionViewOne()
    let collectionViewTwo = collectionViews.collectionViewTwo()
    var myArray = CollectionViewCell3.id
    var myArray2 = CollectionViewCell2.id
    
    
    let cellReuseIdentifier = "MyCollectionViewCell3"
    
//    let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .white
//        return collectionView
//    }()
//
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.Colors.background

        
        collectionViewOne.delegate = self
        collectionViewOne.dataSource = self
        collectionViewOne.register(CollectionViewCell3.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        view.addSubview(collectionViewOne)


        collectionViewTwo.delegate = self
        collectionViewTwo.dataSource = self
        collectionViewTwo.register(CollectionViewCell2.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        view.addSubview(collectionViewTwo)
        
    }
}

// MARK: - UICollectionViewDataSource
extension HomePageViewController3: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionViewOne {
               return myArray.count
           } else {
               return myArray2.count
           }
        
        // Верните количество ячеек, которые вы хотите отобразить
//        return cellReuseIdentifier.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionViewOne {
               let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath as IndexPath)

//               myCell.backgroundColor = R.Colors.background

               return myCell

           } else {

               let myCell2 = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath as IndexPath)

//               myCell2.backgroundColor = UIColor.blue

               return myCell2
           }

       }
//        customMyCell()
        
    }


// MARK: - UICollectionViewDelegateFlowLayout
extension HomePageViewController3:  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionViewOne {
                    return CGSize(width: 311, height: 72)
                } else {
                    return CGSize(width: 250, height: 250)
                }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Установите отступы для левого и правого краев (32 пикселя с левой стороны)
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

//@objc extension HomePageViewController3 {

//    func customMyCell() -> UICollectionViewCell {
//        let indexPath = IndexPath()
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CollectionViewCell3
//        cell.backgroundColor = R.Colors.cellBackground
//        cell.layer.cornerRadius = 16
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 2) // Смещение тени (по горизонтали и вертикали)
//        cell.layer.shadowRadius = 4 // Радиус тени (чем больше, тем более размытой будет тень)
//        cell.layer.shadowOpacity = 0.2 // Прозрачность тени (0 - полностью прозрачная, 1 - полностью непрозрачная)
//        cell.layer.masksToBounds = false // Это позволяет тени выходить за границы ячейки
//        return cell
//    }

//    func configureAppearance() {
//        collectionView.backgroundColor = R.Colors.background
//
//        collectionView.register(CollectionViewCell3.self, forCellWithReuseIdentifier: cellReuseIdentifier)
//
//        collectionView.dataSource = self
//        collectionView.delegate = self
//
//        view.addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//        ])
//
//        view.backgroundColor = R.Colors.background
//    }
//}

