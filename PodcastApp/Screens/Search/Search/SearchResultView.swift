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
    let episodesCounterLabel = UILabel.makeLabel(font: .manropeRegular(size: 14), textColor: .gray)
    
    
    
    init() {
        super.init(frame: .zero)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configureView(_ podcastItem: PodcastItemCell) {
        titleLabel.text = podcastItem.title
        fetchEpisodes(podcastItem.id)
        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: URL(string: podcastItem.image))
        }
    }
    
    
    func makeVisible() {
        episodesCounterLabel.isHidden = false
        imageView.isHidden = false
        imageView.isHidden = false
        titleLabel.isHidden = false
    }
    
    
    func makeInvisible() {
        episodesCounterLabel.isHidden = true
        imageView.isHidden = true
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
        
        episodesCounterLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setConstraints() {
        addSubview(topDivisionView)
        addSubview(title)
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(episodesCounterLabel)
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
            
            episodesCounterLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 15),
            episodesCounterLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            episodesCounterLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }

}


extension SearchResultView {
    private func fetchEpisodes(_ channelID: Int) {
        let networkService = NetworkService()
        networkService.fetchData(forPath: "/episodes/byfeedid?id=\(channelID)") { [weak self] (result: Result<EpisodeFeed, APIError>) in
            guard self != nil else { return }
            switch result {
            case .success(let podcastResponse):
                DispatchQueue.main.async {
                    self!.episodesCounterLabel.text = "\(podcastResponse.count) Eps"
                }
            case .failure(let error):
                print("SearchResultView Error: \(error)")
            }
        }
    }
}
