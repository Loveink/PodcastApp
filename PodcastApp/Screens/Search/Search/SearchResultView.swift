//
//  SearchResultView.swift
//  PodcastApp
//
//  Created by Владимир on 27.09.2023.
//

import UIKit

class SearchResultView: UIView {

    let topDivisionView = UIView()
    
    let titleLabel = UILabel.makeLabel(text: "Baby Pesut Podcast", font: .manropeBold(size: 16), textColor: .black)
    let imageView = UIImageView()
    let episodesCounter = UILabel.makeLabel(text: "56 Eps",font: .manropeRegular(size: 14), textColor: .gray)
    let verticalDivisionView = UIView()
    let creatorNameTitle = UILabel.makeLabel(text: "Dr. Oi om jean", font: .manropeRegular(size: 14), textColor: .gray)
    
    
    
    init() {
        super.init(frame: .zero)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configureView(_ title: String, _ image: UIImage, _ episodes: String, _ creator: String) {
        titleLabel.text = title
        imageView.image = image
        episodesCounter.text = episodes
        creatorNameTitle.text = creator
    }
    
    
    
    private func configureUI() {
        backgroundColor = .none
        
        topDivisionView.backgroundColor = .lightGray
        topDivisionView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.backgroundColor = .black
        imageView.image = UIImage(systemName: "photo.fill")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        episodesCounter.translatesAutoresizingMaskIntoConstraints = false
        
        verticalDivisionView.backgroundColor = .lightGray
        verticalDivisionView.translatesAutoresizingMaskIntoConstraints = false
        
        creatorNameTitle.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setConstraints() {
        addSubview(topDivisionView)
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(episodesCounter)
        addSubview(verticalDivisionView)
        addSubview(creatorNameTitle)
        
        NSLayoutConstraint.activate([
            topDivisionView.leftAnchor.constraint(equalTo: leftAnchor),
            topDivisionView.rightAnchor.constraint(equalTo: rightAnchor),
            topDivisionView.topAnchor.constraint(equalTo: topAnchor),
            topDivisionView.heightAnchor.constraint(equalToConstant: 1),
            
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: topDivisionView.bottomAnchor, constant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 56),
            imageView.widthAnchor.constraint(equalToConstant: 56),
            
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 15),
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            episodesCounter.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 15),
            episodesCounter.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            episodesCounter.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            verticalDivisionView.leftAnchor.constraint(equalTo: episodesCounter.rightAnchor, constant: 10),
            verticalDivisionView.topAnchor.constraint(equalTo: episodesCounter.topAnchor, constant: 5),
            verticalDivisionView.bottomAnchor.constraint(equalTo: episodesCounter.bottomAnchor, constant: -5),
            verticalDivisionView.widthAnchor.constraint(equalToConstant: 1),
            
            creatorNameTitle.leftAnchor.constraint(equalTo: verticalDivisionView.rightAnchor, constant: 10),
            creatorNameTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            creatorNameTitle.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }

}
