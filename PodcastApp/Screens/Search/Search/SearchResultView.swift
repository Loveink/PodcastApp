//
//  SearchResultView.swift
//  PodcastApp
//
//  Created by Владимир on 27.09.2023.
//

import UIKit

class SearchResultView: UIView {

    let topDivisionView = UIView()
    let title = UILabel.makeLabel(text: "Search Result", font: .manropeBold(size: 14), textColor: .black)
    
    let button = UIButton()
    let titleLabel = UILabel.makeLabel(font: .manropeBold(size: 16), textColor: .black)
    let imageView = UIImageView()
    let episodesCounter = UILabel.makeLabel(font: .manropeRegular(size: 14), textColor: .gray)
    let verticalDivisionView = UIView()
    let creatorNameTitle = UILabel.makeLabel(font: .manropeRegular(size: 14), textColor: .gray)
    
    
    
    init() {
        super.init(frame: .zero)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configureView(_ podcastItem: PodcastItemCell) {
        print("configureView")
        titleLabel.text = podcastItem.title
        episodesCounter.text = "56 Eps"
        creatorNameTitle.text = "Dr. Oi om jean"
        
        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: URL(string: podcastItem.image))
        }
    }
    
    
    func makeVisible() {
        creatorNameTitle.isHidden = false
        episodesCounter.isHidden = false
        imageView.isHidden = false
        verticalDivisionView.isHidden = false
        titleLabel.isHidden = false
    }
    
    
    func makeInvisible() {
        creatorNameTitle.isHidden = true
        episodesCounter.isHidden = true
        imageView.isHidden = true
        verticalDivisionView.isHidden = true
        titleLabel.isHidden = true
        titleLabel.text = ""
    }
    
    
    
    private func configureUI() {
        backgroundColor = .none
        
        button.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        
        topDivisionView.backgroundColor = .lightGray
        topDivisionView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.adjustsFontSizeToFitWidth = false
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.borderWidth = 1
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
        addSubview(title)
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(episodesCounter)
        addSubview(verticalDivisionView)
        addSubview(creatorNameTitle)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.rightAnchor.constraint(equalTo: rightAnchor),
            button.leftAnchor.constraint(equalTo: leftAnchor),
            
            topDivisionView.leftAnchor.constraint(equalTo: leftAnchor),
            topDivisionView.rightAnchor.constraint(equalTo: rightAnchor),
            topDivisionView.topAnchor.constraint(equalTo: topAnchor),
            topDivisionView.heightAnchor.constraint(equalToConstant: 1),
            
            title.topAnchor.constraint(equalTo: topDivisionView.topAnchor, constant: 25),
            title.leftAnchor.constraint(equalTo: topDivisionView.leftAnchor),
            
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: title.topAnchor, constant: 37),
            imageView.heightAnchor.constraint(equalToConstant: 56),
            imageView.widthAnchor.constraint(equalToConstant: 56),
            
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 15),
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.centerYAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            
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
