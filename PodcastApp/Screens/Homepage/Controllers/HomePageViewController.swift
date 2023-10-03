//
//  HomePageViewController.swift
//  4321Table
//
//  Created by Максим Нурутдинов on 30.09.2023.
//

import UIKit

final class HomePageViewController: UIViewController {
    let cellReuseIdentifier = "Cell"
    
    let topСollectionView: UICollectionView
    let averageСollectionView: UICollectionView
    let lowerCollectionView: UICollectionView
    
    init() {
        let layoutOne = UICollectionViewFlowLayout()
        layoutOne.scrollDirection = .horizontal
        topСollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutOne)
        
        let layoutTwo = UICollectionViewFlowLayout()
        layoutTwo.scrollDirection = .horizontal
        averageСollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutTwo)
        
        let layoutThre = UICollectionViewFlowLayout()
        layoutThre.scrollDirection = .vertical
        lowerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutThre)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        topСollectionView.reloadData()
        averageСollectionView.reloadData()
        lowerCollectionView.reloadData()
    }
}
