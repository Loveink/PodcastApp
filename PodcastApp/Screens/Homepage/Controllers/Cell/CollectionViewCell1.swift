//
//  File.swift
//  PodcastApp
//
//  Created by Максим Нурутдинов on 02.10.2023.
//

import UIKit

final class CollectionViewCell1: UICollectionViewCell {
    static let id = "CollectionViewCell1"
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 3
        return view
    }()
    
    private let title2 = UILabel.makeLabel(text: "title2", font: .manropeBold(size: 14), textColor: .textGrey)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        constaintViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        setupViews()
        constaintViews()
    }
}

private extension CollectionViewCell1 {
    func setupViews() {
        setupView(stackView)
        stackView.setupView(title2)
    }
    
    func constaintViews() {
        NSLayoutConstraint.activate([
            
//            title2.topAnchor.constraint(equalTo: topAnchor,constant: 14),
//            title2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        ])
    }
}

