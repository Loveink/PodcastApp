//
//  HomePageViewController.swift
//  4321Table
//
//  Created by Максим Нурутдинов on 30.09.2023.
//

import UIKit

struct CollectionViews {

    static func collectionViewTwo() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionViewTwo = UICollectionView(frame: CGRect(x: 32, y: 184, width: 500, height: 200), collectionViewLayout: layout)
        collectionViewTwo.showsHorizontalScrollIndicator = false
        return collectionViewTwo
    }

    static func collectionViewOne() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionViewOne = UICollectionView(frame: CGRect(x: 32, y: 468, width: 330, height: 216), collectionViewLayout: layout)
        collectionViewOne.showsHorizontalScrollIndicator = false
        collectionViewOne.showsVerticalScrollIndicator = false
        return collectionViewOne
    }
    
    static func collectionViewThree() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionViewThree = UICollectionView(frame: CGRect(x: 32, y: 328, width: 500, height: 44), collectionViewLayout: layout)
        collectionViewThree.showsHorizontalScrollIndicator = false
        return collectionViewThree
    }
}

class HomePageViewController: UIViewController {
    let cellReuseIdentifier = "MyCollectionViewCell3"
    let collectionViewOne = CollectionViews.collectionViewOne()
    let collectionViewTwo = CollectionViews.collectionViewTwo()
    let collectionViewThree = CollectionViews.collectionViewThree()
    var myArray = CollectionViewCell3.id
    var myArray2 = CollectionViewCell2.id
    var myArray3 = CollectionViewCell1.id

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        
    }
}

// MARK: - UICollectionViewDataSource
extension HomePageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewOne {
//               return myArray.count
            return 5
           } else {
//               return myArray2.count
               return 5
           }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewOne {
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
        if collectionView == self.collectionViewOne {
            return CGSize(width: 311, height: 72)
        } else {
            return CGSize(width: 144, height: 200)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == self.collectionViewOne {
            return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 10)
        } else {
            return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 10)
        }
    }
}

extension HomePageViewController {

    func setupCollection() {
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
