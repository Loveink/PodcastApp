//
//  ChangePictureView.swift
//  PodcastApp
//
//  Created by Caroline Tikhomirova on 03.10.2023.
//

import UIKit

class ChangePictureView: UIView {

    //MARK: - UI Components
    
    private let titleLabel = UILabel.makeLabel(text: "Change you picture", font: UIFont.plusJakartaSansSemiBold(size: 20), textColor: .black)
    
    private let lineView: UIView = {
        let line = UIView()
        line.layer.borderWidth = 1
        line.layer.borderColor = UIColor.lightGray.cgColor
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    private let takePhotoButton = ChangePictureButton(withStyle: .takeAPhoto)
    private let choosePhotoButton = ChangePictureButton(withStyle: .chooseFrom)
    private let deletePhotoButton = ChangePictureButton(withStyle: .deletePhoto)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.contentMode = .scaleAspectFit
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Unit
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 12
    }
    
    //MARK: - Layout
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(lineView)
        addSubview(stackView)
        
        stackView.addArrangedSubview(takePhotoButton)
        stackView.addArrangedSubview(choosePhotoButton)
        stackView.addArrangedSubview(deletePhotoButton)

        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            lineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    

}
