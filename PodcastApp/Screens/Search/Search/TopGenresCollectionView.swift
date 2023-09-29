//
//  TopGenresCollectionView.swift
//  PodcastApp
//
//  Created by Владимир on 26.09.2023.
//

import UIKit

class TopGenresCollectionView: UICollectionView {

    init(frame: CGRect) {
        let layout = UICollectionViewLayout()
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
