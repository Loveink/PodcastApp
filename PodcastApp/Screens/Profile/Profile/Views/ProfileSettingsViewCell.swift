//
//  ProfileSettingsViewCell.swift
//  PodcastApp
//
//  Created by Caroline Tikhomirova on 27.09.2023.
//

import UIKit

class ProfileSettingsViewCell: UITableViewCell {
    
    static let identifier = "ProfileSettingsViewCell"
    
    private let iconBackground: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        view.layer.backgroundColor = UIColor.grayBackground.cgColor
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let icon = UIImageView()
        icon.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        icon.tintColor = .symbolsLightPurple
        icon.contentMode = .scaleAspectFill
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(systemName: "questionmark")
        return icon
    }()
    
    private let titleLabel = UILabel.makeLabelForCells(text: "line", font: .manropeRegular(size: 16), textColor: .textDarkPurple, numberOfLines: 0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.selectionStyle = .none
            setupView()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(iconBackground)
        iconBackground.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        backgroundColor = .clear
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
            iconBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            iconImageView.centerYAnchor.constraint(equalTo: iconBackground.centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: iconBackground.centerXAnchor),
            //            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            //            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.centerYAnchor.constraint(equalTo: iconBackground.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconBackground.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            
            
        ])
        
    }
    
    func configure(image: UIImage, title: String) {
        iconImageView.image = image
        titleLabel.text = title
        
        
    }

}
