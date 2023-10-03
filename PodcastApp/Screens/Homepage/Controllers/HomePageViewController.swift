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
    let labelCategory = UILabel.makeLabel(text: "Category", font: .manropeBold(size: 16), textColor: .textBlack)
    let labelSeeAll = UILabel.makeLabel(text: "See all", font: .manropeBold(size: 16), textColor: .textGrey)

    let imagePinkView: UIImageView = {
        let imagePinkView = UIImageView()
        imagePinkView.image = R.Images.Overview.imagePink
        imagePinkView.layer.cornerRadius = 16
        imagePinkView.layer.masksToBounds = true
        imagePinkView.layer.shadowColor = UIColor.black.cgColor
        imagePinkView.layer.shadowOffset = CGSize(width: 0, height: 2) // Смещение тени (по горизонтали и вертикали)
        imagePinkView.layer.shadowRadius = 4 // Радиус тени (чем больше, тем более размытой будет тень)
        imagePinkView.layer.shadowOpacity = 0.2 // Прозрачность тени (0 - полностью прозрачная, 1 - полностью непрозрачная)
        return imagePinkView
    }()
    
    let stackView1: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 3
        return view
    }()
    
    let title1 = UILabel.makeLabel(text: "Title", font: .manropeBold(size: 14), textColor: .textBlack)
    let subtitle1 = UILabel.makeLabel(text: "subtitle", font: .manropeRegular(size: 14), textColor: .textGrey)
 
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
